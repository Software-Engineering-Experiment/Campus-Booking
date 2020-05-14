<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
 <%
	String studentId=request.getParameter("studentId"); 
 %>
    <title><%=studentId%>预约图书列表</title>
    <%@include file="common/head.jsp" %>
</head>
<body>

<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>您已预约教师空余时间列表</h2>
        </div>
		<div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr> 
                    <th>学号</th>
                    <th>预约时间</th>
                    <th>空余时间id</th>
                    <th>教师id</th> 
                    <th>教师姓名</th>
                    <th>开始时间</th>
                    <th>结束时间</th>  
                    <th>删除预约</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reservations}" var="sk">
                    <tr>
                    	<td>${sk.studentId}</td> 
                        <td>${sk.time}</td>
                        <td>${sk.id}</td>
                        <td>${sk.spareTime.getTeacherId()}</td>
                        <td>${sk.spareTime.getTeacherName()}</td>
                        <td>${sk.spareTime.getStartTime()}</td>
                        <td>${sk.spareTime.getEndTime()}</td>
                        <td><a class="btn btn-info" href="<%=appPath%>/spareTimes/${sk.id}/${sk.studentId}/del?studentId=<%=studentId %>" >删除</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>
        <div class="panel-body text-center">
            	<h2 class="text-danger"> 
            		 
            		<span class="glyphicon">
            		<a class="btn btn-info" href="<%=appPath%>/spareTimes/<%=studentId %>/list">返回个人首页</a></span>
            	</h2>
       </div>     	 
    </div>
</div>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</body>
</html>