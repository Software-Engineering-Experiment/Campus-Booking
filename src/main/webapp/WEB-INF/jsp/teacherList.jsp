<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp" %>
<% String appPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <title>老师界面</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>老师预约时间表</h2>
        </div>
        
       	<div class="text-center">
       		<table class="table table-bookName" >
       			<thead>
       				<tr>
       					<th>${teacher.teacherId}-${teacher.teacherName}  你好！</th>
       					<th width="30"><a class="btn btn-info" id="add-btn" >增加可预约时间</a></th>
       					<th width="30"><a class="btn btn-info" id="update-btn">修改个人信息</a></th>
        				<th width="30"><a class="btn btn-info" id="correct-btn"  target="_blank" >修改密码</a></th>
        				<th width="30"><a class="btn btn-info" href="<%=appPath%>/index.jsp" >退出</a></th>
        			</tr>
        		</thead>
        	</table>
        <div>

       
        
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
                <c:forEach items="${teacherList}" var="sk">
                    <tr>
                    	<td>${sk.id}</td>
                        <td>${sk.teacherId}</td>
                        <td>${sk.teacherName}</td>
                        <td>${sk.startTime}</td>
                        <td>${sk.endTime}</td>
                        <td>${sk.maxReserved}</td>
                        <td>${sk.reserved}</td> 
                        <td><a class="btn btn-info" href="<%=appPath%>/spareTimes/${sk.id}/teacherDetail?teacherId=${sk.teacherId}&id=${sk.id}" >详细</a></td>
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

<!--   添加空余时间弹出框 输入开始时间，结束时间  最大预约人数-->
<div id="addModal" class="modal fade"> 
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <span class="glyphicon glyphicon-studentId"> </span>填写空余时间信息:
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="startTime" id="startTimeKey"
                               placeholder="输入开始时间  格式：xxxx-xx-xx xx:xx" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="endTime" id="endTimeKey"
                               placeholder="输入结束时间  格式：xxxx-xx-xx xx:xx" class="form-control">
                    </div>
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="maxReserved" id="maxReservedKey"
                               placeholder="输入最大预约人数" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="SpareTimeMessage" class="glyphicon"> </span>
                <button type="submit" id="spareTimeBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    Submit
                </button>
             <button type="submit" id="spareTime-shutdownBtn" class="btn btn-success">
                    <span class="glyphicon glyphicon-student"></span>
                    exit
                </button>
       	 </div>
    </div> 
</div>  
</div>

 <!--   修改个人信息弹出层 选填输入电话号码，邮箱，院系，地址  -->
