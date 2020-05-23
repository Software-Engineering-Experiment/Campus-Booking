package org.mycom.campus_book.web;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import org.mycom.campus_book.dto.BookExecution;
import org.mycom.campus_book.dto.Result;
import org.mycom.campus_book.entity.Reservation;
import org.mycom.campus_book.entity.SpareTime;
import org.mycom.campus_book.entity.Student;
import org.mycom.campus_book.entity.Teacher;
import org.mycom.campus_book.entity.Administrator;
import org.mycom.campus_book.enums.BookStateEnum;
import org.mycom.campus_book.service.Campus_bookService;
import org.mycom.campus_book.exception.RepeatAppointException;
import org.mycom.campus_book.exception.NoNumberException;
 
@Controller
@RequestMapping("/spareTimes")
public class Campus_bookController {
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private Campus_bookService campus_bookService;
	
	//获取SpareTime列表
	@RequestMapping(value="/{studentId}/list",method = RequestMethod.GET)
	private String List(@PathVariable("studentId") Long studentId,Model model){
		Student student = campus_bookService.queryByStudentId(studentId);
		List<SpareTime> list = campus_bookService.getList();
		model.addAttribute("list", list);	
		model.addAttribute("student",student);
		
		return "list";
		}
	
	
	
	//获取老师主界面列表
		@RequestMapping(value="/{teacherId}/teacherList",method = RequestMethod.GET)
		private String TeacherList(@PathVariable("teacherId") Long teacherId,Model model){
			Teacher teacher = campus_bookService.queryTeacherId(teacherId);
			List<SpareTime> teacherList = campus_bookService.getByTeacherId(teacherId);
			model.addAttribute("teacherList", teacherList);	
			model.addAttribute("teacher",teacher);
			
			return "teacherList";
			}
		
	//获取管理员主界面列表
		@RequestMapping(value="/{adminId}/adminList",method = RequestMethod.GET)
		private String AdminList(@PathVariable("adminId") Long adminId,Model model){
				model.addAttribute("adminId", adminId);
				return "adminList";
					}	
		
		//管理员获取学生列表
		@RequestMapping(value="/{adminId}/adminStudent",method = RequestMethod.GET)
		private String AdminStudent(@PathVariable("adminId") Long adminId,Model model){
			List<Student> students = campus_bookService.getStudentList();
			model.addAttribute("students",students);
			model.addAttribute("adminId", adminId);	
			return "adminStudent";
			}
		
		//管理员获取教师列表
		@RequestMapping(value="{adminId}/adminTeacher",method = RequestMethod.GET)
		private String adminTeacher(@PathVariable("adminId") Long adminId,Model model){
			
			List<Teacher> teachers = campus_bookService.getTeacherList();
			model.addAttribute("teachers",teachers);
			model.addAttribute("adminId", adminId);
			return "adminTeacher";
			}
		
