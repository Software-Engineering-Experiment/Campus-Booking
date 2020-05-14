package org.mycom.campus_book.entity;

public class Teacher {
	private Long teacherId;
	private Long password;
	private String teacherName;
	private String depId;
	private String emailAddress;
	private String phone;
	private String address;
	public Teacher() {
		
	}
	
	
	public Teacher(Long teacherId, Long password, String teacherName, String depId, String emailAddress,
			String phone, String address) {
		this.teacherId = teacherId;
		this.password = password;
		this.teacherName = teacherName;
		this.depId = depId;
		this.emailAddress = emailAddress;
		this.phone = phone;
		this.address = address;
	}


	public Long getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(Long teacherId) {
		this.teacherId = teacherId;
	}
	public Long getPassword() {
		return password;
	}
	public void setPassword(Long password) {
		this.password = password;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "Teacher [teacherId=" + teacherId + ", password=" + password + ", teacherName=" + teacherName
				+ ", depId=" + depId + ", emailAddress=" + emailAddress + ", phone=" + phone + ", address="
				+ address + "]";
	}
	
}
