package org.mycom.campus_book.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import org.mycom.campus_book.dto.BookExecution;
import org.mycom.campus_book.entity.Reservation;
import org.mycom.campus_book.entity.SpareTime;
import org.mycom.campus_book.entity.Student; 

public interface Campus_bookService {
	/**
	 * 根据id查询某条spareTime记录
	 * @param id
	 * @return SpareTime
	 */
	SpareTime getById(long id);
	
	
	/**
	 * 查询所有spareTime记录
	 * @return List SpareTime
	 */
	List<SpareTime> getList(); 
	
	
	/**
	 * 登录时查询数据库是否有该学生记录
	 * @return Student
	 */
	Student validateStu(Long studentId,Long password);
	
	/**
	 * 按照老师名称查询,模糊查询
	 * @param teacherName
	 * @return List SpareTime
	 */
	List<SpareTime> getSomeList(String teacherName);
	
	/**
	 * 根据学生id查询某学生预约的时间记录
	 * @param studentId
	 * @return List Reservation
	 */
	List<Reservation> getReservationByStu(long studentId);
	
	/**
	 * 根据学生学号查看个人信息，学生功能
	 * @param studentId
	 * @return String
	 */
	Student queryByStudentId(Long studentId);
	
	
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
	 * 根据学生学号修改密码
	 * @param studentId,assword
	 * @return int
	 */
	int correctStudentPassword(Long studentId,Long password);
	
	
	


	
}