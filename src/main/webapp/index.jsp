<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String appPath = request.getContextPath(); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>预约系统登录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<!-- 可选的Bootstrap主题文件（一般不使用） -->
<link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap-theme.min.css" rel="stylesheet">

<!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
<!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
  <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
  <meta name="author" content="Vincent Garreau" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" media="screen" href="<%=appPath %>/resources/css/style.css">
  <link rel="stylesheet" type="text/css" href="<%=appPath %>/resources/css/reset.css"/>
</head>
<body>

<div id="particles-js">
		<div class="login">
			<div class="login-top">
				登录
			</div>
			<form role="form	">
            	<div class="login-center">
                	<label class="radio-inline">
                    	<input type="radio"  value="1" name="identity">学生
                	</label>
                	<label class="radio-inline">
                    	<input type="radio"  value="2" name="identity">教师
                	</label>
                	<label class="radio-inline">
                    	<input type="radio"  value="3" name="identity">管理员
                	</label>
            	</div>
        		</form>
			<div class="login-center clearfix">
			
				<div class="login-center-img"><img src="<%=appPath %>/resources/img/name.png"/></div>
				<div class="login-center-input">
					<input type="text" 	name="studentId" id="studentIdKey"  placeholder="请输入您的用户名" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的用户名'"/>
					<div class="login-center-input-text">用户名</div>
				</div>
			</div>
			<div class="login-center clearfix">
				<div class="login-center-img"><img src="<%=appPath %>/resources/img/password.png"/></div>
				<div class="login-center-input">
					<input type="password" name="password" id="passwordKey" placeholder="请输入您的密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的密码'"/>
					<div class="login-center-input-text">密码</div>
				</div>
			</div>
			<span id="studentMessage" class="glyphicon"> </span>
			<div class="login-button" id="studentBtn">
				登录
			</div>
		</div>
		<div class="sk-rotating-plane"></div>
</div>

<%--jQery文件,务必在bootstrap.min.js之前引入--%>
<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<%--使用CDN 获取公共js http://www.bootcdn.cn/--%>
<%--jQuery Cookie操作插件--%>
<script src="http://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%--jQuery countDown倒计时插件--%>
<script src="http://cdn.bootcss.com/jquery.countdown/2.1.0/jquery.countdown.min.js"></script>

<!-- scripts -->
<script src="<%=appPath %>/resources/js/particles.min.js"></script>
<script src="<%=appPath %>/resources/js/app.js"></script>

<script type="text/javascript">
var spareTimeBook={
		//封装相关ajax的url
		URL:{
			verify:function(){
				return '<%=appPath%>/spareTimes'+'/verify';
			}
		},
		hasClass:function(elem, cls) {
			  cls = cls || '';
			  if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
			  return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
			},
			 
		addClass:function(ele, cls) {
			  if (!spareTimeBook.hasClass(ele, cls)) {
			    ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
			  }
			},
			 
		removeClass:function(ele, cls) {
			  if (spareTimeBook.hasClass(ele, cls)) {
			    var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
			    while (newClass.indexOf(' ' + cls + ' ') >= 0) {
			      newClass = newClass.replace(' ' + cls + ' ', ' ');
			    }
			    ele.className = newClass.replace(/^\s+|\s+$/g, '');
			  }
			},

			
		//验证账号和密码
		validate:function(identity,studentId,password){
			console.log("用户身份:1学生2老师3管理员："+identity);
			console.log("id:"+studentId);
			if(!studentId||!password){
				return "nothing";
			}else if(isNaN(studentId)||password.length!=6 ||isNaN(password)){
			return "typerror";
			//else if(studentId.length!=10 ||isNaN(studentId)||password.length!=6 ||isNaN(password)){
			}else {
				console.log("进入verifywithdatabase");
				if(spareTimeBook.verifyWithDatabase(identity,studentId, password)){
					console.log("验证成功！");
					return "success";
				}else{
					console.log("验证失败！");
					return "mismatch";
				}
			}  
		},
		//将学号和用户名与数据库匹配
		verifyWithDatabase:function(identity,studentId,password){
			console.log("成功进入verifywithdatabase!");
			var result=false;
			var params={};
			params.studentId=studentId;
			params.password=password;
			params.identity=identity;
			console.log("params.identity:"+params.identity);
			console.log("params.id:"+params.studentId);
			console.log("params.password:"+params.password);
			var verifyUrl=spareTimeBook.URL.verify();
			
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
						
						result=true;
					}else{
						result=false;
					}
				}
			});
			console.log("我是验证结果："+result);
			return result;
			
		},
		
		//登录逻辑
		detail:{
			//预定也初始化
			init:function(){
				console.log("我是js文件！");
					$('#studentBtn').click(function (){
						var identity=$("input[name='identity']:checked").val();
						console.log("identity:"+identity);
						var studentId=$('#studentIdKey').val();
							console.log("studentId:"+studentId);
						var password=$('#passwordKey').val();
							console.log("password:"+password);
						//调用validate函数验证用户id和密码。
						var temp=spareTimeBook.validate(identity,studentId,password);
						console.log("temp的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">账号或密码为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确!密码应该为6位</label>').show(300);
						}else if(temp=="mismatch"){
							console.log("已经调用验证函数！");
							$('#studentMessage').hide().html('<label class="label label-danger">账号密码不匹配!</label>').show(300);
						}else if(temp=="success"){
							$.cookie('studentId', studentId, {  path: '/'}); 
							console.log("执行动画");
								spareTimeBook.addClass(document.querySelector(".login"), "active");
								setTimeout(function(){
									spareTimeBook.addClass(document.querySelector(".sk-rotating-plane"), "active")
									document.querySelector(".login").style.display = "none"
								},800);
								setTimeout(function(){
									spareTimeBook.removeClass(document.querySelector(".login"), "active")
									spareTimeBook.removeClass(document.querySelector(".sk-rotating-plane"), "active")
									document.querySelector(".login").style.display = "block"									
								},8000);
								console.log("动画执行结束");
								
							if(identity == 1){	
							setTimeout(function(){alert("登陆成功！");window.location.href ="<%=appPath%>/spareTimes/" + studentId + "/list"}, 5000);
							}
							else if(identity == 2){
							setTimeout(function(){alert("登陆成功！");window.location.href ="<%=appPath%>/spareTimes/" + studentId + "/teacherList"}, 5000);	
							}
							else if(identity == 3){
							setTimeout(function(){alert("登陆成功！");window.location.href ="<%=appPath%>/spareTimes/" + studentId + "/adminList"}, 5000);	
							}
						}
							
					}); 
				}
		}	
}
</script>

<script type="text/javascript">
    $(function () {
        //使用EL表达式传入参数
       spareTimeBook.detail.init({          
        })
    })
</script>
<div style="text-align:center;">
</div>
</body>
</html>