		//管理员查看预约信息	
		@RequestMapping(value="/{adminId}/adminReservation", method = RequestMethod.GET)
		private String adminReservation(@PathVariable("adminId") Long adminId,Model model) {
			List<Reservation> reservations = campus_bookService.getReservationList();
			model.addAttribute("reservations", reservations);
			model.addAttribute("adminId", adminId);
			return "adminReservation";
		}
		
		
		//管理员查看空闲时间信息	
		@RequestMapping(value="/{adminId}/adminSpareTime", method = RequestMethod.GET)
		private String adminSpareTime(@PathVariable("adminId") Long adminId,Model model) {
			List<SpareTime> spareTimes = campus_bookService.getList();
			model.addAttribute("spareTimes", spareTimes);
			model.addAttribute("adminId", adminId);
			return "adminSpareTime";
		}
		
		
		//根据老师名字模糊查询空闲时间表信息，管理员功能
		@RequestMapping(value="/{adminId}/spareTime/search",method = RequestMethod.POST)
		private void  SparetimeSearch(@PathVariable("adminId") Long adminId,HttpServletRequest req,HttpServletResponse resp) 
									throws ServletException, IOException{
			//接收页面的值
			req.setCharacterEncoding("UTF-8");
			String teacherName = req.getParameter("teacherName");
			teacherName = teacherName.trim();
			
			//向页面传值
			req.setAttribute("teacherName", teacherName);
			req.setAttribute("spareTimes", campus_bookService.getSomeListByTeacherName(teacherName)); 
			req.setAttribute("adminId",adminId);
			req.getRequestDispatcher("/WEB-INF/jsp/adminSpareTime.jsp").forward(req, resp); 
		}
		
		
		//管理员查看某条sparetime预约的详细情况,查看预约该条信息的学生详情
		@RequestMapping(value = "/{adminId}/{id}/SpareTimeDetail", method = RequestMethod.GET)
		private String SpareTimeDetail(@PathVariable("adminId") Long adminId, @PathVariable("id") Long id,Model model){
			if(id==null){
				return "redict:/index.jsp";
			}	
			List<Reservation> reservations = campus_bookService.getReservationById(id);
			if(reservations==null){
				return "forward:/index.jsp"; 
			}
			model.addAttribute("reservations",reservations);
			model.addAttribute("adminId", adminId);
			System.out.println(reservations);
			return "SpareTimeDetail";
		}
		
		
		
		
		//根据教师名字模糊查询教师信息
		@RequestMapping(value="/{adminId}/teacher/search",method = RequestMethod.POST)
		private void  TeacherSearch(@PathVariable("adminId") Long adminId,HttpServletRequest req,HttpServletResponse resp) 
									throws ServletException, IOException{
			//接收页面的值
			req.setCharacterEncoding("UTF-8");
			String teacherName = req.getParameter("teacherName");
			teacherName = teacherName.trim();
			
			//向页面传值
			req.setAttribute("teacherName", teacherName);
			req.setAttribute("teachers", campus_bookService.getSomeTeacherByTeacherName(teacherName)); 
			req.setAttribute("adminId",adminId);
			req.getRequestDispatcher("/WEB-INF/jsp/adminTeacher.jsp").forward(req, resp); 
		}
		
		
		
	//根据老师名字模糊查询sparetime记录
		@RequestMapping(value="/{studentId}/search",method = RequestMethod.POST)
		private void  search(@PathVariable("studentId") Long studentId,HttpServletRequest req,HttpServletResponse resp) 
									throws ServletException, IOException{
			//接收页面的值
			req.setCharacterEncoding("UTF-8");
			String teacherName = req.getParameter("teacherName");
			teacherName = teacherName.trim();
			
			//向页面传值
			req.setAttribute("teacherName", teacherName);
			req.setAttribute("list", campus_bookService.getSomeListByTeacherName(teacherName)); 
			req.setAttribute("student",campus_bookService.queryByStudentId(studentId));
			req.getRequestDispatcher("/WEB-INF/jsp/list.jsp").forward(req, resp); 
		}
		
		//根据学生姓名模糊查询spareTime记录
		@RequestMapping(value="/{adminId}/student/search",method = RequestMethod.POST)
		private void  StudentSearch(@PathVariable("adminId") Long adminId,HttpServletRequest req,HttpServletResponse resp) 
									throws ServletException, IOException{
			//接收页面的值
			req.setCharacterEncoding("UTF-8");
			String studentName = req.getParameter("studentName");
			studentName = studentName.trim();
			
			//向页面传值
			req.setAttribute("studentName", studentName);
			req.setAttribute("students", campus_bookService.getSomeStudentByStudentName(studentName));
			req.setAttribute("adminId", adminId);
			req.getRequestDispatcher("/WEB-INF/jsp/adminStudent.jsp").forward(req, resp); 
		}
		
		
		//管理员根据老师姓名搜索预约信息，模糊查询
		@RequestMapping(value="/{adminId}/reservation/search",method = RequestMethod.POST)
		private void ReservationSearch(@PathVariable("adminId")Long adminId,HttpServletRequest req,HttpServletResponse res)
								throws ServletException,IOException {
			req.setCharacterEncoding("UTF-8");
			String teacherName = req.getParameter("teacherName");
			List<Reservation> reservations=campus_bookService.getReservationByTeacherName(teacherName);	
			req.setAttribute("teacherName", teacherName);
			req.setAttribute("reservations", reservations);
			req.setAttribute("adminId", adminId);
			req.getRequestDispatcher("/WEB-INF/jsp/adminReservation.jsp").forward(req, res);

		}
		
		
		
		
		//查看某sparetime的详细情况
		@RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
		private String detail(@PathVariable("id") Long id, Model model){
			if(id==null){
				return "redict:/index.jsp";
			}
			SpareTime spareTime = campus_bookService.getById(id);
			if(spareTime==null){
				return "forward:/index.jsp"; 
			}
			model.addAttribute("spareTime",spareTime);
			System.out.println(spareTime);
			return "detail";
		}
		
