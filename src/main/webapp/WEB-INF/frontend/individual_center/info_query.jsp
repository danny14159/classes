<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心——信息查询</title>
<link rel="stylesheet" href="f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="f/assets/css/header.css" />
<style type="text/css">
#queryResult{margin-top: 15px;}
</style>
<script type="text/javascript" src="f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="1" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<jsp:include page="/include_lsidebar">
					<jsp:param value="3" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>个人资料——信息查询</h2>
							<button class="ui-button ui-button-mblue" onclick="queryGrade();">在校成绩</button>
							<button class="ui-button ui-button-mblue" onclick="getBookBorrowing()">图书馆借书情况</button>
							<button class="ui-button ui-button-mblue" onclick="getSchoolCardInfo();">校园一卡通</button>
							<button class="ui-button ui-button-mblue" onclick="getTimetable();">本学期课表</button>
							<button class="ui-button ui-button-mblue" onclick="getCommonBicycle();">公共自行车</button>
							<div id="queryResult"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/include_footer"/>
<script type="text/html" id="tplgrade">
<p class="text text-weak">请确认信息门户的密码，以保证顺利获取成绩</p>
<h3>2014-2015学年 第1学期成绩</h3>
</script>
<script type="text/html" id="tpltimetable">
<p class="text text-weak">请确认信息门户的密码，以保证顺利获取课表</p>
<h3>2014-2015学年 第2学期 学生个人课程表</h3>
</script>
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript">
function getCommonBicycle(){
	
}
function getTimetable(){
	var load = layer.load("课表获取中……");
	$.get('/iq/qtt')
	.done(function(data){
		layer.close(load);
		if(data && data.ok){
			$('#queryResult').html($('#tpltimetable').html()+"<table class='ui-table'>"+data.msg+"</table>");
		}
		else alert(data.msg);
	});
}
function queryGrade(){
	var load = layer.load("成绩获取中，请稍等……");
	$.get('/iq/qg')
	.done(function(data){
		layer.close(load);
		if(data && data.ok){
			$('#queryResult').html($('#tplgrade').html()+"<table class='ui-table'>"+data.msg+"</table>");
		}
		else alert(data.msg);
	});
}
function getSchoolCardInfo(){
	var load = layer.load("余额获取中……");
	$.get('/iq/qsci')
	.done(function(data){
		layer.close(load);
		if(data && data.ok){
			try{
				var _d = JSON.parse(data.msg);
				$('#queryResult').html('<h1 style="font-size:25px">'+_d[0].description+'</h1>');
			}
			catch(e){
				alert('一卡通成绩暂时无法获取，请确认信息门户的密码否正确。');
			}
		}
		else alert(data.msg);
	});
}
function getBookBorrowing(){
	var load = layer.load("借书情况获取中……");
	$.get('/iq/qbb')
	.done(function(data){
		layer.close(load);	
		if(data && data.ok){
			try{
				if(!data.msg) data.msg="<h1 style=\"font-size:25px\">暂无借书！</h1>";
				$('#queryResult').html("<table class='ui-table'>"+data.msg+"</table>")
				.children('table').find('tr').each(function(){
					$(this).children('td:gt(5)').remove();
					$(this).children('td').removeAttr('bgcolor');
				});
				
			}
			catch(e){
				console.log(e.stack)
				alert('借书情况暂时无法获取，请确认信息门户的密码否正确。');
			}
		}
		else alert(data.msg);
	})
	.fail(function(){
		alert('借书情况暂时无法获取，请稍后重试！');
	});
}
$(function(){
	var param = location.hash;
	switch(param){
	case '#1015':queryGrade();break;
	case '#1025':getSchoolCardInfo();break;
	case '#1035':getBookBorrowing();break;
	}
})
</script>
</body>
</html>