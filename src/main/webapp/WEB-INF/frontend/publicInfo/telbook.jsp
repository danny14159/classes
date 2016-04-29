<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>作业管理</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
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
					<jsp:param value="4" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>班级通讯录</h2>
							<div id="booktbs"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/html" id="tplbook">
{{each data as val i}}

<h3>{{ val.clzName }}班级通讯录</h3>
<table class="ui-table">
<thead>
	<tr>
		<th width="20%">学号</th>
		<th width="20%">姓名</th>
		<th>手机</th>
		<th>QQ</th>
		<th>微信</th>
	</tr>
</thead>
<tbody>
	{{each val.tels as tel j}}
	<tr>
		<td>{{tel.no}}</td>
		<td>{{tel.name}}</td>
		<td>{{tel.connections.P}}</td>
		<td>{{tel.connections.Q}}</td>
		<td>{{tel.connections.W}}</td>
	</tr>
	{{/each}}
</tbody>
</table>
{{/each}}
</script>
<script type="text/javascript">
$(function(){
	$.ajax({
		beforeSend : function() {
		},
		data : {},
		dataType : 'json',
		type : 'POST',
		url : '/stu/connections'
	}).done(function(data) {
		if(data.ok === false && data.msg){
			alert(data.msg);
			return;
		}
		//处理一下data
		function isinattrs(arr,attr){
			for(var e in arr){
				if(arr[e]['clzName'] == attr) return arr[e];
			}
			return false;
		}
		var books=[];
		for(var p in data){
			data[p]['connections'] = JSON.parse(data[p]['connections']) || {};
			var clzName = data[p]['className'] || 'def';

			var bIn = isinattrs(books,clzName);
			if(!bIn){
				books.push({'clzName':clzName,'tels':[data[p]]});
			}
			else{
				bIn['tels'].push(data[p]);
			}
		}
		console.log(books);
		$('#booktbs').html(template('tplbook', {data:books}));

	}).fail(function() {
		alert('加载失败，请刷新页面重试');
	});
});
</script>
</body>
</html>