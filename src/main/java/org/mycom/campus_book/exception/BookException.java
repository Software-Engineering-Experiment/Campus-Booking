package org.mycom.campus_book.exception;

//预约服务异常
public class BookException extends RuntimeException{
	public BookException(String message) {
		super(message);
	}

	public BookException(String message, Throwable cause) {
		super(message, cause);
	}
}

