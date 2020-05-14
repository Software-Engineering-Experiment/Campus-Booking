package org.mycom.campus_book;

import org.mycom.campus_book.dao.StudentDao;
import org.mycom.campus_book.entity.Student;
import java.util.List;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


public class StudentDaoTest extends BaseTest{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private StudentDao studentDao;
	
	@Test
	public void queryStudent() {
		/*
		 * long id = 170170225;
		 *long password = 123456;
		 *Student student = new Student(id,password,"尹晟",3,"017","hitwh_ys@qq.com","13765659090");
		 */
		Student student = new Student();
		long studentId = 170170223;
		long password = 123123;
		student = studentDao.queryStudent(studentId,password);
		System.out.print(student.toString());
		
	}
	
	@Test
	public void updateStudentPassword() {
		long studentId=170170223;
		long newPassword=123123;
		int retVal=studentDao.updateStudentPassword(studentId, newPassword);
		System.out.print("已经更新="+retVal);
	}
	
	
	@Test
	public void Test_queryByStudentId() {
		long studentId=170170223;
		Student student=studentDao.queryByStudentId(studentId);
		System.out.print(student.toString());
	}
	
	@Test
	public void Test_queryByStudentName() {
		String studentNameString="王子豪";
		List<Student> student=studentDao.queryByStudentName(studentNameString);
		for (int i=0;i<student.size();++i) {
			Student tempStudent=student.get(i);
			System.out.println(tempStudent.toString());
		}
	}
	
	@Test
	public void Test_queryAll() {
		List<Student> student=studentDao.queryAll(0, 10);
		for(Student stu:student) {
			System.out.println(stu.toString());
		}
	}

}
