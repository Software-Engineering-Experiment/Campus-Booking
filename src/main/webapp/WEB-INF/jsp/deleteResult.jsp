<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>删除结果</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading text-center">
			<h2>删除结果:${result}</h2>
		</div>
		<div class="panel-body text-center">
            	<h2 class="text-danger">  
            		<!--用来展示预约控件-->
            		<span class="glyphicon" id="appoint-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->
            		  <%
                        	String studentId=request.getParameter("studentId");  
                        %>
            		<span class="glyphicon">
            		<a class="btn btn-info" href="<%=appPath%>/spareTimes/<%=studentId%>/list">返回个人首页</a></span>
            	</h2>           <!--如何获取该页面弹出层输入的学生ID， 传给上面的url-->
        </div>
	</div>
</div>




<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</body>
</html>