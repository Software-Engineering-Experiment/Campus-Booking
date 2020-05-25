<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
String appPath = request.getContextPath();
%>  
<html>  
  <head>  
    <base href="<%=basePath%>">  
    <script type="text/javascript" src="http://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>  
   
     <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.min.js"></script>  
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
  <div>1.通过简单的form表单提交方式，进行文件的上传</br>2.通过jquery.form.js插件提供的form表单一步提交功能 </div>
  <div>3.选择xsls或xsl格式的学生信息表进行导入</div>  
    <form method="POST"  enctype="multipart/form-data" id="form1" action="<%=appPath%>/spareTimes/student/ajaxUpload.action">  
        <table>  
         <tr>  
            <td>上传文件: </td>  
            <td> <input id="upfile" type="file" name="upfile"></td>  
         </tr>  
        <tr>  
            <td><input type="submit" value="提交" οnclick="checkData()"></td>  
            <td><input type="button" value="ajax方式提交" id="btn" name="btn" ></td>  
         </tr>  
        </table>    
    </form>  
      <br>
     <form action="<%=appPath%>/spareTimes/student/download.action">
		    <input type="submit" value="导出excel信息">
		</form>
  </body> 
  </html>