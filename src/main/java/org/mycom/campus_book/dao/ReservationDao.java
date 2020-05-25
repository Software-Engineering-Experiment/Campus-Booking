package org.mycom.campus_book.dao;

import org.apache.ibatis.annotations.Param;
import org.mycom.campus_book.entity.Reservation;
import java.util.List;

public interface ReservationDao {
	//通过空闲时间的id以及学生id预约老师，并插入表中。
	int insertReservation(@Param("id") long id, @Param("studentId") long studentId);
	
	//通过学生id查表获得该学生的预约信息
	List<Reservation> queryAndReturn(long studentId);
	
	//根据空闲时间id，学生id删除单条预约记录
	int deleteReservation(@Param("id") long id, @Param("studentId") long studentId);
	
	//查询所有预约记录，只联了空闲时间表，管理员功能
	List<Reservation> queryAll(@Param("offset") int offset,@Param("limit") int limit);
	
	
	/**
	 * 向数据库查看所有预约信息，还联了老师表和空闲时间表
	 * @param  offset,limit
	 * @return list<reservation>
	 */	
	List<Reservation> queryAllReservation(@Param("offset") int offset,@Param("limit") int limit);
	
	
	//老师根据id查看预约该条记录的学生
	List<Reservation> queryById(@Param("id") long id);
	
	
	/**
	 * 根据teacherId向数据库查看所有预约信息
	 * @param teacherId
	 * @return list<reservation>
	 */	
	List<Reservation> queryReservationByTeacherId(@Param("teacherId")long teacherId);
	
	
	/**
	 * 根据teacherName向数据库查看所有预约信息
	 * @param teacherId
	 * @return list<reservation>
	 */	
	List<Reservation> queryReservationByTeacherName(@Param("teacherName")String teacherName);
	
	
	//根据学生id删除学生全部预约记录，在管理员删除学生的时候作用
	int deleteRservationByStudentId(@Param("studentId") long studentId);
	
	//根据studentid获得对应的id数组
	List<Long> getIdListByStudentId(@Param("studentId") long studentId);
	
	//根据id删除reservation记录
	int deleteReservationById(@Param("id") long id);
	
	
}
