package org.mycom.campus_book.service.Impl;

import java.util.List;

import java.io.IOException;
import java.io.InputStream;

import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.ibatis.annotations.Param;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import org.mycom.campus_book.dao.ReservationDao;
import org.mycom.campus_book.dao.SpareTimeDao;
import org.mycom.campus_book.dao.StudentDao;
import org.mycom.campus_book.dao.TeacherDao;
import org.mycom.campus_book.dao.AdministratorDao;
import org.mycom.campus_book.dto.BookExecution;
import org.mycom.campus_book.entity.Reservation;
import org.mycom.campus_book.entity.SpareTime;
import org.mycom.campus_book.entity.Student;
import org.mycom.campus_book.entity.Teacher;
import org.mycom.campus_book.entity.Administrator;
import org.mycom.campus_book.entity.ExcelBean;
import org.mycom.campus_book.enums.BookStateEnum;
import org.mycom.campus_book.exception.BookException;
import org.mycom.campus_book.exception.NoNumberException;
import org.mycom.campus_book.exception.RepeatAppointException;
import org.mycom.campus_book.service.Campus_bookService;
import org.mycom.campus_book.utils.ExcelUtils;

@Service
public class Campus_bookServiceImpl implements Campus_bookService{
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SpareTimeDao spareTimeDao;
	
	@Autowired
	private StudentDao	studentDao;
	
	@Autowired
	private TeacherDao	teacherDao;
	
	@Autowired
	private AdministratorDao	administratorDao;
	
	@Autowired
	private ReservationDao reservationDao;
	
	
	@Override
	public SpareTime getById(long id) { 
		return spareTimeDao.queryById(id);
	}  
	
	@Override
	public List<SpareTime> getByTeacherId(long teacherId) {
		return spareTimeDao.queryByTeacherId(teacherId);
	}
	
	
	@Override
	public List<SpareTime> getList() { 
		return spareTimeDao.queryAll(0, 1000);
	} 
	
	@Override
	public List<Student> getStudentList(){
		return studentDao.queryAll(0, 1000);
	}
	
	@Override
	public List<Teacher> getTeacherList() { 
		return teacherDao.queryAll(0, 1000);
	} 
	
	@Override
	public List<Reservation> getReservationList() { 
		return reservationDao.queryAllReservation(0, 1000);
	} 

		
	
	@Override
	public List<Reservation> getReservationByTeacherId(long teacherId){
		return reservationDao.queryReservationByTeacherId(teacherId);
	}
	
	@Override
	public List<Reservation> getReservationByTeacherName(String teacherName){
		return reservationDao.queryReservationByTeacherName(teacherName);
	}
	
	
	
	@Override
	public Teacher validateTeacher(Long teacherId, Long password) {
		return teacherDao.queryTeacher(teacherId, password);
	}
	
	@Override
	public Student validateStu(Long studentId,Long password){
		return studentDao.queryStudent(studentId, password);
	}
	
	@Override
	public Administrator validateAdministrator(Long adminId,Long password){
		return administratorDao.queryAdministrator(adminId, password);
	}
	
	@Override
	public List<SpareTime> getSomeListByTeacherName(String teacherName) {
		 
		return spareTimeDao.queryByTeacherName(teacherName);
	} 
	
	@Override
	public List<Student> getSomeStudentByStudentName(String studentName) {
		 
		return studentDao.queryByStudentName(studentName);
	} 

	@Override
	public List<Teacher> getSomeTeacherByTeacherName(String teacherName) {
		 
		return teacherDao.queryByTeacherName(teacherName);
	} 
	
	
	@Override
	public List<Reservation> getReservationByStu(long studentId) {//DOTO
		return reservationDao.queryAndReturn(studentId);
	}
	
	@Override
	@Transactional
	public	BookExecution book(long id, long studentId) {//在Dao的基础上组织逻辑，形成与web成交互用的方法
		try{													  //返回成功预约的类型。	
			SpareTime spareTime = spareTimeDao.queryById(id) ;			
			if(spareTime.getReserved() >= spareTime.getMaxReserved()){//人数已满
				throw new NoNumberException("no number");
			}else{
				//执行预约操作
				int update=spareTimeDao.addReserved(id);//增加Reserved人数
				int insert=reservationDao.insertReservation(id, studentId);
				if(insert<=0){//重复预约
					throw new RepeatAppointException("repeat appoint");
				}else{//预约成功
					return new BookExecution(id,BookStateEnum.SUCCESS);
				}
				
			}
		} catch (NoNumberException e1) {
			throw e1;
		} catch (RepeatAppointException e2) {
			throw e2;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			// 所有编译期异常转换为运行期异常
			throw new BookException("appoint inner error:" + e.getMessage());
		}
	}
	