		//老师查看某条sparetime预约的详细情况,查看预约该条信息的学生详情
		@RequestMapping(value = "/{id}/teacherDetail", method = RequestMethod.GET)
		private String teacherDetail(@PathVariable("id") Long id, Model model){
			if(id==null){
				return "redict:/index.jsp";
			}
			List<Reservation> reservations = campus_bookService.getReservationById(id);
			if(reservations==null){
				return "forward:/index.jsp"; 
			}
			model.addAttribute("reservations",reservations);
			System.out.println(reservations);
			return "teacherDetail";
		}
				
		//验证输入的用户名、密码是否正确
		@RequestMapping(value="/verify", method = RequestMethod.POST, produces = {
														"application/json; charset=utf-8" })
		@ResponseBody
		private Map validate(Long identity,Long studentId,Long password){   //(HttpServletRequest req,HttpServletResponse resp){
			Map resultMap=new HashMap(); 
			Student student = null;  
			Teacher teacher = null;
			Administrator administrator = null;
			System.out.println("验证函数"); 
			if(identity == 1) {
				student =campus_bookService.validateStu(studentId,password);
			
				System.out.println("输入的学号、密码："+studentId+":"+password);
				System.out.println("查询到的："+student.getStudentId()+":"+student.getPassword());
			
				if(student!=null){
					System.out.println("SUCCESS");
					resultMap.put("result", "SUCCESS");			
				}else{ 
					resultMap.put("result", "FAILED");
				}
			}
			else if(identity == 2) {
				teacher =campus_bookService.validateTeacher(studentId, password);
				
				System.out.println("输入的工号、密码："+studentId+":"+password);
				System.out.println("查询到的："+teacher.getTeacherId()+":"+ teacher.getPassword());
			
				if(teacher!=null){
					System.out.println("SUCCESS");
					resultMap.put("result", "SUCCESS");
				}else{ 
					resultMap.put("result", "FAILED");
				}
			}
			else if(identity == 3) {
				
				administrator =campus_bookService.validateAdministrator(studentId, password);
				
				System.out.println("输入的工号、密码："+studentId+":"+password);
				System.out.println("查询到的："+administrator.getAdminId()+":"+ administrator.getPassword());
			
				if(administrator!=null){
					System.out.println("SUCCESS");
					resultMap.put("result", "SUCCESS");
				}else{ 
					resultMap.put("result", "FAILED");
				}
			}
			return resultMap;
}
		
