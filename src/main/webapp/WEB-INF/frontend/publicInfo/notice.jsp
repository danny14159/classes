<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级公告</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<style type="text/css">
.noticeitem{width:92%;margin: 7px auto;border: 1px solid #ccc;border-radius:10px;padding: 15px;}
.noticeitem .nctitle{color:#333;font-size: 18px;}
.nctitle span,.nctitle a{font-size: 60%;}
.noticeitem .nccontent{color:#999;font-size: 16px;}
</style>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="2" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<jsp:include page="/include_publiclsidebar">
					<jsp:param value="5" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>班级公告</h2>
							<p><button class="ui-button ui-button-mblue" onclick="$('#addmain').slideDown(200);">新建公告</button></p>
							<div id="addmain" style="display: none;">
								<h3>新建公告</h3>
								<form class="ui-form" method="post" id="fmadd">
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                标题
						            </label>
						            <input class="ui-input" type="text" name="title" value=""> 
						            <p class="ui-form-explain">（可选标题）</p>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>内容
						            </label>
						            <textarea rows="5" cols="52" name="content"></textarea>
						        	<p class="ui-form-explain">输入不超过255个字符的内容</p>
						        </div>
						        <div class="ui-form-item">
						            <input type="submit" class="ui-button ui-button-morange" value="提交" onclick="addnotice();return false;">
						        </div>
								</form>
							</div>
							
							<c:forEach  var="r" items="${notices}">
							<div class="noticelist">
								<div class="noticeitem">
									<div class="nctitle">${r.title }
									<span class="text text-success"><fmt:formatDate value="${r.time }" pattern="yyyy-MM-dd E"/></span>
									<a class="text text-gray" onclick="delnotice(${r.id})" href="javascript:;">删除</a>
									</div>
									<div class="nccontent">${r.content }</div>
								</div>
							</div>
							</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/javascript">
function delnotice(id){
	if(confirm('确认删除？'))
	$.get('/notice/del/'+id,'json')
	.done(function(data){
		alert(data?'删除成功':'系统繁忙，请稍后再试！',function(){
			if(data)location.reload(); 
		});
	})
	.fail(function(){
		alert('删除失败，请确认是否有权限删除。')
	});
}
function addnotice(){
	var param = $('#fmadd').serializeObject();
	if(!param.content){alert('请填写内容');return;}
	$.post('/notice/ins',param,'json')
	.done(function(data){
		alert(data?'记录添加成功':'系统繁忙，请稍后再试！',function(){
			if(data)location.reload(); 
		});
	})
	.fail(function(){
		alert('添加失败，请确认是否有权限添加。')
	});
}
</script>
</body>
</html>