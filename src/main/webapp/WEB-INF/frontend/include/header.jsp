<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link href="/f/assets/css/jquery.dialogbox-1.0.css" rel="stylesheet"/>
    <script type="text/javascript" src="/f/assets/js/jquery.dialogbox-1.0.js"></script>
<script type="text/javascript" src="/f/assets/js/header.js"></script>
<script type="text/javascript">
//重写alert和confirm方法
//-->
//type取值：normal,warning,success,error,yes/no
	$(document).keydown(function(e){
	    if(!e) var e = window.event;
	    //alert("键盘按键的 keycode 是 " + e.keyCode);
	})
window.alert=function(msg,title,type,callback){
	if(typeof arguments[1] == 'function'){
		callback = arguments[1];
		title = type = 0;
	}
	$('body').dialogbox({type:type||"normal",title:title||"提示",message:msg},callback);
}
</script>
<div id="header">
	<div id="hdCon">
	<div class="bklogo-46"></div>
	<span class="stu">欢迎你，<a href="#">${me.name }</a>同学</span>
	<i class="iconfont icon-youjian"></i>&nbsp;未读消息：<a href="/icenter_msg_mgr">${cumsg }条</a>
	<div class="opt">
	<c:if test="${me.type==83 }">
		<span><a href="/b/ptl">后台管理</a></span>|</c:if>
		<span><i class="iconfont icon-shoucang"></i><a href="javascript:;" onclick="addToFav(window.location,document.title);">加入收藏</a></span>|
		<span><i class="iconfont icon-haoyou"></i><a href="/exhibition">功能演示</a></span>|
		<span class="exit"><i class="iconfont icon-tuichu"></i><a href="/logout">退出登录</a></span>
	</div>
	</div>
</div>