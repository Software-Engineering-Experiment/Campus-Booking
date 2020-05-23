package org.mycom.campus_book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import org.mycom.campus_book.entity.Administrator;
import org.mycom.campus_book.entity.Student;
import org.mycom.campus_book.entity.Teacher;

public interface AdministratorDao {
	/**
	 * 向数据库验证输入的密码是否正确
	 * @param adminId
	 * @param password;
	 * @return Administrator
	 */
	Administrator queryAdministrator(@Param("adminId") long adminId, @Param("password") long password);

	
	/**
	 * 修改管理员密码
	 */
	int updateAdminPassword(@Param("adminId") long adminId,@Param("password") long password);
		
	
}
