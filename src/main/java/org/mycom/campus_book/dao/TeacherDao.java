package org.mycom.campus_book.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mycom.campus_book.entity.Student;
import org.mycom.campus_book.entity.Teacher;

public interface TeacherDao {
	/**
	 * 向数据库验证输入的密码是否正确
	 * @param teacherId
	 * @param password;
	 * @return Teacher
	 */
	Teacher queryTeacher(@Param("teacherId") long teacherId, @Param("password") long password);
	
	/**
	 * 根据老师id查找老师个人资料，管理员功能，老师功能
	 * @param teacherId
	 * @return Teacher
	 */
	Teacher queryByTeacherId(long teacherId);
	
	/**
	 * 根据老师姓名查找老师，管理员功能
	 * @param teacherName
	 * @return Teacher List
	 */
	List<Teacher> queryByTeacherName(String teacherName);
	
	/**
	 * 查看所有老师的信息,管理员功能
	 * @param offset
	 * @param limit
	 * @return Teacher List
	 */
	List<Teacher> queryAll(@Param("offset") int offset,@Param("limit") int limit);
	
	/**
	 * 老师修改密码，老师功能
	 * @param teacherId
	 * @param studentId
	 * @return int
	 */
	int updateTeacherPassword(@Param("teacherId") long teacherId,@Param("password") long password);
	
	/*
	 * 管理员功能
	 *删除学生
	 * 返回值是修改记录的行数，如果返回值为0则说明删除失败
	 */
	int delTeacherByTeacherId(long teacherId);
	
	
	/**
	 * 老师修改depId
	 * @param teacherId,DepId
	 * @return int
	 */
	int updateTeacherDepId(@Param("teacherId")long teacherId,@Param("depId")String depId);
	
	/**
	 * 老师修改phone
	 * @param teacherId,phone
	 * @return int
	 */
	int updateTeacherPhone(@Param("teacherId")long teacherId,@Param("phone")String phone);
	
	
	/**
	 * 老师修改email
	 * @param teacherId,email
	 * @return int
	 */
	int updateTeacherEmail(@Param("teacherId")long teacherId,@Param("emailAddress")String emailAddress);
	
	/**
	 * 老师修改address
	 * @param teacherId,email
	 * @return int
	 */
	int updateTeacherAddress(@Param("teacherId")long teacherId,@Param("address")String address);
	
	/**
	 * 导出教师信息
	 * @return
	 */
	List<Map<String,Object>> findUserObject();
	
	/**
	 * 增加老师记录
	 * @param teacher
	 * @return
	 */
	int insert(Teacher teacher);
	
	/**
	 * 修改老师记录
	 * @param student
	 * @return
	 */
	int update(Teacher teacher);
	
	
}
