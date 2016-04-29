<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>作业管理</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<style type="text/css">
.tbhw{margin-top: 15px;border: 1px solid #fff;}
.circle{border:1px solid #666;background: #fff;width:8px;height:8px;border-radius:50%;}
.tbhw table tr td{vertical-align: top;}
.tbhw:hover{border:1px solid red;cursor: pointer;background: #f3f3f3; 
box-shadow:0 0 10px rgba(244, 0, 0, .5); -webkit-box-shadow:0 0 10px rgba(244, 0, 0, .5);  
  -moz-box-shadow:0 0 10px rgba(244, 0, 0, .5);   }
.ui-table td{border-bottom: none;}
hr{margin: 15px 0;border-top: 1px solid #eee;}
.ui-table tr:nth-child(even), .ui-table-split, .ui-table-hover{background-color: inherit;}
</style>
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
					<jsp:param value="1" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>我的作业</h2>
							<button class="ui-button ui-button-mblue" onclick="loadhw();">查看最近50条作业</button>
							<button class="ui-button ui-button-mblue">+添加新作业</button>
							<button class="ui-button ui-button-mblue">设置提醒</button>
							<h3 id="titlehw"></h3>
							<div id="renderhw"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
<script type="text/html" id="tplhw">
{{each list as val i}}
<table class="ui-table tbhw ">
							        <thead>
							            <tr>
							                <th width="10%"><div class="circle"></div></th>
							                <th width="20%">状态
<span class="text text-warning">
{{val.expire | state:''}}
</span>
</th>
							                <th width="20%">科目<span class="text text-warning">{{val.subject}}</span></th>
							                <th width="40%">交作业日期<span class="text text-warning">{{val.expire}}（{{val.expire | moment:''}}）</span></th>
							                <th width="10%"><span class="text text-weak h-text-warning">
<span onclick="delhw({{val.id}});">删除</span>
<em class="ft-bar">|</em>
<span onclick="location.href='/publics/nhomework?param='+'{{val.id}}'">修改</span>
</span></th>
							            </tr>
							        </thead>
							        <tbody style="display:none;">
							            <tr>
							                <td colspan="5">
							                	<table class="ui-table ui-table-noborder">
							                		<tbody>
							                			<tr>
							                				<td width="15%">
																<span class="text text-warm">作业内容</span>
															</td>
							                				<td>
							                				<div class="ui-poptip ui-poptip-blue">
															    <div class="ui-poptip-shadow">
															        <div class="ui-poptip-container">
															            <div class="ui-poptip-arrow ui-poptip-arrow-10">
																                <em></em>
															                <span></span>
															            </div>
															            <div class="ui-poptip-content">
															                <div>{{val.subject}}</div>
															                <div>{{val.content}}</div>
															                <div>
															                </div>
															            </div>
															        </div>
															    </div>
															</div>
							                				</td>
							                			</tr>
{{if val.expireAdd}}
							                			<tr>
							                				<td>
															<span class="text text-warm">补充说明</span>
							                				</td>
							                				<td>{{val.expireAdd}}</td>
							                			</tr>
{{/if}}
{{if val.pics.length}}
							                			<tr>
							                				<td>
							                					<span class="text text-warm">图片附件</span>
							                				</td>
							                				<td>
{{each val.pics as pic index}}
<a href="{{pic}}" target="hwpics"><img src="{{pic}}thumb110-110"/></a>
{{/each}}
</td>
							                			</tr>
{{/if}}
							                		</tbody>
							                	</table>
							                </td>
							            </tr>
							        </tbody>
							</table>
<hr/>
{{/each}}
</script>
<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/javascript" src="/f/assets/moment/moment.js"></script>
<script type="text/javascript" src="/f/assets/moment/lang/zh-cn.js"></script>
<script type="text/javascript">
function delhw(id){
	if(confirm('确认删除这条作业？'))
	$.get('/homework/del/'+id,'json')
	.done(function(data){
		if(data) {alert('删除成功');location.reload();}
		else alert('系统繁忙，稍后再试！');
	})
}
function loadhw(unfinished){
	var param=null;
	if(unfinished){
		$('#titlehw').html('今天和未来的作业');
		param = {ps:20,pn:1,expire:moment().add('days',-1).format('YYYY-MM-DD')};
	}
	else {$('#titlehw').html('最近50条作业');param = {ps:50,pn:1};}
	$.post("/homework/lstp",param,'json')
	.done(function(data){
		if(!data){
			alert('加载失败，请稍后重试！');
		}
		for(var i in data.list){
			var d = data['list'][i];
			var tempstr = d.pics||'';
			d.pics = tempstr?tempstr.split(';'):[];
		}
		$('#renderhw').html(template('tplhw', data));
		
		//添加单击事件
		$('.tbhw thead').bind('click',function(){
			$(this).siblings('tbody').toggle(200);
		});
	})
	.fail(function(){
		alert('加载失败，请稍后重试！');
	});
}
$(function(){
	moment.lang('zh-cn');
	template.helper('moment', function (date) {
		return moment(date).fromNow();
	});
	template.helper('state', function (date) {
		return moment(date).isBefore(moment())?'已完成':'未完成';
	});
	
	loadhw(true);
	
})
</script>
</body>
</html>