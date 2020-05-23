<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>学生界面</title>
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
       					<th width="30"><a class="btn btn-info" href="<%=appPath%>/spareTimes/book?studentId=${student.studentId}" >查看个人预约记录</a></th>
       					<th width="30"><a class="btn btn-info" id="update-btn">修改个人信息</a></th>
        				<th width="30"><a class="btn btn-info" id="correct-btn"  target="_blank" >修改密码</a></th>
        				<th width="30"><a class="btn btn-info" href="<%=appPath%>/index.jsp" >退出</a></th>
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
        						<input type="text" name="teacherName" class="allInput" value="${teacherName}" placeholder="输入检索老师姓名^o^" />
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


 <!--   修改个人信息弹出层 选填输入电话号码，邮箱，院系  -->
<div id="UpdateStudentModal" class="modal fade"> 
    <div class="modal-dialog"> 
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>请根据需要输入要修改的信息（不需要修改项为空）:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="depId" id="depKey"
                               placeholder="修改院系" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="phone" id="phoneKey"
                               placeholder="修改电话号码" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="email" id="emailKey"
                               placeholder="修改邮箱" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="updateMessage" class="glyphicon"> </span>
                <button type="submit" id="update-studentBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="update-shutdownBtn" class="btn btn-success">
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
			},
			update:function(studentId){
				return '<%=appPath%>/spareTimes/'+studentId + '/student/update';
			}
		},
		
		//验证学号和密码
		validateStudent:function(studentId,password,password1){
			console.log("studentId:"+studentId);
			console.log("password:"+password);
			console.log("password1:"+password1);
			if(!password||!password1){
				return "nothing";
			}
			else if(password!=password1){
				return "notSame";
			}
			else if(isNaN(password)||isNaN(password1)||password.length!=6 ||password1.length!=6){
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
		
		
		//验证学生输入信息，同时修改个人信息
		validateStudentInfo:function(studentId,depId,phone,emailAddress){
			if(!depId && !phone && !emailAddress){
				return "nothing";
			}
			if(depId){
				if(isNaN(depId)||depId.length!=3)
					return "depIdTypeError"
			}
			if(phone){
				if(isNaN(phone)||phone.length!=11)
					return "phoneTypeError";
			}
			if(emailAddress){
				var reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
				if(!reg.test(emailAddress))
					return "emailTypeError";
			}
			console.log("进行修改个人信息");
			var result = spareTimeBook.updateInfo(studentId,depId,phone,emailAddress);
			if(result == "updateSuccess"){
				console.log("修改成功！");
				return "success";
			}else if(result=="depIdFAILED"){
				return "depIdFAILED";
			} 
			else if(result=="phoneFAILED"){
				return "phoneFAILED";
			}
			else if(result=="emailFAILED"){
				return "emailFAILED";
			}
		},
		//修改个人信息
		updateInfo:function(studentId,depId,phone,emailAddress){
			console.log("成功进入updateInfo!");
			var result=false;
			var params={};
			params.depId=depId;
			params.phone=phone;
			params.emailAddress=emailAddress;
			console.log("params.depId:"+params.depId);
			console.log("params.phone:"+params.phone);
			console.log("params.emailAddress:"+params.emailAddress);
			var updateUrl=spareTimeBook.URL.update(studentId);
			console.log(updateUrl);
			$.ajax({
				type:'post',
				url:updateUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						
						//弹出登录成功！
						alert("修改个人信息成功!");
						result="updateSuccess";
					}else if(data.result == "depIdFAILED"){
						result="depIdFAILED";
					}
					else if(data.result=="phoneFAILED"){
						result="phoneFAILED";
					}
					else if(data.result=="emailFAILED"){
						result="emailFAILED";	
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
						}
						else if(temp=="notSame"){
							$('#studentMessage').hide().html('<label class="label label-danger">两次输入密码不一致</label>').show(300);
						}else if(temp=="mismatch"){
							$('#studentMessage').hide().html('<label class="label label-danger">修改失败</label>').show(300);
						}else if(temp=="success"){

							window.location.reload();
							// 跳转到预约逻辑 
						}
					}); 
				});
				
				//修改个人信息按钮触发
				$('#update-btn').click(function (){
					var  updateModal=$('#UpdateStudentModal');
					updateModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
					});
					//修改个人信息界面中的关闭按钮
					$('#update-shutdownBtn').click(function (){
						$("#UpdateStudentModal").modal('hide');
					});
					//修改个人信息界面中的提交按钮
					$('#update-studentBtn').click(function (){
						var depId=$('#depKey').val();
						var phone=$('#phoneKey').val();
						var emailAddress=$('#emailKey').val();
						console.log("depID:"+depId);
						console.log("phone:"+phone);
						console.log("emailAddress:"+emailAddress);
							
						//调用validateStudentInfo函数验用户输入的信息，同时修改个人信息。
						var temp=spareTimeBook.validateStudentInfo(studentId,depId,phone,emailAddress);
						console.log("temp的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#updateMessage').hide().html('<label class="label label-danger">信息全为空!</label>').show(300);
						}else if(temp=="depIdTypeError"){
							$('#updateMessage').hide().html('<label class="label label-danger">depId格式不正确</label>').show(300);
						}
						else if(temp=="phoneTypeError"){
							$('#updateMessage').hide().html('<label class="label label-danger">电话号码格式不正确</label>').show(300);
						}else if(temp=="emailTypeError"){
							$('#updateMessage').hide().html('<label class="label label-danger">邮箱格式不正确</label>').show(300);
						}else if(temp=="depIdFAILED"){
							$('#updateMessage').hide().html('<label class="label label-danger">修改depId失败，请检查depId的正确性</label>').show(300);
						}
						else if(temp=="phoneFAILED"){
							$('#updateMessage').hide().html('<label class="label label-danger">修改phone失败</label>').show(300);
						}
						else if(temp=="emailFAILED"){
							$('#updateMessage').hide().html('<label class="label label-danger">修改邮箱失败</label>').show(300);
						}
						else if(temp=="success"){

							// 跳转到预约逻辑 
						}
					}); 
				});
			}
		}
}
</script>




<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
        spareTimeBook.detail.init({
            studentId:${student.studentId}          
        })
    })
</script>
</html>

