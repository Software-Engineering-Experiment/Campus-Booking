package org.mycom.campus_book.entity;

import java.util.Date; 

public class Reservation {
	private Long studentId;
	private Long id;
	private Date time;
	
	private SpareTime spareTime;//空闲时间实体
	
	public Reservation() {
		
	}
	
	public Reservation(Long studentId, Long id, Date time, SpareTime spareTime) {
		this.studentId = studentId;
		this.id = id;
		this.time = time;
		this.spareTime = spareTime;
	}

	public Long getStudentId() {
		return studentId;
	}
	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public SpareTime getSpareTime() {
		return spareTime;
	}
	public void setSpareTime(SpareTime spareTime) {
		this.spareTime = spareTime;
	}
	@Override
	public String toString() {
		return "Reservation [studentId=" + studentId + ", id=" + id + ", time=" + time + ", spareTime=" + spareTime
				+ "]";
	}
	
	
}
