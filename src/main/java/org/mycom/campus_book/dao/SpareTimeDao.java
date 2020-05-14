package org.mycom.campus_book.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.mycom.campus_book.entity.SpareTime;

public interface SpareTimeDao {
	/*
	 * 根据id查询某条空闲时间记录
	 */
	SpareTime queryById(long id);
	
	/*
	 * 根据老师姓名查询老师的空闲时间,模糊查询
	 */
	List<SpareTime> queryByTeacherName(String teacherName);
	
	/*
	 * 查询所有老师的空闲时间（用来list。jsp界面显示）
	 */
	List<SpareTime> queryAll(@Param("offset") int offset,@Param("limit") int limit);
	
	/*
	 * 增加当前预约人数
	 * 返回值是修改记录的行数，如果返回值为0则说明增加失败
	 */
	int addReserved(long id);
	
	/*
	 * 
	 * 减少当前预约人数
	 *  返回值是修改记录的行数，如果返回值为0则说明减少失败
	 */
	int reduceReserved(long id);
	
	/*
	 * 管理员功能
	 *增加空闲时间记录
	 * 返回值是修改记录的行数，如果返回值为0则说明增加失败
	 */
	int addSpareTime(SpareTime spareTime);
	
	
	/*
	 * 管理员功能
	 *删除空闲时间记录
	 * 返回值是修改记录的行数，如果返回值为0则说明删除失败
	 */
	int delSpareTimeById(long id);
	
	/*
	 * 老师，管理员功能
	 * 修改空闲时间
	 * 返回值是修改记录的行数，如果返回值为0则说明修改失败
	 */
	int updateSpareTime(SpareTime spareTime);

}




