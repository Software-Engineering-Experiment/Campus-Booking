<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>预约详情页</title>
    <%@include file="common/head.jsp" %>
    <%
		String teacherId=request.getParameter("teacherId");
   	    String id=request.getParameter("id");
	%>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
     	   	<h2>id:<%=id %> 空闲时间的预约详情</h2>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>学号</th>
                    <th>学生姓名</th>
                    <th>年级</th>
                    <th>邮箱地址</th> 
                    <th>电话</th>
                </tr>
                </thead>
                <tbody>
               		 <c:forEach items="${reservations}" var="sk">
                	<tr>
                		<td>${sk.student.getStudentId()}</td>
                        <td>${sk.student.getStudentName()}</td>
                        <td>${sk.student.getGrade()}</td>
                        <td>${sk.student.getEmailAddress()}</td>
                        <td>${sk.student.getPhone()}</td>
                	</tr>  
                	</c:forEach>
                </tbody>
             </table> 
           </div>  
           <div class="panel-body text-center">
            	<h2 class="text-danger">  
            		<!--用来展示预约控件-->
            		<span class="glyphicon" id="book-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->
            		 
            		<span class="glyphicon">
            		<a class="btn btn-primary btn-lg" href="<%=appPath%>/spareTimes/${adminId}/adminSpareTime">返回</a></span>
            	</h2>           <!--如何获取该页面弹出层输入的学生ID， 传给上面的url-->
        	</div>
    </div>	 	         		  
</div>

 
</body>
<%--jQery文件,务必在bootstrap.min.js之前引入--%>
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<%--使用CDN 获取公共js http://www.bootcdn.cn/--%>
<%--jQuery Cookie操作插件--%>
<script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%--jQuery countDown倒计时插件--%>
<script src="http://cdn.bootcss.com/jquery.countdown/2.1.0/jquery.countdown.min.js"></script>




</html>