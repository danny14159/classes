<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心——消息管理</title>
<link rel="stylesheet" href="f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="f/assets/css/header.css" />
<style type="text/css">
#tbmsg{margin-top: 21px;}
.stu img.avt{margin-right: 7px;}
.stu .bordered-img{width:60px;height:60px;float: left;}
.stu p{padding-left: 67px;}
.xubox_page{width:100%;}
#domdet .head{width:91%;margin: 10px auto;border:1px solid #666;padding: 10px 20px;}
#domdet .cont{width:90%;padding: 15px;}
</style>
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
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
					<jsp:param value="2" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>我的消息</h2>
							<!-- <button class="ui-button ui-button-mblue" onclick="location.href='/icenter_newmsg'">写消息</button> -->
							<button class="ui-button ui-button-mwhite" onclick="loadmsg('U')">只看未读</button>
							<button class="ui-button ui-button-mwhite" onclick="loadmsg()">查看所有</button>
							
							<h3>收信箱</h3>
							<div class="ui-table-container">
    <table class="ui-table ui-table-inbox" id="tbmsg">
        <thead>
            <tr>
                <th width="5%"><input type="checkbox" id="ckall"/></th>
                <th>状态</th>
                <th>发送时间</th>
                <th>发送人</th>
                <th>类型</th>
                <th>操作</th>
            </tr>
        </thead><!-- 表头可选 -->
        <tbody>
        	
        </tbody>
        <tfoot>
            <tr>
                <td colspan="5">批量操作：<a href="#" class="link text text-plain">删除</a> | <a href="#" class="link text text-plain">标记为已读</a></td>
            </tr>
        </tfoot><!-- 表尾可选 -->
    </table>
</div>
							<h3>发信箱</h3>
							<div class="ui-table-container">
    <table class="ui-table ui-table-inbox" id="tbsndmsg">
        <thead>
            <tr>
                <th width="5%"><input type="checkbox" id="ckall"/></th>
                <th>状态</th>
                <th>发送时间</th>
                <th>收信人</th>
                <th>类型</th>
                <th>操作</th>
            </tr>
        </thead><!-- 表头可选 -->
        <tbody>
        	
        </tbody>
        <tfoot>
            <tr>
                <td colspan="5">批量操作：<a href="#" class="link text text-plain">删除</a></td>
            </tr>
        </tfoot><!-- 表尾可选 -->
    </table>
</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<div id="domdet" style="display: none;width:100%;">

</div>

