package org.mycom.campus_book.entity;
 

public class SpareTime {
	private Long id;
	private Long teacherId;
	private String teacherName;
	private String startTime;
	private String endTime;
	private int maxReserved;
	private int reserved;
	public	SpareTime() {
		
	}
	
	public SpareTime(Long id, Long teacherId, String teacherName, String startTime, String endTime, int maxReserved,
			int reserved) {
		this.id = id;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.maxReserved = maxReserved;
		this.reserved = reserved;
	}
	

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(Long teacherId) {
		this.teacherId = teacherId;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getMaxReserved() {
		return maxReserved;
	}
	public void setMaxReserved(int maxReserved) {
		this.maxReserved = maxReserved;
	}
	public int getReserved() {
		return reserved;
	}
	public void setReserved(int reserved) {
		this.reserved = reserved;
	}
	@Override
	public String toString() {
		return "SpareTime [id=" + id + ", teacherId=" + teacherId + ", teacherName=" + teacherName + ", startTime="
				+ startTime + ", endTime=" + endTime + ", maxReserved=" + maxReserved + ", reserved=" + reserved + "]";
	}
	
}
