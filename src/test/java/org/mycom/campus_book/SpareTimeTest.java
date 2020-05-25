package org.mycom.campus_book;

import org.mycom.campus_book.dao.SpareTimeDao;
import org.mycom.campus_book.entity.SpareTime;
import java.util.List;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class SpareTimeTest extends BaseTest{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SpareTimeDao spareTimeDao;
	
	@Test
	public void queryById() {
		long id = 2;
		SpareTime spareTime = spareTimeDao.queryById(id);
		System.out.print("queryById測試："+ spareTime);
	}
	
	@Test
	public void queryByTeacherName() {
		String teacherName = "罗志祥";
		List<SpareTime> spareTimes = spareTimeDao.queryByTeacherName(teacherName);
		System.out.print("queryByTeacherName："+ spareTimes);
	}
	
	@Test
	public void queryAll() {
		List<SpareTime> spareTimes = spareTimeDao.queryAll(1,1000);
		System.out.print("queryall："+ spareTimes);
	}
	
	@Test
	public void addReserved() {
		long id = 2;
		int i= spareTimeDao.addReserved(id);
		SpareTime spareTime = spareTimeDao.queryById(id);
		System.out.print("addReserved："+ spareTime);
	}
	
	@Test
	public void reduceReserved() {
		long id = 2;
		int i= spareTimeDao.reduceReserved(id);
		SpareTime spareTime = spareTimeDao.queryById(id);
		System.out.print("reduceReserved："+ spareTime);
	}
	
	
	@Test
	public void addSpareTime() {
			long id = 1;
		 long teacherId = 8888888;
		 String teacherName = "小猪";
		 String startTime = "2020-05-11,15:30";
		 String endTime = "2020-05-11,16:30";
		 int maxReserved = 30;
		 int reserved = 0;
		 SpareTime spareTime = new SpareTime(id,teacherId,teacherName,startTime,endTime,maxReserved,reserved);
		 int ss = spareTimeDao.addSpareTime(spareTime);
		
	}
	
	@Test
	public void delSpareTimeById() {
		long id = 5;
		int i= spareTimeDao.delSpareTimeById(id);
		SpareTime spareTime = spareTimeDao.queryById(id);
		System.out.print("delSpareTimeById："+ i + " hello");
	}
	
	
}
