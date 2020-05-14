package org.mycom.campus_book.exception;

//库存不足异常
public class NoNumberException extends RuntimeException{
	public NoNumberException(String message) {
		super(message);
	}

	public NoNumberException(String message, Throwable cause) {
		super(message, cause);
	}

}
