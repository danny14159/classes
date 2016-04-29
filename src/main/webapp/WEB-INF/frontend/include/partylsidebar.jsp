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
    <c:if test="${isInParty==false }">
	<li class="tabOption"><a href="/iparty/enter" class="btn text text-plain">加入派对</a></li>
	<li class="tabOption"><a href="/iparty/myhistory"  class="btn text text-plain">派对历史</a></li>
    </c:if>
    <c:if test="${isInParty==true }">
      <li class="tabOption"><a href="/iparty/index"" class="btn text text-plain">派对中心</a></li>
      <li class="tabOption"><a href="/iparty/myhistory"  class="btn text text-plain">派对历史</a></li>
      <li class="tabOption"><a href="/iparty/my"  class="btn text text-plain">我的派对</a></li>
      <li class="tabOption"><a href="javascript:;" onclick="exitparty();" class="btn text text-plain">离开派对</a></li>
	</c:if>
</ul>

<script>
function enterparty(){
	location.href="/iparty/enter"
}
function exitparty(){
	if(confirm("确认退出派对？")){
		$.get('/party/exit',function(data){
			if(data && data.ok){
				alert('退出成功。');location.href="/iparty/index"
			}
			else if(data.msg) alert(data.msg);
		},'json');
	}
}
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