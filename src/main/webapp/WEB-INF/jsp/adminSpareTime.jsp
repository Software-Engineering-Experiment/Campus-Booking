<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>空闲时间列表</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>老师空闲时间列表</h2>
        </div>
   
        <form name="firstForm" action="<%=appPath%>/spareTimes/${adminId}/spareTime/search" method="post">
        	<div class="panel-heading ">
        	    <table class="table table-bookName">
        	       <thead>
        	       		<tr> 
        					<th width="90" >老师名称：</th>
        					<th width="150">
        						<input type="text" name="teacherName" class="allInput" value="${teacherName}" placeholder="输入检索老师姓名^o^" />
        					</th>
        					<th> 
        						<input type="submit" id="tabSub" value="检索" /> 
        					</th>
        					  <th width="30"><a class="btn btn-info" href="<%=appPath%>/spareTimes/${adminId}/adminList" >返回首页</a></th>
        				</tr> 
        	       </thead> 
        	    </table> 
         	</div>
        </form>
       
        
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr> 
                	<th>空闲时间id</th>
                    <th>教师ID</th>
                    <th>教师名称</th>
                    <th>开始时间</th> 
                    <th>结束时间</th>
                    <th>最大预约人数</th>
                    <th>当前预约人数</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${spareTimes}" var="sk">
                    <tr>
                    	<td>${sk.id}</td>
                        <td>${sk.teacherId}</td>
                        <td>${sk.teacherName}</td>
                        <td>${sk.startTime}</td>
                        <td>${sk.endTime}</td>
                        <td>${sk.maxReserved}</td>
                        <td>${sk.reserved}</td> 
                         <td><a class="btn btn-info" href="<%=appPath%>/spareTimes/${adminId}/${sk.id}/SpareTimeDetail?teacherId=${sk.teacherId}&id=${sk.id}" >预约清单</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>

        
    </div>
</div>
</div>
</div>

 



<%--jQery文件,务必在bootstrap.min.js之前引入--%>
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<%--使用CDN 获取公共js http://www.bootcdn.cn/--%>
<%--jQuery Cookie操作插件--%>
<script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%--jQuery countDown倒计时插件--%>
<script src="http://cdn.bootcss.com/jquery.countdown/2.1.0/jquery.countdown.min.js"></script>


</body>
<script type="text/javascript">
var spareTimeBook={
		//封装相关ajax的url
	
		
		
		//预定图书逻辑
		detail:{
			//预定也初始化
			init:function(params){
					var teacherId=params['teacherId']; 
					var teacherName=params['teacherName'];
					console.log("我是js文件！");
					console.log("teacherId:"+ teacherId );
			
					

							window.location.reload();
						}
				} 
		}

</script>

<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
        spareTimeBook.detail.init({
           teacherId : ${teacher.teacherId},
           teacherName : '${teacher.teacherName}'
        });
    });

</script>

</html>

