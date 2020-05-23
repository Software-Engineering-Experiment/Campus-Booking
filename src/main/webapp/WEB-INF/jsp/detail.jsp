<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>预约详情页</title>
    <%@include file="common/head.jsp" %>
    <%
		String studentId=request.getParameter("studentId"); 
	%>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
     	   	<h2>老师空余时间详情</h2>
        </div>
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
                	<tr>
                		<td>${spareTime.id}</td>
                        <td>${spareTime.teacherId}</td>
                        <td>${spareTime.teacherName}</td>
                        <td>${spareTime.startTime}</td>
                        <td>${spareTime.endTime}</td>
                        <td>${spareTime.maxReserved}</td>
                        <td>${spareTime.reserved}</td> 
                	</tr>  
                </tbody>
             </table> 
           </div>  
           <div class="panel-body text-center">
            	<h2 class="text-danger">  
            		<!--用来展示预约控件-->
            		<span class="glyphicon" id="book-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->
            		 
            		<span class="glyphicon">
            		<a class="btn btn-primary btn-lg" href="<%=appPath%>/spareTimes/<%=studentId %>/list">返回个人首页</a></span>
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


<script type="text/javascript">
var spareTimeBook={
		//封装相关ajax的url
		URL:{
			book:function(id,studentId){
				return '<%=appPath%>/spareTimes/'+id+'/book?studentId='+studentId;
			}
		},
		
		
		//预定图书逻辑
		detail:{
			//预定也初始化
			init:function(params){
				var id=params['id']; 
				var studentId=params['studentId'];
				console.log("我是js文件！");
				
				console.log("执行预约逻辑！");
				// 跳转到预约逻辑 			
				var bookBox=$('#book-box');
				spareTimeBook.book(id,studentId,bookBox);
			}
		},
		
		book:function(id,studentId, node){
			console.log("我执行预约的方法!" );
			node.html('<button class="btn btn-primary btn-lg" id="appointmentBtn">预约</button>');  
			var bookUrl = spareTimeBook.URL.book(id,studentId);
			console.log("bookUrl:"+ bookUrl);
			//绑定一次点击事件
			$('#appointmentBtn').one('click', function () {
				//执行预约请求
				//1、先禁用请求
				$(this).addClass('disabled');
				//2、发送预约请求执行预约
				$.post(bookUrl,{},function(result){   //Ajax强大之处，向Controller方法提出请求和返回结果在一处!
					if(result && result['success']){         //同时还可以连续取对象的子对象！
						var bookResult=result['data'];
							console.log("bookResult"+ bookResult);
						var state = bookResult['state'];
							console.log("state"+state);
						var stateInfo = bookResult['stateInfo'];
							console.log("stateInfo"+stateInfo);
						//显示预约结果                                                          把结果显示给页面，完成了jsp的工作
							 
						node.html('<span class="label label-success">'+stateInfo+'</span>');
					}       //因为公用一个node所以，用来显示“stateInfo”时就不会显示上面的“预约”
					console.log('result'+result);
				});
			 });
			
			
		}
}
</script>




<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
       spareTimeBook.detail.init({
            id:${spareTime.id},
            studentId:<%=studentId%>
       
        })
    })
</script>

</html>
