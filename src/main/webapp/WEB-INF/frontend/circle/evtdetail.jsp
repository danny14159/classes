<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班集-班级圈-事件详情</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/circle.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="/f/assets/js/header.js"></script>
<style type="text/css">
#evtpics{margin-left: -25%;}
</style>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="4" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<div class="container">
					<div class="content">
						<div class="tabContent">
						<a href="/circle/index">&lt;&lt;返回班级圈</a>
							<div class="cc-header">
								<h1 class="cc-title">“${evt.title }”</h1>
								<hr class="cc-hr"/>
							</div>
							<div class="cc-content">
								<p><span class="text text-warm">【楼主】【<c:if test="${evt.type==73 }">个人</c:if><c:if test="${evt.type==71 }">集体</c:if>活动】</span>${publisher.univName }&nbsp;${publisher.collegeName }&nbsp;${publisher.profName }&nbsp;${publisher.clzName }&nbsp;${publisher.name }&nbsp;</p>
								<p><span class="text text-warm">【描述】</span>${evt.desc }</p>
								<p><span class="text text-warm">【赞】</span>${evt.npraise }
									
									<button onclick="praise(${evt.id });">赞</button>
								</p>
								<p id="evtpics">${evt.pics }</p>
							</div>
							<div class="cc-header">
								<h1 class="cc-title">评论（${evt.ncomment }）</h1>
								<hr class="cc-hr"/>
							</div>
							<div class="cc-content" id="cmtbody">
								<!-- <label class="cc-label">
									我也说一句：
								</label>
								<div class="cc-body">
									<textarea rows="4" cols="60" id="mainComment"></textarea>
									<p><button class="ui-button ui-button-morange" onclick="onComment();">确定</button></p>
								</div>
								<label class="cc-label">
									<a href="#">甲学生</a>：
								</label>
								<div class="cc-body">
									<div class="cc-remark">评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容<a href="#">回复</a></div>
									<div class="cc-timestamp">2015-02-14 14:08 </div>
								</div>
								<label class="cc-label">
									<a href="#">乙学生</a>回复<a href="#">甲学生</a>：
								</label>
								<div class="cc-body">
									<div class="cc-remark">评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容
									评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容<a href="#">回复</a></div>
									<div class="cc-timestamp">2015-02-14 14:08 </div>
								</div> -->
							</div>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/javascript">
function praise(evtid){
	$.get('/evtp/ins?evtid='+evtid,'json')
	.done(function(data){
		if(data){
			location.reload();
		}
		else alert('你已赞过！');
	})
}
$(function(){
	var pics = $('#evtpics').html().split(';');
	$('#evtpics').empty();
	$.each(pics,function(index,value){
		console.log(index,value)
		$('<a target="evtpics">').attr('href',value).append(
			$('<img class="">').attr('src',value+'thumb284-250').css({
				width:'284px',
				height:'250px',
				marginRight:'15px',
				marginBottom:'15px'
			})
		).appendTo('#evtpics');
	});
	
	//load comment
	loadComment();
	
});
function onComment(){
	var content = $('#mainComment').val();
	if(!content){ alert('写点什么再发表吧~');return false;}
	$.post('/evtcmt/comment',{
		content:content,
		evtid:'${evt.id}'
	},'json')
	.done(function(data){
		if(data && data.ok) {location.reload();}
		else alert(data.msg);
	});
}
function onCancelComment(){
	$('#replyFrame').remove();	
}
function loadComment(){
	$.get('/evtcmt/loadcmt',{
		evtid:'${evt.id}'
	},'json')
	.done(function(data){
		$.each(data,function(i,v){
			//缓存学号姓名信息
			window.stuCache = window.stuCache || {};
			window.stuCache[v.stuClz] = window.stuCache[v.stuClz] || {};
			window.stuCache[v.stuClz][v.stuNo] = v.stuName;
		});
		$.each(data,function(i,v){
			if(v.replyClz && v.replyNo){
				v['replyInfo'] = '回复'+window.stuCache[v.replyClz][v.replyNo];
			}
			else v['replyInfo'] = "说";
		})
		template.helper('FormatDate',FormatDate);
		$('#cmtbody').html($('#tplicmt').html()+template('tplcmt', {data:data}));
	});
}
function onReply(replyNo,replyClz,replyName,btn){
	if(!$('#replyFrame').length || confirm('您有未保存的回复内容，确定不保存？')){
		$('#replyFrame').remove();
			$('<div id="replyFrame">')
			.html('<input type="text" placeHolder="回复'+replyName+'"/>')
			.append($('<button>回复</button>').attr('onclick','submitReply(\''+replyNo+'\','+replyClz+');'))
			.append($('<button onclick="onCancelComment();">取消</button>'))
			.appendTo($(btn).closest('.cc-body'))
		 $('#replyFrame input').focus();
	}
}
function submitReply(replyNo,replyClz){
	var content = $('#replyFrame input').val();
	if(!content){ alert('写点什么再发表吧~');return false;}
	$.get('/evtcmt/comment',{
		evtid:'${evt.id}',
		replyNo:replyNo,
		replyClz:replyClz,
		content:content,
	},'json')
	.done(function(data){
		loadComment();
	});
}
function loadStuBrief(no,classId){
	$.get('/stu/brief',{
		no:no,
		classId:classId
	},'json')
	.done(function(data){
		
	})
}
</script>
<script type="text/html" id="tplicmt">
 <label class="cc-label">
		我也说一句：
			</label>
			<div class="cc-body">
			<textarea rows="4" cols="60" id="mainComment"></textarea>
			<p>
<button class="ui-button ui-button-morange" onclick="onComment();">确定</button>
</p>
		</div>
</script>
<script type="text/html" id="tplcmt">
{{each data as val i}}
<label class="cc-label">
<span style="display:none">{{val.id}}</span>
<a href="javascript:;" onmouseover="loadStuBrief('{{val.stuNo}}',{{val.stuClz}});">{{val.stuName}}</a>{{val.replyInfo}}：
</label>
<div class="cc-body">
<div class="cc-remark">{{val.content}}<a href="javascript:;" onclick="onReply('{{val.stuNo}}',{{val.stuClz}},'{{val.stuName}}',this)">回复</a></div>
<div class="cc-timestamp">{{val.time | FormatDate:'yyyy-MM-dd hh:mm'}}</div>
</div>
{{/each}}
</script>
<jsp:include page="/include_footer" />
</body>
</html>