package org.mycom.campus_book.dao;

import java.util.List;
import java.util.Map;

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
	Student queryByStudentId(@Param("studentId")long studentId);
	
	/*
	 * 根据学生姓名查找学生，管理员功能
	 */
	List<Student> queryByStudentName(@Param("studentName")String studentName);
	
	/*
	 * 查询所有学生的信息，管理员功能
	 */
	List<Student> queryAll(@Param("offset") int offset,@Param("limit") int limit);
	
	
	/*
	 * 修改学生密码
	 * */
	int updateStudentPassword(@Param("studentId") long studentId,@Param("password") long password);

	/*
	 * 管理员功能
	 *删除学生
	 * 返回值是修改记录的行数，如果返回值为0则说明删除失败
	 */
	int delStudentByStudentId(@Param("studentId") long studentId);
	
	
	/**
	 * 学生修改depId
	 * @param studentId,DepId
	 * @return int
	 */
	int updateStudentDepId(@Param("studentId")Long studentId,@Param("depId")String depId);
	
	/**
	 * 学生修改phone
	 * @param studentId,phone
	 * @return int
	 */
	int updateStudentPhone(@Param("studentId")Long studentId,@Param("phone")String phone);
	
	
	/**
	 * 学生修改email
	 * @param studentId,email
	 * @return int
	 */
	int updateStudentEmail(@Param("studentId")Long studentId,@Param("emailAddress")String emailAddress);
	
	/**
	 * 增加学生记录
	 * @param student
	 * @return
	 */
	int insert(Student student);
	
	/**
	 * 修改学生记录
	 * @param student
	 * @return
	 */
	int update(Student student);
	
	/**
	 * 导出学生信息
	 * @return
	 */
	List<Map<String,Object>> findUserObject();
	
}
