<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>管理员功能界面</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>管理员功能界面</h2><br>
            <h2>${adminId}  你好！</h2>
        </div>
        
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr> 
                	<th><h1><a class="btn btn-info" href="<%=appPath%>/spareTimes/${adminId}/adminStudent">查看学生信息</a></h1></th>
                    <th><h1><a class="btn btn-info" href="<%=appPath%>/spareTimes/${adminId}/adminTeacher" >查看教职工信息</a></h1></th>
                    <th><h1><a class="btn btn-info" href="<%=appPath%>/spareTimes/${adminId}/adminSpareTime" >查看空闲时间信息</a></h1></th> 
                    <th><h1><a id="delSpareTime-Btn" class="btn btn-info"" >删除过期记录</a></h1></th> 
                </tr>
                </thead>
                <tbody>
                    <tr>
                    	<td><h1><a class="btn btn-info" href="<%=appPath%>/spareTimes/import/student" >导入和导出学生信息</a></h1></td>
                        <td><h1><a class="btn btn-info" href="<%=appPath%>/spareTimes/import/teacher" >导入和导出教职工信息</a></h1></td>
                        <td><h1><a id="resetS-Btn" class="btn btn-info" >重置学生密码</a></h1></td>
                        <td><h1><a id="resetT-Btn" class="btn btn-info"  >重置教职工密码</a></h1></td>
                    </tr>
                    <tr>
                    	<td><h1><a id="delS-Btn" class="btn btn-info">删除学生信息</a></h1></td>
                        <td><h1><a id="delT-Btn" class="btn btn-info" >删除教职工信息</a></h1></td>
                        <td><h1><a id="correct-btn" class="btn btn-info">修改管理员密码</a></h1></td>
                        <td><h1><a class="btn btn-info" href="<%=appPath%>/index.jsp" >退出</a></h1></td>
                    </tr>
                </tbody>
            </table> 
        </div>    
    </div>
</div>

<!--   重置学生密码弹出框-->
<div id="resetS-Modal" class="modal fade"> 
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>填写需要重置学生的学号:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="studentId" id="studentIdKey"
                               placeholder="输入重置密码的学生学号" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="ResetS-Message" class="glyphicon"> </span>
                <button type="submit" id="resetS-submit-Btn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="resetS-shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
       	 </div>
    </div> 
</div>  
</div>

<!--   重置老师密码弹出框 -->
<div id="resetT-Modal" class="modal fade"> 
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>填写需要重置老师的工号:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="teacherId" id="teacherIdKey"
                               placeholder="输入重置密码的老师工号" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="ResetT-Message" class="glyphicon"> </span>
                <button type="submit" id="resetT-submit-Btn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="resetT-shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
       	 </div>
    </div> 
</div>  
</div>


<!--   删除学生弹出框-->
<div id="deleteS-Modal" class="modal fade"> 
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>填写需要删除学生的学号:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="del-studentId" id="del-studentIdKey"
                               placeholder="输入要删除的学生学号" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="deleteS-Message" class="glyphicon"> </span>
                <button type="submit" id="deleteS-submit-Btn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="deleteS-shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
       	 </div>
    </div> 
</div>  
</div>


<!--   删除老师弹出框-->
<div id="deleteT-Modal" class="modal fade"> 
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>填写需要删除教师的工号:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="del-teacherId" id="del-teacherIdKey"
                               placeholder="输入要删除的教师工号" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="deleteT-Message" class="glyphicon"> </span>
                <button type="submit" id="deleteT-submit-Btn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="deleteT-shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
       	 </div>
    </div> 
</div>  
</div>





 <!--   修改密码弹出层   -->
