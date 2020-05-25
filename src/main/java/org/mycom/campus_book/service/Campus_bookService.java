package org.mycom.campus_book.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.mycom.campus_book.dto.BookExecution;
import org.mycom.campus_book.entity.Reservation;
import org.mycom.campus_book.entity.SpareTime;
import org.mycom.campus_book.entity.Student; 
import org.mycom.campus_book.entity.Teacher;
import org.mycom.campus_book.entity.Administrator;
import org.mycom.campus_book.utils.ExcelUtils;
import org.mycom.campus_book.entity.ExcelBean;



public interface Campus_bookService {
	/**
	 * 根据id查询某条spareTime记录
	 * @param id
	 * @return SpareTime
	 */
	SpareTime getById(long id);
	
	
	/**
	 * 根据id查询某条spareTime的预约记录
	 * @param id
	 * @return Reservation List
	 */
	List<Reservation> getReservationById(long id);
	
	/**
	 *根据teacherId查询spareTime记录
	 *@param teacherId
	 *@return SpareTime List 
	 */
	List<SpareTime> getByTeacherId(long teacherId);
	
	
	/**
	 * 查询所有spareTime记录
	 * @return List SpareTime
	 */
	List<SpareTime> getList(); 
	
	
	/**
	 * 查询所有学生信息
	 * @return List Student
	 */
	List<Student> getStudentList();
	
	/**
	 * 查询所有教师信息
	 * @return List Teacher
	 */
	List<Teacher> getTeacherList(); 
	
	/**
	 * 查询所有预约信息，管理员功能
	 * @return List Reservation
	 */
	List<Reservation> getReservationList(); 
	

	/**
	 * 根据教职工姓名查询预约记录
	 * @param teacherId
	 * @return List Reservation
	 */
	List<Reservation> getReservationByTeacherId(long teacherId);
	
	/**
	 * 根据教职工姓名查询预约记录
	 * @param teacherId
	 * @return List Reservation
	 */
	List<Reservation> getReservationByTeacherName(String teacherName);
	
	/**
	 * 按照老师名称查询老师信息,模糊查询
	 * @param teacherName
	 * @return List Teacher
	 */
	List<Teacher> getSomeTeacherByTeacherName(String teacherName);
	

	
	/**
	 * 按照老师名称查询空余时间,模糊查询
	 * @param teacherName
	 * @return List SpareTime
	 */
	List<SpareTime> getSomeListByTeacherName(String teacherName);
	
	
	
	/**
	 * 查询所有过时的sparetime记录Id
	 * @param 
	 * @return list<sparetime>
	 */
	List<SpareTime> getAllOvertimeSpareTime();
	
	
	/**
	 * 按照学生名字查询学生,模糊查询
	 * @param teacherName
	 * @return List SpareTime
	 */
	List<Student> getSomeStudentByStudentName(String studentName);
	
	/**
	 * 根据学生id查询某学生预约的时间记录
	 * @param studentId
	 * @return List Reservation
	 */
	List<Reservation> getReservationByStu(long studentId);
	
	
	/**
	 * 登录时查询数据库是否有该学生记录
	 * @param studentId,password
	 * @return Student
	 */
	Student validateStu(Long studentId,Long password);

	
	/**
	 * 登录时查询数据库是否有该老师记录
	 * @param teacherId,password
	 * @return Teacher
	 */
	Teacher validateTeacher(Long teacherId,Long password);

	
	/**
	 * 登录时查询数据库是否有该管理员记录
	 * @param adminId,password
	 * @return Administrator
	 */
	Administrator validateAdministrator(Long adminId,Long password);
	
	
	
	
	/**
	 * 根据学生学号查看个人信息，学生功能
	 * @param studentId
	 * @return Student
	 */
	Student queryByStudentId(Long studentId);

	/**
	 * 根据老师工号查看个人信息，老师功能
	 * @param teacherId
	 * @return Teacher
	 */
	Teacher queryTeacherId(Long teacherId);
	
	/**
	 * 预约空闲时间
	 * @param id
	 * @param studentId
	 * @return BookExecution
	 */
	BookExecution book(long id,long studentId);
	
	
	/**
	 * 根据学生id，空余时间id删除预约记录
	 * @param studentId
	 * @param id
	 * @return int 
	 */
	int deleteReservation(@Param("studentId")long studentId,@Param("id")long id);
	
	 
	/**
	 * 根据学生id删除学生
	 * @param studentId
	 * @return int 
	 */
	int deleteStudent(@Param("studentId")long studentId);

	
	/**
	 * 根据教师id删除教师
	 * @param teacherId
	 * @return int 
	 */
	int deleteTeacher(@Param("teacherId")long teacherId);


	/**
	 * 根据学生学号修改密码
	 * @param studentId,password
	 * @return int
	 */
	int correctStudentPassword(Long studentId,Long password);
	

	/**
	 * 根据老师工号修改密码
	 * @param teacherId,password
	 * @return int
	 */
	int correctTeacherPassword(Long teacherId,Long password);
	
	/**
	 * 根据adminId修改密码
	 * @param adminId,password
	 * @return int
	 */
	int correctAdminPassword(Long adminId,Long password);
	
	/**
	 * 老师添加spareTime记录
	 * @param SpareTime
	 * @return int
	 */
	int addSpareTime(SpareTime spareTime);
	
	
	/**
	 * 根据学号和depId修改院系
	 * @param studentId,depId
	 * @return int
	 */
	int updateStudentDep(Long studentId,String depId);
	
	/**
	 * 根据学号和phone修改电话
	 * @param studentId,phone
	 * @return int
	 */
	int updateStudentPhone(Long studentId,String phone);
	
	/**
	 * 根据学号和emailAddress修改邮箱
	 * @param studentId,emailAddress
	 * @return int
	 */
	int updateStudentEmail(Long studentId,String emailAddress);
	
	
	
	/**
	 * 根据工号和depId修改院系
	 * @param teacherId,depId
	 * @return int
	 */
	int updaTeteacherDep(Long teacherId,String depId);
	
	/**
	 * 根据工号和phone修改电话
	 * @param teacherId,phone
	 * @return int
	 */
	int updateTeacherPhone(Long teacherId,String phone);
	
	/**
	 * 根据工号和emailAddress修改邮箱
	 * @param teacherId,emailAddress
	 * @return int
	 */
	int updateTeacherEmail(Long teacherId,String emailAddress);
	
	
	/**
	 * 根据工号和address修改地址
	 * @param teacherId,address
	 * @return int
	 */
	int updateTeacherAddress(Long teacherId,String address);
	
	
	/**
	 * 查根据过时的SpareTime的Id删除Reservation记录
	 * @param Id
	 * @return int
	 */
	int deleteReservationById(long Id);
	
	
	/**
	 * 删除过时的sparetime记录
	 * @param 
	 * @return int
	 */
	int deleteOvertimeSpareTime(long Id);
	
	
	/**
	 * 导入学生功能
	 */
	String ajaxUploadExcelStudent(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 导出学生功能
	 * @return
	 * @throws Exception
	 */
	XSSFWorkbook exportStudentExcelInfo() throws Exception;
	
	/**
	 * 导入教师功能
	 */
	String ajaxUploadExcelTeacher(HttpServletRequest request,HttpServletResponse response);
	
	/**
	 * 导出教师功能
	 * @return
	 * @throws Exception
	 */
	XSSFWorkbook exportTeacherExcelInfo() throws Exception;
	
	
}