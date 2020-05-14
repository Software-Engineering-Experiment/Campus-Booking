package org.mycom.campus_book.dto;

import org.mycom.campus_book.enums.BookStateEnum;


public class BookExecution {

	// 预约时间id
	private long id;

	// 秒杀预约结果状态
	private int state;

	// 状态标识
	private String stateInfo;  

	public BookExecution() {
	}

	public BookExecution(long id,BookStateEnum stateEnum) {
		this.id = id;
		this.state = stateEnum.getState();
		this.stateInfo = stateEnum.getStateInfo();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getStateInfo() {
		return stateInfo;
	}

	public void setStateInfo(String stateInfo) {
		this.stateInfo = stateInfo;
	}

	@Override
	public String toString() {
		return "BookExecution [id=" + id + ", state=" + state + ", stateInfo=" + stateInfo + "]";
	}
	
	
}
