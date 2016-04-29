<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="content" class="wrapper">
	<div class="top">
		<div class="logo"><a href="#"><img src="${clz.logo }thumb118-118" alt="logo" onload="FillImage(this,118,118)" onerror="this.onerror=null;this.src='/f/assets/img/defclzlogo.jpg';"/></a></div>
		<div class="row">
			<div class="banner"><img alt="联系管理员设置班级banner" src="/f/assets/img/xuehua.bmp" onload="FillImage(this,1133,109)" onerror="onerror=null;this.src='';"></div>
		</div>
		<div class="row">
			<div class="clzIntro">
				<h1 class="clzName"><a href="#">${clz.name }</a></h1>
				<div class="clzOther">${mebrief.univName }&nbsp;&nbsp;${mebrief.collegeName }&nbsp;&nbsp;${mebrief.profName }</div>
				<div class="showHome">
					<span>晒主页</span>
					<ul class="sharelist">
						<li><div id="qqwb_share__" data-appkey="801562040" data-icon="1" data-counter="0" data-content="#晒主页#快来看看${mebrief.collegeName }${clz.name }的主页吧~~" data-pic="{pic}"></div></li>
						<!-- <li><a title="转发到微信" target="_blank" href="#"><span class="ico ico-weixin"></span></a></li>
						<li><a title="转发到QQ空间" target="_blank" href="#"><span class="ico ico-qzone"></span></a></li>
						<li><a title="转发到新浪微博" target="_blank" href="#"><span class="ico ico-weibo"></span></a></li> -->
						<!-- <script src="http://mat1.gtimg.com/app/openjs/openjs.js#autoboot=no&debug=no"></script> -->
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="menu" class="row">
	<div class="ui-nav">
	<div class="menu-back"></div>
  <ul class="ui-nav-main">
    <li class="ui-nav-item">
      <a href="/index-p">首页</a>
    </li>
    <li class="ui-nav-item">
      <a href="javascript:;">我的</a>
      <ul class="ui-nav-submain">
        <li class="ui-nav-subitem"><a href="/icenter_individual_info_basic">我的资料</a></li>
        <li class="ui-nav-subitem"><a href="/icenter_msg_mgr">消息</a></li><!-- ui-nav-subitem-current -->
        <li class="ui-nav-subitem"><a href="/icenter_info_query">信息查询</a></li>
        <li class="ui-nav-subitem"><a href="/icenter_iw_complain">我要投诉</a></li>
        <li class="ui-nav-subitem"><a href="/icenter_sys_mgr">班级设置（班委）</a></li>
      </ul>
    </li>
    <li class="ui-nav-item">
      <a href="javascript:;">公共信息</a>
      <ul class="ui-nav-submain">
        <li class="ui-nav-subitem"><a href="/publics/homework">作业</a></li>
        <li class="ui-nav-subitem"><a href="/publics/fee">班费</a></li>
        <li class="ui-nav-subitem "><a href="/publics/telbook">班级通讯录</a></li>
        <li class="ui-nav-subitem "><a href="/publics/notice">公告</a></li>
      </ul>
    </li>
    <li class="ui-nav-item"><a href="/iparty/index">单身派对</a></li>
    <li class="ui-nav-item"><a href="/circle/index">班级圈</a></li>
    <li class="ui-nav-item"><a href="/icenter_info_query">一键查询</a></li>
    <li class="ui-nav-item"><a href="${clz.weibo }" target="_blank">班级微博</a></li>
  </ul>
  <div class="ui-nav-subcontainer" style="display: none;"></div>
</div>
	</div>
</div>
<div id="suggest">
<div class="ui-poptip">
    <div class="ui-poptip-shadow">
    <div class="ui-poptip-container">        
        <div class="ui-poptip-arrow ui-poptip-arrow-7">
            <em></em>
            <span></span>
        </div>
        <div class="ui-poptip-content">
            在这里写下您宝贵的建议:
        </div>
    </div>
    </div>
</div>
<textarea rows="4" cols="50" name="content"></textarea>
<input type="button" value="提交" class="ui-button ui-button-swhite" onclick="onSuggest();"/>
<p class="title">《<br/>我来提建议</p>
</div>
<script>
function onSuggest(){
	var content = $('#suggest textarea').val();
	if(!content) {alert('写点什么再提交吧~');return;}
	$.get('/feed/ins',{content:content})
	.done(function(data){
		$('#suggest textarea').val('');
		if(data) alert('感谢你给我们的反馈，帮助我们做的更好！');
		else alert('好像出错了~稍等一下吧')
	});
}
function initSuggset(){
	var width = $('#suggest').width();
	var showwidth = -width;
	$('#suggest').css('left',showwidth+'px').show()
	.mouseover(function(){
		$(this).stop(true,false).animate({'left':'0px'});
	}).mouseleave(function(){
		$(this).stop(true,false).animate({'left':showwidth+'px'});
	});
}
$(function(){
	initSuggset();
	menuCollapsed = true;
	
	//init menu effects
	var index = <%=request.getParameter("i")%>;
	
	var $subc = $('#menu div.ui-nav-subcontainer');
	
	function expandMenu(){
		if(window.$cunav) window.$cunav.stop(true,false).slideUp();
		/* if($(this).index() != index)
			$(this).removeClass('ui-nav-item-current'); */
		//$(this).addClass('ui-nav-item-current');
		var self = $(this);
		if($(this).children('ul.ui-nav-submain').length){
			$subc.stop(true,false).slideDown(150,function(){
				if(self.children('.ui-nav-submain'))
					$cunav = self.children('.ui-nav-submain');
				$cunav.slideDown(150);
			});
		}
		else $subc.stop(true,false).slideUp(150);
	};
	function packupMenu(){
		if(window.$cunav)window.$cunav.slideUp(150);
		if($(this).index() != index)
			$(this).removeClass('ui-nav-item-current');
	};
	
	$('#menu li.ui-nav-item')
	.mouseover(function(){
			expandMenu.apply(this);
			$(this).addClass(':hover');
		/* if(window.menuCollapsed){
			expandMenu.apply(this);
			window.menuCollapsed = false;
		}
		else {
			packupMenu.apply(this);
			window.menuCollapsed = true;
		} */
	});
	$('#menu li.ui-nav-item .ui-nav-subitem')
	.mouseover(function(e){
		e.stopPropagation();
	});
	$('#menu li.ui-nav-item .ui-nav-submain')
	.mouseover(function(e){
		e.stopPropagation();
	});
	/* $('#menu div.ui-nav').click(function(){
		if(!window.menuCollapsed){
			var self = $(this);
			$subc.stop(true,false).slideUp(300,function(){
				if(window.$cunav)window.$cunav.slideUp(150);
			});
		}
	}); */
	
	(function activeMenu(index,subIndex){
		var $li = $('#menu li.ui-nav-item').eq(index);
		
		$li.addClass('ui-nav-item-current');
		
	})(index);
});
</script>