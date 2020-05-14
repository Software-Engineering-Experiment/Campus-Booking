package org.mycom.campus_book.entity;

public class Administrator {
	private Long adminId;
	private Long password;
	public Administrator() {
		
	}
	
	public Administrator(Long adminId, Long password) {
		this.adminId = adminId;
		this.password = password;
	}

	public Long getAdminId() {
		return adminId;
	}
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}
	public Long getPassword() {
		return password;
	}
	public void setPassword(Long password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "Administrator [adminId=" + adminId + ", password=" + password + "]";
	}
	
}