<script type="text/html" id="tpldet">
<div class="head">
		<dl class="ui-dlist">
		    <dt class="ui-dlist-tit">发送人：</dt>
		    <dd class="ui-dlist-det">
		    <a href="#" class="btn stu"><div class="bordered-img"><img src="{{sender.avatar}}" alt="logo" class="avt" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,60,60)"></div>
        		<p class="text text-plain">{{sender.name}}</p><p class="text text-weak">来自{{sender.univName}}{{sender.clzName}}</p>
        	</a>
		    </dd>
		    <dt class="ui-dlist-tit">发送时间：</dt>
		    <dd class="ui-dlist-det">{{sendTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</dd>
		    <dt class="ui-dlist-tit">消息类型：</dt>
		    <dd class="ui-dlist-det">
{{if type=="S"}}<span class="text text-warning">系统消息</span>
{{else if type=="C"}}<span class="text text-sky">普通消息</span>
{{else}}
	<span class="text text-plain">未知消息</span>
{{/if}}
			</dd>
		</dl>
	</div>
	<div class="cont">{{content}}</div>
</script>
	
	<jsp:include page="/include_footer" />
<script type="text/html" id="tplmsg">
{{each data as val i}}
<tr>
        		<td><input type="checkbox" name="ckone"/></td>
        		<td>
{{if val.msg.state=="U"}}
	<span class="text text-warm">未读</span>
{{else if val.msg.state=="R"}}
	<span class="text text-success">已读</span>
{{else}}
	<span class="text text-plain">未知</span>
{{/if}}
</td>
        		<td>{{val.msg.sendTime | dateFormat:'yyyy-MM-dd hh:mm'}}</td>
        		<td>
        			<a href="javascript:;" class="btn stu"><div class="bordered-img"><img src="{{val.stu.avatar}}" alt="logo" class="avt" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,60,60)"/></div>
        				<p class="text text-plain">{{val.stu.name}}</p><p class="text text-weak">来自{{val.stu.univName}}{{val.stu.clzName}}</p>
        			</a>
        		</td>
        		<td>
{{if val.msg.type=="S"}}<span class="text text-warning">系统</span>
{{else if val.msg.type=="C"}}<span class="text text-sky">普通</span>
{{else}}
	<span class="text text-plain">未知</span>
{{/if}}
</td>
        		<td><p><a href="javascript:;" 
onclick="msgdetail({{val.msg.id}},{univName:'{{val.stu.univName}}',name:'{{val.stu.name}}',claName:'{{val.stu.clzName}}',avatar:'{{val.stu.avatar}}' })"  
class="link text text-plain">查看详情</a> | <a href="/icenter_newmsg?no={{val.stu.no}}&classId={{val.stu.classId}}" class="link text text-plain">回复</a></p>
        		<p><a href="javascript:;" onclick="delr({{val.msg.id}})" class="link text text-weak">删除</a></p></td>
        	</tr>
{{/each}}
</script>
<script type="text/html" id="tplsndmsg">
{{each data as val i}}
<tr>
        		<td><input type="checkbox" name="ckone"/></td>
        		<td>
{{if val.msg.state=="U"}}
	<span class="text text-warm">未读</span>
{{else if val.msg.state=="R"}}
	<span class="text text-success">已读</span>
{{else}}
	<span class="text text-plain">未知</span>
{{/if}}
</td>
        		<td>{{val.msg.sendTime | dateFormat:'yyyy-MM-dd hh:mm'}}</td>
        		<td>
        			<a href="javascript:;" class="btn stu"><div class="bordered-img"><img src="{{val.stu.avatar}}" alt="logo" class="avt" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,60,60)"/></div>
        				<p class="text text-plain">{{val.stu.name}}</p><p class="text text-weak">来自{{val.stu.univName}}{{val.stu.clzName}}</p>
        			</a>
        		</td>
        		<td>
{{if val.msg.type=="S"}}<span class="text text-warning">系统</span>
{{else if val.msg.type=="C"}}<span class="text text-sky">普通</span>
{{else}}
	<span class="text text-plain">未知</span>
{{/if}}
</td>
        		<td><p><a href="javascript:;" 
onclick="msgdetail({{val.msg.id}},{univName:'{{val.stu.univName}}',name:'{{val.stu.name}}',claName:'{{val.stu.clzName}}',avatar:'{{val.stu.avatar}}' })"  
class="link text text-plain">查看详情</a></p>
        		<p><a href="javascript:;" onclick="dels({{val.msg.id}})" class="link text text-weak">删除</a></p></td>
        	</tr>
{{/each}}
</script>

<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript">

template.helper('dateFormat',FormatDate);//添加辅助函数
$(function(){
	loadmsg();
})
function loadmsg(state){
	var param = {
		ps:20,pn:1	
	};
	if(state) param['state'] = state;
	$.post('/msg/listr',param,function(data){
		$('#tbmsg tbody').html(template('tplmsg', {data:data}));
	},'json');
	$.post('/msg/lists',param,function(data){
		$('#tbsndmsg tbody').html(template('tplsndmsg', {data:data}));
	},'json');
}
function delr(id){
	if(confirm("确认删除这条消息？"))
	$.get('/msg/delr?id='+id,function(data){
		if(data && data.ok){
			alert('删除成功！');loadmsg();
		}
		else alert('删除失败！');
	},'json');
}
function dels(id){
	if(confirm("确认删除这条消息？"))
	$.get('/msg/dels?id='+id,function(data){
		if(data && data.ok){
			alert('删除成功！');loadmsg();
		}
		else alert('删除失败！');
	},'json');
}

function msgdetail(id,sender){
	//加载数据，更新dom
	if(id)
	$.get('/msg/read?id='+id,'json')
	.done(function(data){
		console.log(data);
		data.sender = sender||{};
		$('#domdet').html(template('tpldet',data));
	//弹窗
		$.layer({
			type:1,
			title:'查看消息详情',
			maxmin:true,
			area:['800px','600px'],
			border: [10, 0.3, '#000'],
			shade: [0.5, '#000'],
			closeBtn: [1, true],
			btns:0,
			page: {
				dom: '#domdet',
				ok: function(datas){}
			},
			close:function(){loadmsg();}
		});
	});
	
}
</script>
</body>
</html>