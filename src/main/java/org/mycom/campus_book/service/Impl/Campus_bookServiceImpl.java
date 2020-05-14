package org.mycom.campus_book.service.Impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import org.mycom.campus_book.dao.ReservationDao;
import org.mycom.campus_book.dao.SpareTimeDao;
import org.mycom.campus_book.dao.StudentDao;
import org.mycom.campus_book.dto.BookExecution;
import org.mycom.campus_book.entity.Reservation;
import org.mycom.campus_book.entity.SpareTime;
import org.mycom.campus_book.entity.Student;
import org.mycom.campus_book.enums.BookStateEnum;
import org.mycom.campus_book.exception.BookException;
import org.mycom.campus_book.exception.NoNumberException;
import org.mycom.campus_book.exception.RepeatAppointException;
import org.mycom.campus_book.service.Campus_bookService;

@Service
public class Campus_bookServiceImpl implements Campus_bookService{
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SpareTimeDao spareTimeDao;
	
	@Autowired
	private StudentDao	studentDao;
	
	@Autowired
	private ReservationDao reservationDao;
	
	@Override
	public SpareTime getById(long id) { 
		return spareTimeDao.queryById(id);
	}  
	
	@Override
	public List<SpareTime> getList() { 
		return spareTimeDao.queryAll(0, 1000);
	} 
	
	@Override
	public Student validateStu(Long studentId,Long password){
		return studentDao.queryStudent(studentId, password);
	}
	
	@Override
	public List<SpareTime> getSomeList(String name) {
		 
		return spareTimeDao.queryByTeacherName(name);
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
	public int correctStudentPassword(Long studentId,Long password) {
		return studentDao.updateStudentPassword(studentId, password);
	}
	
	@Override
	public Student queryByStudentId(Long studentId) {
		 return studentDao.queryByStudentId(studentId);
	
	}
	
	

}