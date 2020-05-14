package org.mycom.campus_book.entity;

public class Department {
	private Long depId;
	private Long depName;
	public Department() {
		
	}
	
	public Department(Long depId, Long depName) {
		this.depId = depId;
		this.depName = depName;
	}

	public Long getDepId() {
		return depId;
	}
	public void setDepId(Long depId) {
		this.depId = depId;
	}
	public Long getDepName() {
		return depName;
	}
	public void setDepName(Long depName) {
		this.depName = depName;
	}

	@Override
	public String toString() {
		return "Department [depId=" + depId + ", depName=" + depName + "]";
	}
	
	
}
