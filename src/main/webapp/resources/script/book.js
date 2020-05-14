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
			 
		remove:function(ele, cls) {
			  if (spareTimeBook.hasClass(ele, cls)) {
			    var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
			    while (newClass.indexOf(' ' + cls + ' ') >= 0) {
			      newClass = newClass.replace(' ' + cls + ' ', ' ');
			    }
			    ele.className = newClass.replace(/^\s+|\s+$/g, '');
			  }
			},

			
		//验证学号和密码
		validateStudent:function(studentId,password){
			console.log("studentId:"+studentId);
			if(!studentId||!password){
				return "nothing";
			}else if(isNaN(studentId)||password.length!=6 ||isNaN(password)){
			return "typerror";
			//else if(studentId.length!=10 ||isNaN(studentId)||password.length!=6 ||isNaN(password)){
			}else {
				console.log("进入verifywithdatabase");
				if(spareTimeBook.verifyWithDatabase(studentId, password)){
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
		
		//预定图书逻辑
		detail:{
			//预定也初始化
			init:function(){
				console.log("我是js文件！");
					$('#studentBtn').click(function (){
						studentId=$('#studentIdKey').val();
							console.log("studentId:"+studentId);
						password=$('#passwordKey').val();
							console.log("password:"+password);
						//调用validateStudent函数验证用户id和密码。
						var temp=spareTimeBook.validateStudent(studentId,password);
						console.log("temp的值");
						console.log(temp);
						if(temp=="nothing"){
							$('#studentMessage').hide().html('<label class="label label-danger">学号或密码为空!</label>').show(300);
						}else if(temp=="typerror"){
							$('#studentMessage').hide().html('<label class="label label-danger">格式不正确!</label>').show(300);
						}else if(temp=="mismatch"){
							console.log("已经调用验证函数！");
							$('#studentMessage').hide().html('<label class="label label-danger">学号密码不匹配!</label>').show(300);
						}else if(temp=="success"){
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
								},5000);
								console.log("动画执行结束");
							
							setTimeout(function(){alert("登陆成功！");window.location.href="<%=appPath%>/spareTimes/list" }, 5000);
							
						}
					}); 
				}
		}	
}