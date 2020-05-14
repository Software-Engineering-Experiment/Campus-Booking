<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>老师空闲时间列表</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>老师空闲时间列表</h2>
        </div>
        
       	<div class="text-center">
       		<table class="table table-bookName" >
       			<thead>
       				<tr>
       					<th>${student.studentId}-${student.studentName}  你好！</th>
       					<th><a class="btn btn-info" href="<%=appPath%>/spareTimes/book?studentId=${student.studentId}" >查看个人预约记录</a>
        				<a class="btn btn-info" id="correct-btn"  target="_blank" >修改密码</a>
        				<a class="btn btn-info" href="<%=appPath%>/index.jsp" >退出</a></th>
        			</tr>
        		</thead>
        	</table>
        <div>
        <form name="firstForm" action="<%=appPath%>/spareTimes/${student.studentId}/search" method="post">
        	<div class="panel-heading ">
        	    <table class="table table-bookName">
        	       <thead>
        	       		<tr> 
        					<th width="90" >老师名称：</th>
        					<th width="150">
        						<input type="text" name="teacherName" class="allInput" value="${teacherName}" placeholder="输入检索书名^o^" />
        					</th>
        					<th> 
        						<input type="submit" id="tabSub" value="检索" /> 
        					</th>
        					 
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
                <c:forEach items="${list}" var="sk">
                    <tr>
                    	<td>${sk.id}</td>
                        <td>${sk.teacherId}</td>
                        <td>${sk.teacherName}</td>
                        <td>${sk.startTime}</td>
                        <td>${sk.endTime}</td>
                        <td>${sk.maxReserved}</td>
                        <td>${sk.reserved}</td> 
                        <td><a class="btn btn-info" href="<%=appPath%>/spareTimes/${sk.id}/detail?studentId=${student.studentId}" >详细</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table> 
        </div>

        
    </div>
</div>
</div>
</div>

 <!--   修改密码弹出层 输入学号以及新密码  -->
<div id="varifyModal" class="modal fade"> 
    <div class="modal-dialog"> 
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>输入和确认新密码:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="password" name="password" id="passwordKey"
                               placeholder="输入新密码密码^o^" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="password" name="password1" id="password-1-Key"
                               placeholder="确认新密码^o^" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="studentMessage" class="glyphicon"> </span>
                <button type="submit" id="studentBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
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
		URL:{
			correct:function(studentId){
				return '<%=appPath%>/spareTimes/'+studentId + '/correct';
			}
		},
		
		//验证学号和密码
		validateStudent:function(studentId,password,password1){
			console.log("studentId:"+studentId);
			console.log("password:"+password);
			console.log("password1:"+password1);
			if(!password||!password1){
				return "nothing";
			}else if(isNaN(password)||isNaN(password1)||password.length!=6 ||password1.length!=6){
				return "typerror";
			}else {
				console.log("修改密码");
				if(spareTimeBook.correctPassword(studentId, password)){
					console.log("修改成功！");
					return "success";
				}else{
					console.log("修改失败！");
					return "mismatch";
				}
			}  
		},
		//修改密码
		correctPassword:function(studentId,password){
			console.log("成功进入correctPassword!");
			var result=false;
			var params={};
			params.password=password;
			console.log("params.password:"+params.password);
			
			var correctUrl=spareTimeBook.URL.correct(studentId);
			console.log(correctUrl);
			$.ajax({
				type:'post',
				url:correctUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("修改成功!");
						result=true;
					}else{
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		//预定图书逻辑
		detail:{
			//预定也初始化
			init:function(params){
				var studentId=params['studentId']; 
				console.log("我是js文件！");
				console.log("studentId:"+studentId );
				$('#correct-btn').click(function (){
					var  IdAndPasswordModal=$('#varifyModal');
					IdAndPasswordModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
					});
					$('#shutdownBtn').click(function (){
						$("#varifyModal").modal('hide');
					});
					$('#studentBtn').click(function (){
						var newPassword=$('#passwordKey').val();
						var newPassword1=$('#password-1-Key').val();
							console.log("newpassword:"+newPassword);
							console.log("newpassword1:"+newPassword1);
							
						//调用validateStudent函数验证用户id和密码。
						var temp=spareTimeBook.validateStudent(studentId,newPassword,newPassword1);
						console.log("tempd的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">新密码或确认密码栏为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确！密码应为6位数字</label>').show(300);
						}else if(temp=="mismatch"){
							$('#studentMessage').hide().html('<label class="label label-danger">修改失败</label>').show(300);
						}else if(temp=="success"){
							//添加的关闭模态框
							$("#varifyModal").modal('hide');

							window.location.reload();
							// 跳转到预约逻辑 
						}
					}); 
				})	
			}
		}
}
</script>




<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
        spareTimeBook.detail.init({
            studentId:${student.studentId}          
        });
    })
</script>
</html>

