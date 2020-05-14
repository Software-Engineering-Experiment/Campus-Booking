package org.mycom.campus_book.dao;

import org.apache.ibatis.annotations.Param;
import org.mycom.campus_book.entity.Reservation;
import java.util.List;

public interface ReservationDao {
	//通过空闲时间的id以及学生id预约老师，并插入表中。
	int insertReservation(@Param("id") long id, @Param("studentId") long studentId);
	
	//通过学生id查表获得该学生的预约信息
	List<Reservation> queryAndReturn(long studentId);
	
	//根据空闲时间id，学生id删除预约记录
	int deleteReservation(@Param("id") long id, @Param("studentId") long studentId);
	
	//查询所有预约记录，管理员功能
	List<Reservation> queryAll(@Param("offset") int offset,@Param("limit") int limit);
}
