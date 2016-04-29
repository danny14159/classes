<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link href="/f/assets/css/lsidebar.css" rel="stylesheet"/>
<div class="info">
		<div class="avatar bordered-img"><a href="/icenter_individual_info_avatar">
		<img src="${me.avatar }thumb102-102" alt="avatar" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,102,102);"/>
		</a>
		<a href="/icenter_individual_info_avatar" class="btnshade">设置头像</a>
		</div>
		<p style="margin: 0 -15px;"><a href="#" class="text text-sky">${me.name }</a>同学，下午好</p>
	</div>
    <div id="sliderParent"></div>
    <div class="blueline" id="blueline"></div>
    <ul class="tabGroup">
		<li class="tabOption"><a href="/publics/homework" class="btn text text-plain">作业</a></li>
		<li class="tabOption"><a href="/publics/nhomework" class="btn text text-plain">新作业</a></li>
      <li class="tabOption"><a href="/publics/fee" class="btn text text-plain">班费</a></li>
      <li class="tabOption"><a href="/publics/telbook"  class="btn text text-plain">班级通讯录</a></li>
      <li class="tabOption"><a href="/publics/notice"  class="btn text text-plain">公告</a></li>
</ul>
<script>
(function(index){
	 index = index || 1;
	var $li = $('.tabGroup li').eq(index-1).addClass('selectedTab');
	$li.siblings().children('a').addClass('text-plain');
	$li.children('a').removeClass('text-plain');
	
	$('#blueline').css('top',173+$li.height()*(index-1)) ;
	
	$('.avatar').mouseover(function(){
		$(this).find('.btnshade').stop(true,false).animate({bottom:0},100);
	})
	.mouseout(function(){
		$(this).find('.btnshade').stop(true,false).animate({bottom:'-18px'},50);
	});
})(<%=request.getParameter("index")%>);
</script>