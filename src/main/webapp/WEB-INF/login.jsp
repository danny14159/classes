
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>-欢迎登录-班·集 :) </title>
<link href="/f/assets/css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- <link href="resources/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" media="screen">
 --><link href="/f/assets/css/login.css" rel="stylesheet" media="screen">
<style type="text/css">

</style>
</head>
<body>
<div id="bg">
<div class="container-fluid">
	<div class="row" id="header">
		<div class="col-md-2 col-md-offset-1">
		<div class="bklogo-46"></div> 
		<span>登录中心</span></div>
		<div class="col-md-2 col-md-offset-6">
			<span><a href="">联系我们</a> | <a href="/exhibition">功能演示</a> | <a href="">帮助</a>
			</span>
		</div>
	</div> <!-- End of header -->
</div>
	<div class="container" id="main">
	<h2 class="page-header">班·集<small> [江苏大学-<a href="##">更改</a>]</small></h2>
	<div class="col-md-8" id="poster">
		
		<div class="col-md-6">	
 			<!-- <div id="selclz"><div class="triup"></div>
 		
 			
 			</div> -->
 		</div>
		<div class="col-md-6">
			
			<a href="signup">班·集介绍</a>
			<h2></h2>
			<h6> 新增同学录功能，随时联系</h6>
			<h6> 热门单身派对，high翻到底</h6>
			<h6> 班级事务，尽在掌握</h6>
			<h6> 更多功能，敬请期待...</h6>
		</div>
	</div><!-- End of poster -->
	<div class="col-md-4" id="form">
		<h4>登录 班·集</h4>
		<hr/>
		<div id="info"><small class="col-md-offset-1"> </small></div>
		<form class="" method="POST" action="login" >
		<div class="form-group">
		<input type="text" class="form-control" placeholder="学号" id="inputAccount" name="no" value=""/>
		</div>
		<div class="form-group">
		<input type="password" class="form-control" placeholder="密码" id="inputPass" name="pwd" value=""/>
		</div>
		 
		<input type="hidden" name="classId" value="1"/>
		<input type="hidden" name="_r" value="${_r }"/>
		
		<div>
		<a href="#">忘记密码？</a>
			</div>
			<div class="checkbox">
    		<label>
      		<input type="checkbox"> 记住账号
    		</label>
  		</div>
		
  		<button type="submit" id="btn_login" onclick="return onsubmit1();">登 录</button>
		</form>
	</div><!-- End of form -->
	<div class="clearfix visible-xs-block"></div>
	</div>
	<!-- End of main body -->
</div>
</body>
<script type="text/javascript" src="f/assets/js/jquery-2.1.0.min.js"></script>
<!-- <script src="f/assets/js/bootstrap/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="f/assets/js/jquery.cookie.js"></script>
<script type="text/javascript" src="f/assets/js/pinyin.js"></script>
<script type="text/javascript">

$(function(){
	var errs={'':'',1:'用户名不存在，请检查。',2:'密码有误，请检查。'};
	showInfo('${err}'?'danger':null,errs['${err}'] || '');
	
	$('#bg').height($(window).height());
	$("#inputAccount").blur(function(){
		if(!$(this).val()) showInfo("danger","学号不能为空");
		else showInfo();
	});
	$("#inputPass").blur(function(){
		if(!$(this).val()) showInfo("danger","密码不能为空");
		else showInfo();
	});
});

//显示提示信息（类型和文本）
var showInfo=function(type,msg){
	if(!arguments.length){
		$("#info").html("");return;
	}
	var icons={danger:'×',success:'√'};
	var icon = icons[type] || '';
	$("#info").html("<div class=\"alert alert-"+type+"\" role=\"alert\">"+icon+msg+"</div>");
};
var onsubmit1=function(){
	var account=$("#inputAccount").val();
	var pass=$("#inputPass").val();
	if(!account || !pass){
		showInfo("danger","用户名或密码不能为空");
		return false;
	}
	return true;
};

</script>
</html>