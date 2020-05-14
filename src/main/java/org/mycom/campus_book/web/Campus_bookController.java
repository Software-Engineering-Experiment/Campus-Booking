package org.mycom.campus_book.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
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
			req.setAttribute("list", campus_bookService.getSomeList(teacherName)); 
			req.setAttribute("student",campus_bookService.queryByStudentId(studentId));
			req.getRequestDispatcher("/WEB-INF/jsp/list.jsp").forward(req, resp); 
		}
		
		//查看某sparetime的详细情况
		@RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
		private String detail(@PathVariable("id") Long id, Model model){
			if(id==null){
				return "redict:/book/list";
			}
			SpareTime spareTime = campus_bookService.getById(id);
			if(spareTime==null){
				return "forward:/book/list"; 
			}
			model.addAttribute("spareTime",spareTime);
			System.out.println(spareTime);
			return "detail";
		}
		
		//验证输入的用户名、密码是否正确
		@RequestMapping(value="/verify", method = RequestMethod.POST, produces = {
														"application/json; charset=utf-8" })
		@ResponseBody
		private Map validate(Long studentId,Long password){   //(HttpServletRequest req,HttpServletResponse resp){
			Map resultMap=new HashMap(); 
			Student student =null;  
			System.out.println("验证函数"); 
			student =campus_bookService.validateStu(studentId,password);
			
			System.out.println("输入的学号、密码："+studentId+":"+password);
			System.out.println("查询到的："+student.getStudentId()+":"+student.getPassword());
			
			if(student!=null){
				System.out.println("SUCCESS");
				resultMap.put("result", "SUCCESS");
				return resultMap;
			}else{ 
				resultMap.put("result", "FAILED");
				return resultMap;
			}
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
	    private String deleteAppointmentByBookId(@PathVariable("id") Long id,@PathVariable("studentId") Long studentId,Model model) {
	        int i = campus_bookService.deleteReservation(studentId,id);
	        String result;
	        if(i>0) {
	        	result = "删除成功";
	        }
	        else 
	        	result = "删除失败";
	        model.addAttribute("result",result);
	        return "deleteResult";
	        
	    }
		
		//修改学生密码
		@RequestMapping(value="/{studentId}/correct", method = RequestMethod.POST, produces = {
		"application/json; charset=utf-8" })
		@ResponseBody
		private Map correctStudentPassword(@PathVariable("studentId")Long studentId,Long password) {
			Map resultMap=new HashMap(); 
			Student student =null;  
			System.out.println("修改密码"); 			
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
			
}



