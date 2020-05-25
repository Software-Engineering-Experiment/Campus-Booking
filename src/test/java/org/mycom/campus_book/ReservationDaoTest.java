package org.mycom.campus_book;

import org.mycom.campus_book.dao.ReservationDao;
import org.mycom.campus_book.entity.Reservation;
import java.util.List;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class ReservationDaoTest extends BaseTest{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ReservationDao reservationDao;
	
	
	@Test
	public void  getIdListByStudentId() {
		long studentId = 170170223;
		System.out.print(studentId);
		List<Long> i = reservationDao.getIdListByStudentId(studentId);
		System.out.print("getIdListByStudentId结果："+ i);
	}
	@Test
	public void  insertReservation() {
		long id = 3;
		long studentId = 170170223;
		System.out.print(id+studentId);
		int i = reservationDao.insertReservation(id,studentId);
		System.out.print("insertReservation结果："+ i);
	}
	@Test
	public void  queryAndReturn() {
		long studentId = 170170223;
		List<Reservation> reservations= reservationDao.queryAndReturn(studentId);
		System.out.print("queryAndReturn的结果："+ reservations);
	}
	
	@Test
	public void  deleteReservation() {
		long id =3;
		long studentId = 170170223;
		int i= reservationDao.deleteReservation(id,studentId);
		System.out.print("deleteReservation的结果："+ i);
	}
	
	@Test
	public void  deleteReservationByStudentId() {
		long studentId = 170170223;
		int i= reservationDao.deleteRservationByStudentId(studentId);
		System.out.print("deleteReservationByStudentId的结果："+ i);
	}
	
	@Test
	public void  queryAll() {
		List<Reservation> reservations= reservationDao.queryAll(1,1000);
		System.out.print("queryAll的结果："+ reservations);
	}
	
	
}