<div id="correctModal" class="modal fade"> 
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
               
               	
                <span id="CorrectMessage" class="glyphicon"> </span>
                <button type="submit" id="correct-submit-Btn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="correct-shutdownBtn" class="btn btn-success">
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
var admin={
		//封装相关ajax的url
		URL:{
			resetStudent:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/student/passwordReset';
			},
			resetTeacher:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/teacher/passwordReset';
			},
			correct:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/adminCorrect';
			},
			deleteStudent:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/student/del';
			},
			deleteTeacher:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/teacher/del';
			},
			deleteOverTime:function(adminId){
				return '<%=appPath%>/spareTimes/'+ adminId + '/admin/deleteovertime'
			}
		},
	
		//管理员修改密码验证
		validateTeacher:function(adminId,password,password1){
			console.log("password:"+password);
			console.log("password1:"+password1);
			if(!password||!password1){
				return "nothing";
			}
			else if(password!=password1){
				return "notSame";
			}
			else if(isNaN(password)||isNaN(password1)||password.length!=6 ||password1.length!=6){
				return "typeError";
			}
			else {
				console.log("修改密码");
				if(admin.correctTeacherPassword(adminId, password)){
					console.log("修改成功！");
					return "success";
				}else{
					console.log("修改失败！");
					return "mismatch";
				}
			}  
		},
		
		//修改密码
		correctTeacherPassword:function(adminId,password){
			console.log("成功进入correctTeacherPassword!");
			var result=false;
			var params={};
			params.password=password;
			console.log("params.password:"+params.password);
			
			var correctUrl=admin.URL.correct(adminId);
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
		
		
		//验证学号和重置密码，学生
		validateAndResetStudent:function(adminId,studentId){
			if(!studentId){
				return "nothing";
			}else if(isNaN(studentId)){
				return "typeError";
			}else {
				console.log("重置密码");
				if(admin.resetStudentPassword(adminId,studentId)){
					console.log("重置成功！");
					return "success";
				}else{
					console.log("重置失败！");
					return "mismatch";
				}
			}  
		},

		
		//重置学生密码
		resetStudentPassword:function(adminId,studentId){
			console.log("成功进入resetStudentPassword!");
			var result=false;
			var params={};
			params.studentId=studentId;
			console.log("params.stdentId:"+params.studentId);
			
			var resetStudentUrl=admin.URL.resetStudent(adminId);
			console.log(resetStudentUrl);
			$.ajax({
				type:'post',
				url:resetStudentUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("重置"+studentId+"成功!");
						result=true;
					}else{
						alert("重置"+studentId+"失败!，学号不存在");
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
			
		
		//验证工号和重置密码,老师
		validateAndResetTeacher:function(adminId,teacherId){
			if(!teacherId){
				return "nothing";
			}else if(isNaN(teacherId)){
				return "typeError";
			}else {
				console.log("重置密码");
				if(admin.resetTeacherPassword(adminId,teacherId)){
					console.log("重置成功！");
					return "success";
				}else{
					console.log("重置失败！");
					return "mismatch";
				}
			}  
		},

		
		//重置老师密码
		resetTeacherPassword:function(adminId,teacherId){
			console.log("成功进入resetPassword!");
			var result=false;
			var params={};
			params.teacherId=teacherId;
			console.log("params.teacherId:"+params.teacherId);
			
			var resetTeacherUrl=admin.URL.resetTeacher(adminId);
			console.log(resetTeacherUrl);
			$.ajax({
				type:'post',
				url:resetTeacherUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("重置"+teacherId+"成功!");
						result=true;
					}else{
						alert("重置"+teacherId+"失败!，工号不存在");
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		
		//验证学号和删除学学生
		validateAndDelStudent:function(adminId,studentId){
			if(!studentId){
				return "nothing";
			}else if(isNaN(studentId)){
				return "typeError";
			}else {
				console.log("删除密码");
				if(admin.delStudent(adminId,studentId)){
					console.log("删除成功！");
					return "success";
				}else{
					console.log("删除失败！");
					return "mismatch";
				}
			}  
		},

		
		//删除学生
		delStudent:function(adminId,studentId){
			console.log("成功进入resetPassword!");
			var result=false;
			var params={};
			params.studentId=studentId;
			console.log("params.stdentId:"+params.studentId);
			
			var delStudentUrl=admin.URL.deleteStudent(adminId);
			console.log(delStudentUrl);
			$.ajax({
				type:'post',
				url:delStudentUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("删除"+studentId+"成功!");
						result=true;
					}else{
						alert("删除"+studentId+"失败!，学号不存在");
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		//验证学工号和删除教师
		validateAndDelTeacher:function(adminId,teacherId){
			if(!teacherId){
				return "nothing";
			}else if(isNaN(teacherId)){
				return "typeError";
			}else {
				console.log("删除密码");
				if(admin.delTeacher(adminId,teacherId)){
					console.log("删除成功！");
					return "success";
				}else{
					console.log("删除失败！");
					return "mismatch";
				}
			}  
		},

		
		//删除学生
		delTeacher:function(adminId,teacherId){
			console.log("成功进入resetPassword!");
			var result=false;
			var params={};
			params.teacherId=teacherId;
			console.log("params.stdentId:"+params.teacherId);
			
			var delTeacherUrl=admin.URL.deleteTeacher(adminId);
			console.log(delTeacherUrl);
			$.ajax({
				type:'post',
				url:delTeacherUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("删除"+teacherId+"成功!");
						result=true;
					}else{
						alert("删除"+teacherId+"失败!，工号不存在");
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		
		
		
		
		//前端总体逻辑
		detail:{
			//入口
			init:function(params){
					var adminId=params['adminId'];
					console.log("我是js文件！");
					console.log("adminId:"+ adminId );
					
					//重置学生密码按钮触发，模态框显示
					$('#resetS-Btn').click(function (){
						var  ResetSModal=$('#resetS-Modal');
						ResetSModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
					});
					
					//删除过时信息按钮触发按钮触发
					$('#delSpareTime-Btn').click(function (){
						var params={};
						var delOverTimeUrl=admin.URL.deleteOverTime(adminId);
						console.log(delOverTimeUrl);
						$.ajax({
							type:'post',
							url:delOverTimeUrl,
							data:params,
							datatype:'josn', 
							async:false,                       //同步调用，保证先执行result=true,后再执行return result;
							success:function(data){
								if(data.result=='SUCCESS'){
									//我注释掉的页面刷新
									//window.location.reload();
									
									//弹出登录成功！
									alert("删除过期的spareTime成功!");
								}else{
									alert("删除过期的spareTime失败");
								}
							}
						});							
					});
					
					
					
					//重置学生密码中submit按钮触发
					$('#resetS-submit-Btn').click(function (){
						var studentId=$('#studentIdKey').val();
						console.log("studentId:"+studentId);
						var temp =admin.validateAndResetStudent(adminId,studentId);
						console.log("temp的值:"+temp);
						if(temp=="nothing"){
							$('#ResetS-Message').hide().html('<label class="label label-danger">学号不能为空!</label>').show(300);}
						else if(temp=="typeError"){
							$('#ResetS-Message').hide().html('<label class="label label-danger">学号应为数字').show(300);}
						else if(temp=="success"){
							window.location.reload();
						}
						
					});
					
					//重置学生密码中的exit按钮
					$('#resetS-shutdownBtn').click(function (){
						$("#resetS-Modal").modal('hide');
					});
					
					
					
					//删除学生按钮触发，模态框显示
					$('#delS-Btn').click(function (){
						var  delSModal=$('#deleteS-Modal');
						delSModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
					});
					
					
					//删除学生中submit按钮触发
					$('#deleteS-submit-Btn').click(function (){
						var studentId=$('#del-studentIdKey').val();
						console.log("studentId:"+studentId);
						var temp =admin.validateAndDelStudent(adminId,studentId);
						console.log("temp的值:"+temp);
						if(temp=="nothing"){
							$('#deleteS-Message').hide().html('<label class="label label-danger">学号不能为空!</label>').show(300);}
						else if(temp=="typeError"){
							$('#deleteS-Message').hide().html('<label class="label label-danger">学号应为数字').show(300);}
						else if(temp=="success"){
							window.location.reload();
						}
						
					});
					
					//删除学生中的exit按钮
					$('#deleteS-shutdownBtn').click(function (){
						$("#deleteS-Modal").modal('hide');
					});
					

					//删除老师按钮触发，模态框显示
					$('#delT-Btn').click(function (){
						var  delTModal=$('#deleteT-Modal');
						delTModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
					});
					
					
					//删除老师中submit按钮触发
					$('#deleteT-submit-Btn').click(function (){
						var teacherId=$('#del-teacherIdKey').val();
						console.log("teacherId:"+teacherId);
						var temp =admin.validateAndDelTeacher(adminId,teacherId);
						console.log("temp的值:"+temp);
						if(temp=="nothing"){
							$('#deleteT-Message').hide().html('<label class="label label-danger">工号不能为空!</label>').show(300);}
						else if(temp=="typeError"){
							$('#deleteT-Message').hide().html('<label class="label label-danger">工号应为数字').show(300);}
						else if(temp=="success"){
							window.location.reload();
						}
						
					});
					
					//删除老师中的exit按钮
					$('#deleteT-shutdownBtn').click(function (){
						$("#deleteT-Modal").modal('hide');
					});
					
					
					//重置老师密码按钮触发，模态框显示
					$('#resetT-Btn').click(function (){
						var  ResetTModal=$('#resetT-Modal');
						ResetTModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
					});
					
					
					//重置老师密码中submit按钮触发
					$('#resetT-submit-Btn').click(function (){
						var teacherId=$('#teacherIdKey').val();
						console.log("teacherId:"+teacherId);
						var temp =admin.validateAndResetTeacher(adminId,teacherId);
						console.log("temp的值:"+temp);
						if(temp=="nothing"){
							$('#ResetT-Message').hide().html('<label class="label label-danger">工号不能为空!</label>').show(300);}
						else if(temp=="typeError"){
							$('#ResetT-Message').hide().html('<label class="label label-danger">工号应为数字').show(300);}
						else if(temp=="success"){
							window.location.reload();
						}
						
					});
					
					//重置老师密码中的exit按钮
					$('#resetT-shutdownBtn').click(function (){
						$("#resetT-Modal").modal('hide');
					});
				
										
					//修改密码按钮触发
					$('#correct-btn').click(function (){
						var  CorrectModal=$('#correctModal');
						CorrectModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
						
						
						//修改密码中的exit按钮
						$('#correct-shutdownBtn').click(function (){
							$("#correctModal").modal('hide');
						});
						
						//修改密码中的submit按钮
						$('#correct-submit-Btn').click(function (){
							var newPassword=$('#passwordKey').val();
							var newPassword1=$('#password-1-Key').val();
								console.log("newpassword:"+newPassword);
								console.log("newpassword1:"+newPassword1);
								
							//调用validateStudent函数验证用户id和密码。
							var temp=admin.validateTeacher(adminId,newPassword,newPassword1);
							console.log("tempd的值");
							console.log(temp);
							if(temp=="nothing"){
								$('#CorrectMessage').hide().html('<label class="label label-danger">新密码或确认密码栏为空!</label>').show(300);
							}else if(temp=="typeError"){
								$('#CorrectMessage').hide().html('<label class="label label-danger">格式不正确！密码应为6位数字</label>').show(300);
							}else if(temp=="mismatch"){
								$('#CorrectMessage').hide().html('<label class="label label-danger">修改失败</label>').show(300);
							}else if(temp =="notSame"){
								$('#CorrectMessage').hide().html('<label class="label label-danger">两次密码不一致</label>').show(300);
							}else if(temp=="success"){

								window.location.reload();
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
        admin.detail.init({
           adminId : ${adminId}
        });
    });

</script>
</html>
