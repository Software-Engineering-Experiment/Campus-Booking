<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<%@include file="common/tag.jsp" %>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
String appPath = request.getContextPath();
%>  
<html>  
  <head>  
    <base href="<%=basePath%>">  
     <%@include file="common/head.jsp" %>
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>  
   
     <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.min.js"></script>  
	</style>

    <title>学生导入界面</title>  
    <script type="text/javascript">  
            //ajax 方式上传文件操作  
             $(document).ready(function(){  
                $('#btn').click(function(){  
                    if(checkData()){  
                        $('#form1').ajaxSubmit({    
                            url:'<%=appPath%>/spareTimes/student/ajaxUpload.action',  
                            dataType: 'text',  
                            success: resutlMsg,  
                            error: errorMsg  
                        });   
                        function resutlMsg(msg){  
                        	console.log(msg);
                            alert("导入excel成功");     
                            $("#upfile").val("");  
                        }  
                        function errorMsg(){   
                            alert("导入excel出错！");      
                        }  
                    }  
                });  
             });  
               
             //JS校验form表单信息  
             function checkData(){  
                var fileDir = $("#upfile").val();  
                var suffix = fileDir.substr(fileDir.lastIndexOf("."));  
                if("" == fileDir){  
                    alert("选择需要导入的Excel文件！");  
                    return false;  
                }  
                if(".xls" != suffix && ".xlsx" != suffix ){  
                    alert("选择Excel格式的文件导入！");  
                    return false;  
                }  
                return true;  
             }  
    </script>   
  </head>  
    
  <body>  
  <div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
           	<h2>选择xsls或xsl格式的学生信息表进行导入</h2>
        </div>  
        <div class="panel-body">
        <div style="width:100%;text-align:center">
    		<form method="POST"  enctype="multipart/form-data" id="form1" action="<%=appPath%>/spareTimes/student/ajaxUpload.action">  
        		<table style="margin: 0 auto">  
        			<tr>  
            			<td>上传文件: </td>  
           				 <td> <input id="upfile" type="file" name="upfile"></td>  
         			</tr>  
        			<tr>   
            			<td><input type="button" value="ajax方式提交" id="btn" name="btn" ></td>  
         			</tr>  
       			 </table>
    		</form>  
      		<br>
      	</div>
      	  <div style="width:72%;text-align:center">
     		<form action="<%=appPath%>/spareTimes/student/download.action">
		    	<input type="submit" value="导出excel信息">
			</form>
 		</div>
 		</div>
 	</div>
 </div>
  </body> 
  </html>