	@Override
	public int deleteReservation(long studentId,long id){
		int num=spareTimeDao.reduceReserved(id);//减少reserved人数
	    return reservationDao.deleteReservation(id,studentId);
	  }
	
	@Override
	public int deleteStudent(long studentId){
		//首先根据studentId获取id列表
		List<Long> idList=reservationDao.getIdListByStudentId(studentId);
		//根据id使对应记录的reserved减1
		for(Long id:idList) {
			spareTimeDao.reduceReserved(id);
		}
		//然后在Reservation表中删除记录
		int num=reservationDao.deleteRservationByStudentId(studentId);
		//删除学生信息
	    return studentDao.delStudentByStudentId(studentId);
	  }
	
	@Override
	public int deleteTeacher(long teacherId){
		//先根据teacherId从spareTime中获得对应的IdList
		List<Long> idList = spareTimeDao.getIdListByTeacherId(teacherId);
		//然后根据id删除对应的reservation
		for(Long id:idList) {
			reservationDao.deleteReservationById(id);
		}
		//再删除spareTime
		int num=spareTimeDao.delSpareTimeByTeacherId(teacherId);
		//删除老师
	    return teacherDao.delTeacherByTeacherId(teacherId);
	  }
	
	
	@Override
	public int correctStudentPassword(Long studentId,Long password) {
		return studentDao.updateStudentPassword(studentId, password);
	}
	

	@Override
	public int correctTeacherPassword(Long teacherId, Long password) {
		return teacherDao.updateTeacherPassword(teacherId, password);
	}
	
	@Override
	public int correctAdminPassword(Long adminId, Long password) {
		return administratorDao.updateAdminPassword(adminId, password);
	}
	
	
	@Override
	public Student queryByStudentId(Long studentId) {
		 return studentDao.queryByStudentId(studentId);
	
	}

	@Override
	public Teacher queryTeacherId(Long teacherId) {
		return teacherDao.queryByTeacherId(teacherId);
	}
	
	
	

	@Override
	public int addSpareTime(SpareTime spareTime) {
		return spareTimeDao.addSpareTime(spareTime);
	}

	@Override
	public List<Reservation> getReservationById(long id) {
		return reservationDao.queryById(id);
	}

	@Override
	public int updateStudentDep(Long studentId, String depId) {
		return studentDao.updateStudentDepId(studentId, depId);
	}

	@Override
	public int updateStudentPhone(Long studentId, String phone) {
		return studentDao.updateStudentPhone(studentId, phone);
	}

	@Override
	public int updateStudentEmail(Long studentId, String emailAddress) {
		return studentDao.updateStudentEmail(studentId, emailAddress);
	}

	@Override
	public int updaTeteacherDep(Long teacherId, String depId) {
		return teacherDao.updateTeacherDepId(teacherId, depId);
	}

	@Override
	public int updateTeacherPhone(Long teacherId, String phone) {
		return teacherDao.updateTeacherPhone(teacherId, phone);
	}

	@Override
	public int updateTeacherEmail(Long teacherId, String emailAddress) {
		return teacherDao.updateTeacherEmail(teacherId, emailAddress);
	}

	@Override
	public int updateTeacherAddress(Long teacherId, String address) {
		return teacherDao.updateTeacherAddress(teacherId, address);
	}

	@Override
	public List<SpareTime> getAllOvertimeSpareTime() {
		return spareTimeDao.queryOvertimeSpareTimeId();
	}

	@Override
	public int deleteReservationById(long id) {
		return reservationDao.deleteReservationById(id);
	}


	@Override
	public int deleteOvertimeSpareTime(long id) {
		return spareTimeDao.delSpareTimeById(id);
	}
	
	
	
	@Override
	public String ajaxUploadExcelStudent(HttpServletRequest request,HttpServletResponse response){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
	    
	    MultipartFile file = multipartRequest.getFile("upfile");  
	    if(file.isEmpty()){  
	        try {
				throw new Exception("文件不存在！");
			} catch (Exception e) {
				e.printStackTrace();
			}  
	    }  
	      
	    InputStream in =null;  
	    try {
			in = file.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}  
	    
		List<List<Object>> listob = null; 
		try {
			listob = new ExcelUtils().getBankListByExcel(in,file.getOriginalFilename());
		} catch (Exception e) {
			e.printStackTrace();
		}   
		
	    //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出  
	    for (int i = 0; i < listob.size(); i++) {  
	        List<Object> lo = listob.get(i);  
	        Student vo = new Student(); 
	        Student j = null;
			try {
				j = studentDao.queryByStudentId(Long.valueOf(String.valueOf(lo.get(0))));
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				System.out.println("没有新增");
			}
			    vo.setStudentId(Long.valueOf(String.valueOf(lo.get(0)))); 
			    vo.setPassword(Long.valueOf((String) lo.get(1))); 
	            vo.setStudentName(String.valueOf(lo.get(2)));   
	            vo.setGrade(Integer.valueOf((String) lo.get(3)));
	            vo.setDepId(String.valueOf((lo.get(4))));
	            vo.setEmailAddress(String.valueOf((lo.get(5))));
	            vo.setPhone(String.valueOf((lo.get(6)))); 
			if(j == null)
			{
		            studentDao.insert(vo);
			}
			else
			{
		            studentDao.update(vo);
			}
			
	    }   
	    return "success";
	}
	