<div id="UpdateTeacherModal" class="modal fade"> 
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
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="address" id="addressKey"
                               placeholder="修改地址" class="form-control">
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
               		<!--  验证信息 -->
               		
               	<!--我加的关闭  -->
               	<!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
               
               	
                <span id="updateMessage" class="glyphicon"> </span>
                <button type="submit" id="update-teacherBtn" class="btn btn-success">
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
			correct:function(teacherId){
				return '<%=appPath%>/spareTimes/'+teacherId + '/teacherCorrect';
			},
			add:function(teacherId){
				return '<%=appPath%>/spareTimes/'+teacherId + '/addSpareTime';	
			},
			update:function(teacherId){
				return '<%=appPath%>/spareTimes/'+teacherId + '/teacher/update';
			}
		},
		
		timeNorm:function(time){
			var month = time.substring(5,7);
			var day = time.substring(8,10);
			var hour = time.substring(11,13);
			var minute = time.substring(14,16);
			if(month<=0||month>12||day<=0||day>31||hour<0||hour>23||minute<0||minute>59) return false;
			else return true;
		},
		
		//将当前时间转化为：xxxx-xx-xx xx:xx:xx形式
		getNowFormatDate:function(){
			    var date = new Date();
			    var seperator1 = "-";
			    var seperator2 = ":";
			    var month = date.getMonth() + 1;
			    var strDate = date.getDate();
			    var Hours = date.getHours();
			    var Minutes = date.getMinutes();
			    var Seconds = date.getSeconds();
			    if (month >= 1 && month <= 9) {
			        month = "0" + month;
			    }
			    if (strDate >= 0 && strDate <= 9) {
			        strDate = "0" + strDate;
			    }
			    if (Hours >= 0 && Hours <= 9) {
			        Hours = "0" + Hours;
			    }
			    if (Minutes >= 0 && Minutes <= 9) {
			        Minutes = "0" + Minutes;
			    }
			    if (Seconds >= 0 && Seconds <= 9) {
			        Seconds = "0" + Seconds;
			    }
			    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
			            + " " + Hours + seperator2 + Minutes
			            + seperator2 + Seconds;
			    return currentdate;
			},
		
		//开始时间与当前时间的比较，开始时间必须在当前时间之后，但是开始时间最多比当前时间大15天
		timeCompare:function(startTime,nowTime){
			var nowYear = nowTime.substring(0,4);
			var nowMonth = nowTime.substring(5,7);
			var nowDay = nowTime.substring(8,10);
			var nowHour = nowTime.substring(11,13);
			var nowMinute = nowTime.substring(14,16);
			console.log("time:"+nowTime);
			console.log("nowYear:"+nowYear);
			console.log("nowMonth:"+nowMonth);
			console.log("nowDay:"+nowDay);
			console.log("nowHour:"+nowHour);
			console.log("nowMinute:"+nowMinute);
			var startYear=startTime.substring(0,4);
			var startMonth = startTime.substring(5,7);
			var startDay = startTime.substring(8,10);
			var startHour = startTime.substring(11,13);
			var startMinute = startTime.substring(14,16);
			var MonthDay=new Array("31","28","31","30","31","30","31","31","30","31","30","31");
			//闰年月的天数
			var MonthDay1=new Array("31","29","31","30","31","30","31","31","30","31","30","31");
			//跨年			
			if(startYear>nowYear){
				if(startYear-1 != nowYear) return false;
				else{
					if(startMonth!=1 || nowMonth!=12) {console.log("跨年必须是12月和1月");return false;}
					else{
						if((31-nowDay+(startDay-0))>15) {console.log("应在15天内添加，同跨年:");return false;}
						else return true;
					}
				}
			}
			//同一年
			else if(startYear == nowYear){
				//跨月
				if(startMonth>nowMonth){
					if(startMonth-1 != nowMonth) {console.log("跨月必须相邻");return false;}
					else{
						//闰年判定
						if((nowYear%4==0 && nowYear%100!=0) || nowYear%400 == 0){
							if((MonthDay1[nowMonth-1]-0-nowDay+(startDay-0))<15){
								return true;
							}
							else {var ss=MonthDay[nowMonth-1]-0-nowDay+(startDay-0);console.log("闰年天数大于15:"+ss);return false;}
						}
						else{
							if((MonthDay[nowMonth-1]-0-nowDay+startDay)<15){
								return true;
							}
							else {var ss=MonthDay[nowMonth-1]-0-nowDay+(startDay-0);console.log("非闰年天数大于15:" + ss);return false;}
						}
						
					}
				}
				//同一个月内添加时间
				else if(startMonth==nowMonth){
					if(startDay == nowDay) {console.log("不能当天添加");return false;}//不能当天添加时间
					else if((startDay-0-nowDay)>15) {console.log("应在15天内添加，同月:");return false;}
					else if(nowDay-0-startDay>0) return false;
					else return true;
				}
				else {console.log("startMonth小于nowMonth"); return false;}
			}
			else return false;
		},
			
		//空闲时间逻辑判定，空闲的时间必须是在同一天，且空闲时间应大于30分钟，而且空闲时间不能当天导入
		validateTime:function(startTime,endTime,nowTime){
			var startYear=startTime.substring(0,4);
			var startMonth = startTime.substring(5,7);
			var startDay = startTime.substring(8,10);
			var startHour = startTime.substring(11,13);
			var startMinute = startTime.substring(14,16);
			var endYear=endTime.substring(0,4);
			var endMonth = endTime.substring(5,7);
			var endDay = endTime.substring(8,10);
			var endHour = endTime.substring(11,13);
			var endMinute = endTime.substring(14,16);
			//首先startTime与当前时间比较，查看是否能够预约，若能，再进行判断开始和结束时间是否符合规则
			if(spareTimeBook.timeCompare(startTime,nowTime)){
				if(startYear!=endYear||startMonth!=endMonth||startDay!=endDay){
					 console.log("notInOneDay");
				 	 return "notInOneDay";
				}
				else {
						if(startHour>endHour) {console.log("endBeforeStart1");return "endBeforeStart";}
						else if(startHour == endHour){
							if(endMinute<startMinute) {console.log("endBeforeStart2");return "endBeforeStart";}
							else if(endMinute-startMinute <30) {console.log("shortofTime");return "shortOfTime";}
							else return false;
							}
						else{
							if((endMinute-startMinute+60)<30) {console.log("shortofTime1");return "shortOfTime";}
							else return false;
						}
					}
			}
			else{
				console.log("开始时间与当前时间不符合规定");
				return "StartTimeError";
			}
		},
			
		//验证添加的spareTime信息
		validateInfo:function(teacherId,teacherName,startTime,endTime,maxReserved){
			var nowTime = spareTimeBook.getNowFormatDate();
			var now = new Date(<%=new java.util.Date().getTime()%>);
			console.log("当前时间："+now);
			var teststring = "2020-10-10 10:30";
			var reg=/^[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}/;
			
			//格式测试
			//var regtest=reg.test(startTime);
			//console.log("reg测试结果:"+regtest);
			
			//验证输入时间是否符合常识
			var norm = spareTimeBook.timeNorm(startTime);
			var norm1= spareTimeBook.timeNorm(endTime);
			
			//验证三个时间之间关系是否正确
			var result=spareTimeBook.validateTime(startTime,endTime,nowTime);
			
			if(!startTime||!endTime||!maxReserved){
				console.log("nothing");
				return "nothing";
			}
			else if(startTime.length!=16||endTime.length!=16||isNaN(maxReserved)){
				console.log("typeError");
				return "typeError";
			}
			else if(maxReserved<=0){
				console.log("typeErrorReserved");
				return "typeErrorReserved";
			}
			//输入的信息不符合xxxx-xx-xx xx:xx规范
			else if(!reg.test(startTime)||!reg.test(startTime)){
				
				console.log("typeErrorTime");
				return "typeErrorTime";				
			}
			//输入信息不符合时间上的规范，分钟只能取00-59,小时只能取0-23，月只能取1-12,日只能取1-31
			else if(!norm||!norm1){
				console.log("timeError");
				return "timeError";
			}
			else if(!result){
				console.log("格式正确");
				if(spareTimeBook.addSpareTime(teacherId,teacherName,startTime,endTime,maxReserved)){
					return "success";
				}
				else return "addError";
			
			}
			else{
				return result;
			}
		},
		
		
		//验证学号和密码
		validateTeacher:function(teacherId,password,password1){
			console.log("teacherId:"+teacherId);
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
				if(spareTimeBook.correctPassword(teacherId, password)){
					console.log("修改成功！");
					return "success";
				}else{
					console.log("修改失败！");
					return "mismatch";
				}
			}  
		},

		//添加空闲时间记录
		addSpareTime:function(teacherId,teacherName,startTime,endTime,maxReserved){
			console.log("成功进入addSpareTime!");
			var result=false;
			var params={};
			params.teacherName=teacherName;
			params.startTime=startTime;
			params.endTime=endTime;
			params.maxReserved=maxReserved;
			params.reserved=0;
			console.log("params.teacherName:"+params.teacherName);
			var addUrl=spareTimeBook.URL.add(teacherId);
			console.log(addUrl);
			$.ajax({
				type:'post',
				url:addUrl,
				data:params,
				datatype:'josn', 
				async:false,                       //同步调用，保证先执行result=true,后再执行return result;
				success:function(data){
					if(data.result=='SUCCESS'){
						//我注释掉的页面刷新
						//window.location.reload();
						
						//弹出登录成功！
						alert("增加成功!");
						result=true;
					}else{
						result=false;
					}
				}
			});
			console.log("我是增加结果："+result);
			return result;		
		},
		
		//修改密码
		correctPassword:function(teacherId,password){
			console.log("成功进入correctPassword!");
			var result=false;
			var params={};
			params.password=password;
			console.log("params.password:"+params.password);
			
			var correctUrl=spareTimeBook.URL.correct(teacherId);
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
		
		
		//验证输入的个人信息，同时修改个人信息
		validateTeacherInfo:function(teacherId,depId,phone,emailAddress,address){
			if(!depId && !phone && !emailAddress && !address){
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
			if(address){
				if(address.length>100)
					return "addressTypeError";
			}
			console.log("进行修改个人信息");
			var result = spareTimeBook.updateInfo(teacherId,depId,phone,emailAddress,address);
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
			else if(result=="addressFAILED"){
				return "addressFAILED";
			}
		},
		//修改个人信息
		updateInfo:function(teacherId,depId,phone,emailAddress,address){
			console.log("成功进入updateInfo!");
			var result=false;
			var params={};
			params.depId=depId;
			params.phone=phone;
			params.emailAddress=emailAddress;
			params.address=address;
			console.log("params.depId:"+params.depId);
			console.log("params.phone:"+params.phone);
			console.log("params.emailAddress:"+params.emailAddress);
			console.log("params.address:"+params.address);
			var updateUrl=spareTimeBook.URL.update(teacherId);
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
					else if(data.result=="addressFAILED"){
						result="addressFAILED";
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
					var teacherId=params['teacherId']; 
					var teacherName=params['teacherName'];
					console.log("我是js文件！");
					console.log("teacherId:"+ teacherId );
					
					//修改密码按钮触发
					$('#correct-btn').click(function (){
						var  IdAndPasswordModal=$('#varifyModal');
						IdAndPasswordModal.modal({
						show: true,//显示弹出层
	                    backdrop: 'static',//禁止位置关闭
	                    keyboard: false//关闭键盘事件
						});
					});
					
					//增加记录按钮触发
					$('#add-btn').click(function (){
						var  addSpareTimeModal=$('#addModal');
						addSpareTimeModal.modal({
						show: true,//显示弹出层
		                backdrop: 'static',//禁止位置关闭
		                keyboard: false//关闭键盘事件
						});			
					});
					
					//增加记录中submit按钮触发
					$('#spareTimeBtn').click(function (){
						var startTime=$('#startTimeKey').val();
						var endTime=$('#endTimeKey').val();
						var maxReserved=$('#maxReservedKey').val();
						console.log("startTime:"+startTime);
						console.log("endTime:"+endTime);
						console.log("maxReservedKey:"+maxReserved);
						var temp =spareTimeBook.validateInfo(teacherId,teacherName,startTime,endTime,maxReserved);
						console.log("temp的值:"+temp);
						if(temp=="nothing"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">信息栏应填全!</label>').show(300);}
						else if(temp=="typeError"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">输入信息时间不符合xxxx-xx-xx xx:xx规范(最大预约人数为非数字)!</label>').show(300);}
						else if(temp=="typeErrorReserved"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">最大预约人数应为非负数</label>').show(300);}
						else if(temp=="typeErrorTime"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">输入时间不符合xxxx-xx-xx xx:xx规范</label>').show(300);}
						else if(temp=="timeError"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">输入时间不符合时间常理</label>').show(300);}
						else if(temp=="notInOneDay"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">开始时间和结束时间不在同一天</label>').show(300);}
						else if(temp=="endBeforeStart"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">结束时间在开始时间之前</label>').show(300);}
						else if(temp=="shortOfTime"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">空时时间至少为30分钟</label>').show(300);}
						else if(temp=="StartTimeError"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">不能添加当天或者之前的时间，并且最多提前15天添时间</label>').show(300);}
						else if(temp=="addError"){
							$('#SpareTimeMessage').hide().html('<label class="label label-danger">添加空闲时间失败</label>').show(300);}
						else if(temp=="success"){
							$("#addModal").modal('hide');
							window.location.reload();
						}
						
					});
					
					//增加记录中的exit按钮
					$('#spareTime-shutdownBtn').click(function (){
						$("#addModal").modal('hide');
					});
					//修改密码中的exit按钮
					$('#shutdownBtn').click(function (){
						$("#varifyModal").modal('hide');
					});
					
					//修改密码中的submit按钮
					$('#studentBtn').click(function (){
						var newPassword=$('#passwordKey').val();
						var newPassword1=$('#password-1-Key').val();
							console.log("newpassword:"+newPassword);
							console.log("newpassword1:"+newPassword1);
							
						//调用validateStudent函数验证用户id和密码。
						var temp=spareTimeBook.validateTeacher(teacherId,newPassword,newPassword1);
						console.log("tempd的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">新密码或确认密码栏为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确！密码应为6位数字</label>').show(300);
						}
						else if(temp=="notSame"){
							$('#studentMessage').hide().html('<label class="label label-danger">两次输入密码不一致</label>').show(300);
						}
						else if(temp=="mismatch"){
							$('#studentMessage').hide().html('<label class="label label-danger">修改失败</label>').show(300);
						}else if(temp=="success"){
							//添加的关闭模态框
							$("#varifyModal").modal('hide');

							window.location.reload();
						}
					}); 
					
					//修改个人信息按钮触发
					$('#update-btn').click(function (){
						var  updateModal=$('#UpdateTeacherModal');
						updateModal.modal({
							show: true,//显示弹出层
		                    backdrop: 'static',//禁止位置关闭
		                    keyboard: false//关闭键盘事件
						});
						//修改个人信息界面中的关闭按钮
						$('#update-shutdownBtn').click(function (){
							$("#UpdateTeacherModal").modal('hide');
						});
						//修改个人信息界面中的提交按钮
						$('#update-teacherBtn').click(function (){
							var depId=$('#depKey').val();
							var phone=$('#phoneKey').val();
							var emailAddress=$('#emailKey').val();
							var address=$('#addressKey').val();
							console.log("depID:"+depId);
							console.log("phone:"+phone);
							console.log("emailAddress:"+emailAddress);
							console.log("Address:"+address);
							//调用validateStudentInfo函数验用户输入的信息，同时修改个人信息。
							var temp=spareTimeBook.validateTeacherInfo(teacherId,depId,phone,emailAddress,address);
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
							else if(temp=="addressFAILED"){
								$('#updateMessage').hide().html('<label class="label label-danger">修改地址失败</label>').show(300);
							}
							else if(temp=="success"){
								window.location.reload();
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
           teacherId : ${teacher.teacherId},
           teacherName : '${teacher.teacherName}'
        });
    });

</script>

</html>

