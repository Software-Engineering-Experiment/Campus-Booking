<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>预约详情页</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
     	   	<h2>图书详情</h2>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>图书ID</th>
                    <th>图书名称</th> 
                    <th>图书简介</th>
                    <th>剩余数量</th>
                    <th>预约数量</th>
                </tr>
                </thead>
                <tbody>
                	<tr>
                		<td>${book.bookId}</td>
                		<td>${book.name}</td>
                		<td>${book.introd}</td> 
                		<td>${book.number }</td>
                		<td>1</td>
                	</tr>  
                </tbody>
             </table> 
           </div>  
           <div class="panel-body text-center">
            	<h2 class="text-danger">  
            		<!--用来展示预约控件-->
            		<span class="glyphicon" id="appoint-box"></span> <!--在js里面调用这个id还可以动态显示一些其他东西，例如动态时间等（需要插件）-->
            		 
            		<span class="glyphicon"><a class="btn btn-primary btn-lg" href="<%=appPath%>/books/appoint?studentId=${cookie['studentId'].value}" target="_blank">查看我的已预约书籍</a></span>
            	</h2>           <!--如何获取该页面弹出层输入的学生ID， 传给上面的url-->
        	</div>
    </div>	 	         		  
</div>

   <!--   登录弹出层 输入电话  -->
<div id="varifyModal" class="modal fade"> 
    <div class="modal-dialog"> 
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>请输入学号和密码:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="studentId" id="studentIdKey"
                               placeholder="填写学号^o^" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="password" name="password" id="passwordKey"
                               placeholder="输入密码^o^" class="form-control">
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
            </div> 
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
var bookappointment={
		//封装相关ajax的url
		URL:{
			appoint:function(bookId,studentId){
				return '<%=appPath%>/books/'+bookId+'/appoint?studentId='+studentId;
			},
			verify:function(){
				return '<%=appPath%>/books'+'/verify';
			}
		},
		
		//验证学号和密码
		validateStudent:function(studentId,password){
			console.log("studentId:"+studentId);
			if(!studentId||!password){
				return "nothing";
			}else if(studentId.length!=10 ||isNaN(studentId)||password.length!=6 ||isNaN(password)){
				return "typerror";
			}else {
				console.log("进入verifywithdatabase");
				if(bookappointment.verifyWithDatabase(studentId, password)){
					console.log("验证成功！");
					return "success";
				}else{
					console.log("验证失败！");
					return "mismatch";
				}
			}  
		},
		//将学号和用户名与数据库匹配
		verifyWithDatabase:function(studentId,password){
			console.log("成功进入verifywithdatabase!");
			var result=false;
			var params={};
			params.studentId=studentId;
			params.password=password;
			console.log("params.password:"+params.password);
			var verifyUrl=bookappointment.URL.verify();
			
			$.ajax({
				type:'post',
				url:verifyUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("登陆成功！");
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
				var bookId=params['bookId']; 
				console.log("我是js文件！");
				
				var studentId=$.cookie('studentId');
				var password=$.cookie('password');
				if(!studentId||!password){
					//设置弹出层属性
					var  IdAndPasswordModal=$('#varifyModal');
					IdAndPasswordModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
					});
					$('#studentBtn').click(function (){
						studentId=$('#studentIdKey').val();
							console.log("studentId:"+studentId);
						password=$('#passwordKey').val();
							console.log("password:"+password);
						//调用validateStudent函数验证用户id和密码。
						var temp=bookappointment.validateStudent(studentId,password);
						console.log("tempd的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">学号或密码为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确!</label>').show(300);
						}else if(temp=="mismatch"){
							console.log("已经调用验证函数！");
							$('#studentMessage').hide().html('<label class="label label-danger">学号密码不匹配!</label>').show(300);
						}else if(temp=="success"){
							//添加的关闭模态框
							$("#varifyModal").modal('hide');
							console.log("设置cookie");
							 //学号与密码匹配正确，将学号密码保存在cookie中。不设置cookie过期时间，这样即为session模式，关闭浏览器就不保存密码了。
							$.cookie('studentId', studentId, {  path: '<%=appPath%>/books/'+bookId+'/detail'}); 
							$.cookie('password', password, {  path: '<%=appPath%>/books/'+bookId+'/detail'}); 
							console.log("设置cookie成功");
							window.location.reload();
							// 跳转到预约逻辑 
							var appointbox=$('#appoint-box');
							bookappointment.appointment(bookId,studentId,appointbox);
						}
					}); 
				}else{
					var appointbox=$('#appoint-box');
					bookappointment.appointment(bookId,studentId,appointbox);
				} 
			}	
		},
		appointment:function(bookId,studentId, node){
			console.log("我执行预约的方法!" );
			node.html('<button class="btn btn-primary btn-lg" id="appointmentBtn">预约</button>');
			  
			var appointmentUrl = bookappointment.URL.appoint(bookId,studentId);
			console.log("appointmentUrl:"+appointmentUrl);
			//绑定一次点击事件
			$('#appointmentBtn').one('click', function () {
				//执行预约请求
				//1、先禁用请求
				$(this).addClass('disabled');
				//2、发送预约请求执行预约
				$.post(appointmentUrl,{},function(result){   //Ajax强大之处，向Controller方法提出请求和返回结果在一处!
					if(result && result['success']){         //同时还可以连续取对象的子对象！
						var appointResult=result['data'];
							console.log("appointResult"+appointResult);
						var state=appointResult['state'];
							console.log("state"+state);
						var stateInfo=appointResult['stateInfo'];
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
        bookappointment.detail.init({
            bookId:${book.bookId}          
        });
    })
</script>

</html>