	@Override
	public XSSFWorkbook exportStudentExcelInfo() throws Exception {
		
		List<Map<String,Object>> list = studentDao.findUserObject();
		//System.out.println(list);
		List<ExcelBean> excel = new ArrayList<ExcelBean>();
		Map<Integer,List<ExcelBean>> map = new LinkedHashMap<Integer, List<ExcelBean>>();
		//设置标题栏
		excel.add(new ExcelBean("学号","studentId",0));
		excel.add(new ExcelBean("密码","password", 0));
		excel.add(new ExcelBean("姓名","studentName",0));
		excel.add(new ExcelBean("年级","grade",0));
		excel.add(new ExcelBean("院系号","depId",0));
		excel.add(new ExcelBean("邮箱","emailAddress",0));
		excel.add(new ExcelBean("电话","phone",0));
		map.put(0,excel);
		String sheetName = "学生信息表";
		//调用ExcelUtil方法
		XSSFWorkbook xssfWorkbook = ExcelUtils.createExcelFile(Student.class, list, map, sheetName);
		System.out.println(xssfWorkbook);
		return xssfWorkbook;
	}
	
	
	@Override
	public String ajaxUploadExcelTeacher(HttpServletRequest request,HttpServletResponse response){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;    
	    
	    MultipartFile file = multipartRequest.getFile("upfile");  
	    if(file.isEmpty()){  
	        try {
				throw new Exception("文件不存在！");
			} catch (Exception e) {
				e.printStackTrace();
			}  
	    }  
	      
	    InputStream in =null;  
	    try {
			in = file.getInputStream();
		} catch (IOException e) {
			e.printStackTrace();
		}  
	    
		List<List<Object>> listob = null; 
		try {
			listob = new ExcelUtils().getBankListByExcel(in,file.getOriginalFilename());
		} catch (Exception e) {
			e.printStackTrace();
		}   
		
	    //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出  
	    for (int i = 0; i < listob.size(); i++) {  
	        List<Object> lo = listob.get(i);  
	        Teacher vo = new Teacher(); 
	        Teacher j = null;
	    	
			try {
				j = teacherDao.queryByTeacherId(Long.valueOf(String.valueOf(lo.get(0))));
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				System.out.println("没有新增");
			}
			    vo.setTeacherId(Long.valueOf(String.valueOf(lo.get(0)))); 
			    vo.setPassword(Long.valueOf((String) lo.get(1))); 
	            vo.setTeacherName(String.valueOf(lo.get(2)));   
	            vo.setDepId(String.valueOf((lo.get(3))));
	            vo.setEmailAddress(String.valueOf((lo.get(4))));
	            vo.setPhone(String.valueOf((lo.get(5))));
	            vo.setAddress(String.valueOf((lo.get(6))));
			if(j == null)
			{
		            teacherDao.insert(vo);
			}
			else
			{
		            teacherDao.update(vo);
			}
	    }   
	    return "success";
	}
	
	@Override
	public XSSFWorkbook exportTeacherExcelInfo() throws Exception {
		
		List<Map<String,Object>> list = teacherDao.findUserObject();
		//System.out.println(list);
		List<ExcelBean> excel = new ArrayList<ExcelBean>();
		Map<Integer,List<ExcelBean>> map = new LinkedHashMap<Integer, List<ExcelBean>>();
		//设置标题栏
		excel.add(new ExcelBean("工号","teacherId",0));
		excel.add(new ExcelBean("密码","password", 0));
		excel.add(new ExcelBean("姓名","teacherName",0));
		excel.add(new ExcelBean("院系号","depId",0));
		excel.add(new ExcelBean("邮箱","emailAddress",0));
		excel.add(new ExcelBean("电话","phone",0));
		excel.add(new ExcelBean("地址","address",0));
		map.put(0,excel);
		String sheetName = "教师信息表";
		//调用ExcelUtil方法
		XSSFWorkbook xssfWorkbook = ExcelUtils.createExcelFile(Teacher.class, list, map, sheetName);
		System.out.println(xssfWorkbook);
		return xssfWorkbook;
	}
	
}