package org.mycom.campus_book.entity;

public class Student {
	private Long studentId;
	private Long password;
	private String studentName;
	private int grade;
	private String depId;
	private String emailAddress;
	private String phone;
	
	public Student(){
		
	}
	
	
	public Student(Long studentId, Long password, String studentName, int grade, String depId, String emailAddress,
			String phone) {
		this.studentId = studentId;
		this.password = password;
		this.studentName = studentName;
		this.grade = grade;
		this.depId = depId;
		this.emailAddress = emailAddress;
		this.phone = phone;
	}


	public Long getStudentId() {
		return studentId;
	}
	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}
	public Long getPassword() {
		return password;
	}
	public void setPassword(Long password) {
		this.password = password;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	
	public String getDepId() {
		return depId;
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

	@Override
	public String toString() {
		return "Student [studentId=" + studentId + ", password=" + password + ", studentName=" + studentName
				+ ", grade=" + grade + ", depId=" + depId + ", emailAddress=" + emailAddress + ", phone=" + phone
				+ "]";
	}
	
	
	
}