		//执行预约的逻辑，预约id为{id}的时间段
		@RequestMapping(value = "/{id}/book", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Result<BookExecution> execute(@PathVariable("id") Long id,@RequestParam("studentId") Long studentId){
			Result<BookExecution> result;
			BookExecution execution=null;
			
			try{//手动try catch,在调用Book方法时可能报错
				execution=campus_bookService.book(id, studentId);
				result=new Result<BookExecution>(true,execution); 
					return result; 
					
			} catch(NoNumberException e1) {
				execution=new BookExecution(id,BookStateEnum.NO_NUMBER);
				result=new Result<BookExecution>(true,execution);
					return result;
			}catch(RepeatAppointException e2){
				execution=new BookExecution(id,BookStateEnum.REPEAT_APPOINT);
				result=new Result<BookExecution>(true,execution);
					return result;
			}catch (Exception e){
				execution=new BookExecution(id,BookStateEnum.INNER_ERROR); 
				result=new Result<BookExecution>(true,execution);
					return result;
			} 
		}
		
		//根据学生id查看该学生的预约记录
		@RequestMapping(value ="/book")
		private String bookSpareTime(@RequestParam("studentId") long studentId,Model model){
			
			List<Reservation> reservations = new ArrayList<Reservation>();
			reservations = campus_bookService.getReservationByStu(studentId);
			model.addAttribute("reservations", reservations);
			 
			return "reservationList";
		}
		
		//删除预约记录
		@RequestMapping(value = "/{id}/{studentId}/del", method = RequestMethod.GET)
	    private String deleteReservationByStudent(@PathVariable("id") Long id,@PathVariable("studentId") Long studentId,Model model) {
			int i = campus_bookService.deleteReservation(studentId,id);
	        String result = null;
			if(i>0) {
	        	result = "修改成功";
	        }
	        else {
	        	result = "修改失败";
	        }	 
			model.addAttribute("result",result);
			return "deleteResult";
	    }
		
		//删除学生信息
		@RequestMapping(value="/{adminId}/student/del", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map deletetStudent(@PathVariable("adminId")Long adminId,Long studentId) {
			Map resultMap=new HashMap();   
			System.out.println("删除学生");
			int retVal=campus_bookService.deleteStudent(studentId);
			if(retVal>0) {
				System.out.println("SUCCESS");
				resultMap.put("result", "SUCCESS");
				return resultMap;
			}else {
				resultMap.put("result", "FAILED");
				return resultMap;
			}
		}
		
		//删除老师信息
		@RequestMapping(value="/{adminId}/teacher/del", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map deletetTeacher(@PathVariable("adminId")Long adminId,Long teacherId) {
			Map resultMap=new HashMap();   
			System.out.println("删除老师");
			int retVal=campus_bookService.deleteTeacher(teacherId);
			if(retVal>0) {
				System.out.println("SUCCESS");
				resultMap.put("result", "SUCCESS");
				return resultMap;
			}else {
				resultMap.put("result", "FAILED");
				return resultMap;
			}
		}
		
		//删除过时的spareTime信息
		@RequestMapping(value = "/{adminId}/admin/deleteovertime", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map DeleteOvertime(@PathVariable("adminId")Long adminId) {
			Map resultMap=new HashMap();
			System.out.println("删除过时的spareTime信息"); 
			List<SpareTime> spareTimes=campus_bookService.getAllOvertimeSpareTime();
			try {
				for(int i=0;i<spareTimes.size();++i) {
					long tmp=spareTimes.get(i).getId();
					int ret1=campus_bookService.deleteReservationById(tmp);
					int ret2=campus_bookService.deleteOvertimeSpareTime(tmp);
				}
			}
			catch(Exception e) {
				resultMap.put("result", "FAILED");
				return resultMap;
			}
			resultMap.put("result", "SUCCESS");
			return resultMap;
		}

		
		//修改学生密码
		@RequestMapping(value="/{studentId}/correct", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map correctStudentPassword(@PathVariable("studentId")Long studentId,Long password) {
			Map resultMap=new HashMap(); 
			Student student =null;  
			System.out.println("修改学生密码"); 			
			int retVal=campus_bookService.correctStudentPassword(studentId, password);
			if(retVal>0) {
				System.out.println("SUCCESS");
				resultMap.put("result", "SUCCESS");
				return resultMap;
			}else {
				resultMap.put("result", "FAILED");
				return resultMap;
			}
		}
		
		//修改学生个人信息
		@RequestMapping(value="/{studentId}/student/update", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map updateStudentInfo(@PathVariable("studentId")Long studentId,String phone,String emailAddress,String depId) {
			Map resultMap=new HashMap();
			System.out.println("修改学生个人信息"); 
			if(depId.length()!=0) {
				System.out.println("depId:"+depId);
				try {
					int retVal = campus_bookService.updateStudentDep(studentId,depId);
				}
				catch(Exception e){
					System.out.println("depId报错"); 
						resultMap.put("result", "depIdFAILED");
						return resultMap;
					}
				}
			if(phone.length()!=0) {
				System.out.print("phone:"+phone);
				try {
					int retVal = campus_bookService.updateStudentPhone(studentId,phone);
				}
				catch(Exception e){
					resultMap.put("result", "phoneFAILED");
						return resultMap;
					}
			}
			if(emailAddress.length()!=0) {
				System.out.print("emailAddress:"+emailAddress);
				try {
					int retVal = campus_bookService.updateStudentEmail(studentId,emailAddress);
				}
				catch(Exception e){
					resultMap.put("result", "emailFAILED");
					return resultMap;
					}
			}	
			resultMap.put("result", "SUCCESS");
			return resultMap;
			
			
		}
		
		//修改学生个人信息
				@RequestMapping(value="/{teacherId}/teacher/update", method = RequestMethod.POST, produces = {
				"application/json; charset=utf-8" })
				@ResponseBody
				private Map updateTeacherInfo(@PathVariable("teacherId")Long teacherId,String phone,String emailAddress,String depId,String address) {
					Map resultMap=new HashMap();
					System.out.println("修改老师个人信息"); 		
					if(depId.length()!=0) {
						System.out.println("depId:"+depId);
						try {
							int retVal = campus_bookService.updaTeteacherDep(teacherId, depId);
						}
						catch(Exception e){
							System.out.println("depId报错"); 
							resultMap.put("result", "depIdFAILED");
							return resultMap;
							}
					}
					if(phone.length()!=0) {
						System.out.print("phone:"+phone);
						try {
							int retVal = campus_bookService.updateTeacherPhone(teacherId, phone);
						}
						catch(Exception e){
							resultMap.put("result", "phoneFAILED");
							return resultMap;
							}
					}
					if(emailAddress.length()!=0) {
						System.out.print("emailAddress:"+emailAddress);
						try {
							int retVal = campus_bookService.updateTeacherEmail(teacherId, emailAddress);
						}
						catch(Exception e){
							resultMap.put("result", "emailFAILED");
							return resultMap;
							}

					}
					if(address.length()!=0) {
						System.out.print("address:"+address);
						try {
							int retVal = campus_bookService.updateTeacherAddress(teacherId, address);
						}
						catch(Exception e){
							resultMap.put("result", "addressFAILED");
							return resultMap;
							}

					}	
					resultMap.put("result", "SUCCESS");
					return resultMap;
				}
		
		
		//修改老师密码
		@RequestMapping(value="/{teacherId}/teacherCorrect", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map correctTeacherPassword(@PathVariable("teacherId")Long teacherId,Long password) {
			Map resultMap=new HashMap(); 
			Teacher teacher =null;  
			System.out.println("修改老师密码"); 			
			int retVal=campus_bookService.correctTeacherPassword(teacherId, password);
			if(retVal>0) {
				System.out.println("SUCCESS");
				resultMap.put("result", "SUCCESS");
				return resultMap;
			}else {
				resultMap.put("result", "FAILED");
				return resultMap;
			}
		}
		
		
		//修改管理员密码
				@RequestMapping(value="/{adminId}/adminCorrect", method = RequestMethod.POST, produces = {
				"application/json; charset=utf-8" })
				@ResponseBody
				private Map correctAdminPassword(@PathVariable("adminId")Long adminId,Long password) {
					Map resultMap=new HashMap(); 
					System.out.println("修改老师密码"); 			
					int retVal=campus_bookService.correctAdminPassword(adminId, password);
					if(retVal>0) {
						System.out.println("SUCCESS");
						resultMap.put("result", "SUCCESS");
						return resultMap;
					}else {
						resultMap.put("result", "FAILED");
						return resultMap;
					}
				}
				
				
		
			//老师添加spareTime信息
				@RequestMapping(value="/{teacherId}/addSpareTime", method = RequestMethod.POST, produces = {
				"application/json; charset=utf-8" })
				@ResponseBody
				private Map addSpareTime(@PathVariable("teacherId")Long teacherId,SpareTime spareTime) {
					Map resultMap=new HashMap(); 
					System.out.println("老师添加SpareTime信息"); 			
					int retVal=campus_bookService.addSpareTime(spareTime);
					if(retVal>0) {
						System.out.println("SUCCESS");
						resultMap.put("result", "SUCCESS");
						return resultMap;
					}else {
						resultMap.put("result", "FAILED");
						return resultMap;
					}
				}
				
				//重置学生密码,管理员操作
				@RequestMapping(value="/{adminId}/student/passwordReset", method = RequestMethod.POST, produces = {
				"application/json; charset=utf-8" })
				@ResponseBody
				private Map ResetStudentPassword(@PathVariable("adminId")Long adiminId,Long studentId) {
					Map resultMap=new HashMap(); 
					long password = 123456;
					System.out.println("管理员重置学生密码"); 			
					int retVal=campus_bookService.correctStudentPassword(studentId, password);
					if(retVal>0) {
						System.out.println("SUCCESS");
						resultMap.put("result", "SUCCESS");
						return resultMap;
					}else {
						resultMap.put("result", "FAILED");
						return resultMap;
					}
				}
				
				//重置老师密码,管理员操作
				@RequestMapping(value="/{adminId}/teacher/passwordReset", method = RequestMethod.POST, produces = {
				"application/json; charset=utf-8" })
				@ResponseBody
				private Map ResetTeacherPassword(@PathVariable("adminId")Long adiminId,Long teacherId) {
					Map resultMap=new HashMap(); 
					long password = 123456;
					System.out.println("管理员重置学生密码"); 			
					int retVal=campus_bookService.correctTeacherPassword(teacherId, password);
					if(retVal>0) {
						System.out.println("SUCCESS");
						resultMap.put("result", "SUCCESS");
						return resultMap;
					}else {
						resultMap.put("result", "FAILED");
						return resultMap;
					}
				}
			
				
				//导入学生界面
			   	@RequestMapping(value="/import/student",method = RequestMethod.GET)
				private String importStudent(){
					return "ImportStudent";
					}
				
				   	
				   	
				   	//导入学生
				    /** 
					    * 描述：通过 jquery.form.js 插件提供的ajax方式上传文件 
					    * @param request 
					    * @param response 
					    * @throws Exception 
					    */  

					   @RequestMapping(value="/student/ajaxUpload.action",method={RequestMethod.GET,RequestMethod.POST})  
					   @ResponseBody  
					   public String ajaxUploadExcelStudent(HttpServletRequest request,HttpServletResponse response) throws Exception {  
					       String result = campus_bookService.ajaxUploadExcelStudent(request, response);
						    System.out.print(result);
					       return result;
					   }  
					   

					    
					   	@RequestMapping(value = "/student/download.action")
						public void exportStudent(HttpServletRequest request,HttpServletResponse response) throws Exception{
						        response.reset(); //清除buffer缓存  
						        //Map<String,Object> map=new HashMap<String,Object>();  
						        // 指定下载的文件名  
						        response.setContentType("application/vnd.ms-excel;charset=UTF-8");  
						        response.setHeader("Content-Disposition","attachment;filename="+new String("学生表.xlsx".getBytes(),"iso-8859-1"));
						        //导出Excel对象  
						        XSSFWorkbook workbook = campus_bookService.exportStudentExcelInfo();
						        OutputStream output;  
						        try {  
						            output = response.getOutputStream();  
						            BufferedOutputStream bufferedOutput = new BufferedOutputStream(output);  
						            bufferedOutput.flush();  
						            workbook.write(bufferedOutput);  
						            bufferedOutput.close();  
						        } catch (IOException e) {  
						            e.printStackTrace();  
						        }
						}	
				   	
					   	
					   	
						//导入老师界面
					   	@RequestMapping(value="/import/teacher",method = RequestMethod.GET)
						private String importTeacher(){
							return "ImportTeacher";
							}
					   	
					   	
					   	//导入老师
					    /** 
						    * 描述：通过 jquery.form.js 插件提供的ajax方式上传文件 
						    * @param request 
						    * @param response 
						    * @throws Exception 
						    */  

						   @RequestMapping(value="/teacher/ajaxUpload.action",method={RequestMethod.GET,RequestMethod.POST})  
						   @ResponseBody  
						   public String ajaxUploadExcelTeacher(HttpServletRequest request,HttpServletResponse response) throws Exception {  
						       String result = campus_bookService.ajaxUploadExcelTeacher(request, response);
							    System.out.print(result);
						       return result;
						   }  
						   

						    
						   	@RequestMapping(value = "/teacher/download.action")
							public void exportTeacher(HttpServletRequest request,HttpServletResponse response) throws Exception{
							        response.reset(); //清除buffer缓存  
							        //Map<String,Object> map=new HashMap<String,Object>();  
							        // 指定下载的文件名  
							        response.setContentType("application/vnd.ms-excel;charset=UTF-8");  
							        response.setHeader("Content-Disposition","attachment;filename="+new String("教职工表.xlsx".getBytes(),"iso-8859-1"));
							        //导出Excel对象  
							        XSSFWorkbook workbook = campus_bookService.exportTeacherExcelInfo();
							        OutputStream output;  
							        try {  
							            output = response.getOutputStream();  
							            BufferedOutputStream bufferedOutput = new BufferedOutputStream(output);  
							            bufferedOutput.flush();  
							            workbook.write(bufferedOutput);  
							            bufferedOutput.close();  
							        } catch (IOException e) {  
							            e.printStackTrace();  
							        }
							}	
					   	
}



