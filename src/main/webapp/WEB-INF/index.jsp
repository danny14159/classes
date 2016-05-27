<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<title>班级主页 | 班级派对 | 同学交友，欢迎你：）</title>
<meta name="description" content="班级主页 | 班级派对  | 同学交友">
<meta name="author" content="danny">
<link rel="stylesheet" href="/f/assets/css/index.css" />
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
	<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<%-- 

未完成作业：,
来自：,
班级介绍<p></p>,
班费余额：,
班级LOGO:<img src="${clz.logo }" alt="logo"/>
我的头像：<img src="${me.avatar }" alt="avatar" onerror="this.onerror=null;this.src='f/assets/img/defavatar.jpg';"/> --%>


	<jsp:include page="/include_header"/>
	<jsp:include page="/include_content">
		<jsp:param name="i" value="0" />
	</jsp:include>

	<div class="wrapper" id="row1">
		<div class="ui-grid-row">
			<div id="focus" class="pics">
			<ul>
				<li><a href="#"><img src="f/assets/img/demo/1.jpg"/><div class="shade"><p class="desc">图书馆后山</p></div></a></li>
				<li><a href="#"><img src="f/assets/img/demo/2.jpg"/><div class="shade"><p class="desc">后山美景:)</p></div></a></li>
				<li><a href="#"><img src="f/assets/img/demo/3.jpg"/><div class="shade"><p class="desc">美景：）</p></div></a></li>
				<li><a href="#"><img src="f/assets/img/demo/4.jpg"/><div class="shade"><p class="desc">湖面如镜</p></div></a></li>
				<li><a href="#"><img src="f/assets/img/demo/5.jpg"/><div class="shade"><p class="desc">放飞“企鹅”</p></div></a></li>
			</ul>
		</div>

			 <div class="intro">
				<div class="ui-box">
					<div class="ui-box-container">
						<div class="ui-box-content"><a href="icenter_sys_mgr" class="text text-warm">班级简介</a></div>
						<p>${clz.intro }</p>
					</div>
				</div>
			</div> 
			<div class=" icenter">
				<div class="ui-box">
					<div class="ui-box-head">
						<h3 class="ui-box-head-title"><a href="#" class="btn text text-warm"><i class="iconfont icon-xiaozhushou"></i>个人中心</a></h3>
						<!--  <span class="ui-box-head-text">==</span> -->
						<a href="#" class="ui-box-head-more link"><i class="iconfont icon-xiangxia"></i></a>
					</div>
					<div class="ui-box-container">
						<div class="ui-box-content">
							<ul class="ilist">
								<li><i class="iconfont icon-youjian text text-sky"></i><a href="/icenter_msg_mgr" class="btn text text-dark">未读消息：<span class="text text-warning link">${cumsg }</span></a></li>
								<li><i class="iconfont icon-wenzhang text text-sky"></i><a href="/publics/homework" class="btn text text-dark">未交作业：<span class="text text-warning link">${cuhomew }</span></a></li>
								<!-- <li><a href="javascript:;" class="btn text text-dark">最近实验：<span class="text text-warning link">1</span></a></li>
								<li><a href="javascript:;" class="btn text text-dark">最近活动：<span class="text text-warning link">2</span></a></li> -->
								<li><a class="text text-weak" href="javascript:alert('平台app即将上线，敬请期待');">设置提醒</a></li>
								<li><a class="text text-weak" href="/icenter_updpwd">修改密码</a></li>
							</ul>
							<div class="info">
								<div class="avatar bordered-img"><a href="icenter_individual_info_avatar">
								<img src="${me.avatar }thumb102-102" alt="avatar" onerror="this.onerror=null;this.src='f/assets/img/defavatar.jpg';" onload="FillImage(this,102,102)"/>
								</a></div>
								<p><a href="/icenter_individual_info_basic" class="text text-sky">${me.name }</a>同学，<br/>下午好</p>
							</div>
							<div class="btngroup">
								<button class="ui-button ui-button-morange" onclick="location.href='/icenter_info_query#1015'">在校成绩</button>
								<button class="ui-button ui-button-mblue" onclick="location.href='/icenter_info_query#1025'">一卡通</button>
								<button class="ui-button ui-button-mblue" onclick="location.href='/icenter_info_query#1035'">图书馆借还</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="wrapper " id="row2">
		<div class=" ui-box party">
			<div class="ui-box-head"><a href="#" class="btn text text-warm">单身派对</a></div>
			<div class="ui-box-container">
				<div class="ui-box-content ui-grid-row" id="party">
				</div>
			</div>
		</div>
		<div class="commons ui-box">
			<div class="ui-box-head"><a href="#" class="btn text text-warm">公共信息</a></div>
			<div class="ui-box-container">
				<div class="ui-box-content">
					班费余额:<p class="text text-warm"><i class="iconfont icon-renminbi"></i>${clz.balance }</p>
					<ul>
						<li class=""><input type="button" class="ui-button ui-button-mwhite text text-warm" value="作业管理" onclick="location.href='/publics/homework'"></li>
						<li class=""><input type="button" class="ui-button ui-button-mwhite text text-sky" value="班费管理" onclick="location.href='/publics/fee'"></li>
						<li class=""><input type="button" class="ui-button ui-button-mwhite text text-success" value="班级通讯录" onclick="location.href='/publics/telbook'"></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/include_footer"/>

