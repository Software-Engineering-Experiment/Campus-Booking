package org.mycom.campus_book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import org.mycom.campus_book.entity.Student;

public interface StudentDao {
	
	/*
	 * 向数据库验证输入的密码是否正确
	 */
	Student queryStudent(@Param("studentId") long studentId, @Param("password") long password);
	
	/*
	 *根据学生Id查询学生资料 ，管理员，学生功能
	 */
	Student queryByStudentId(long StudentId);
	
	/*
	 * 根据学生姓名查找学生，管理员功能
	 */
	List<Student> queryByStudentName(String StudentName);
	
	/*
	 * 查询所有学生的信息，管理员功能
	 */
	List<Student> queryAll(@Param("offset") int offset,@Param("limit") int limit);
	
	
	/*
	 * 学生修改密码,学生功能
	 * */
	int updateStudentPassword(@Param("studentId") long studentId,@Param("password") long password);

	
}