<div id="elevator_item">
        <a id="elevator" onclick="return false;" title="回到顶部"></a>
        <a class="qr"></a>
  	<div class="qr-popup">
    	<a class="code-link"><img class="code" src="/f/assets/img/wx.jpg"/></a>
        <span>扫一扫加微信好友</span>
    <div class="arr"></div>
  </div>
  
</div>


	
	<script type="text/javascript" src="/f/assets/js/laytpl.js"></script>
	<script type="text/javascript" src="/f/assets/js/jquery.jqfader.js"></script> 
	 
	<script type="text/javascript" src="/f/assets/js/index.js"></script>
<script type="text/html" id="tplparty">
{{# for(var i = 0, len = d.length; i < len; i++){ }}
<div class="item fader"><a href="/iparty/show{{ d[i].no }}-{{ d[i].clzId }}" class="imglink"><img src="{{ d[i].avatar }}thumb102-102" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,102,102)"/></a>
				<div class="abstract">
					<p class="name"><a href="/iparty/show{{ d[i].no }}-{{ d[i].clzId }}" class="text text-dark">{{ d[i].name }}</a></p>
					<p class="from"><a href="javascript:;" title="{{ d[i].univName }}{{ d[i].collegeName }}{{ d[i].profName }}{{ d[i].clzName }}" class="btn text text-plain">
					来自{{ d[i].univName }}{{ d[i].clzName }}</a></p>
					<p class="interact">
{{#if(d[i].bpraise==true){ }}
	<a class="btn text text-warm h-text-warm" href="javascript:;" onclick="return;interact(this,'text-warm','praise','{{ d[i].no }}',{{ d[i].clzId }},true);"><i class="iconfont icon-zanyang"></i>{{ d[i].praise }}</a>
{{# } }}
{{#if(d[i].bpraise==false){ }}
	<a class="btn text text-weak h-text-warm" href="javascript:;" onclick="return;interact(this,'text-warm','praise','{{ d[i].no }}',{{ d[i].clzId }});"><i class="iconfont icon-zanyang"></i>{{ d[i].praise }}</a>
{{# } }}
{{#if(d[i].bflower==true){ }}
	<a class="btn text text-sky h-text-sky" href="javascript:;" onclick="return;interact(this,'text-sky','flower','{{ d[i].no }}',{{ d[i].clzId }},true);"><i class="iconfont icon-weiju"></i>{{ d[i].flower }}</a>
{{# } }}
{{#if(d[i].bflower==false){ }}
	<a class="btn text text-weak h-text-sky" href="javascript:;" onclick="return;interact(this,'text-sky','flower','{{ d[i].no }}',{{ d[i].clzId }});"><i class="iconfont icon-weiju"></i>{{ d[i].flower }}</a>
{{# } }}
{{#if(d[i].blove==true){ }}
	<a class="btn text text-warning h-text-warning" href="javascript:;" onclick="return;interact(this,'text-warning','love','{{ d[i].no }}',{{ d[i].clzId }},true);"><i class="iconfont icon-xiai"></i>{{ d[i].love }}</a>
{{# } }}
{{#if(d[i].blove==false){ }}
	<a class="btn text text-weak h-text-warning" href="javascript:;" onclick="return;interact(this,'text-warning','love','{{ d[i].no }}',{{ d[i].clzId }});"><i class="iconfont icon-xiai"></i>{{ d[i].love }}</a>
{{# } }}
 </p>
</div>
</div>
{{# } }}
</script>
</body>
</html>