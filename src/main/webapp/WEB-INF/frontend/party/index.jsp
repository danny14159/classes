<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级主页——单身派对</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
	<link rel="stylesheet" href="/f/assets/css/header.css" />
	<link rel="stylesheet" href="/f/assets/css/party.css" />
	<link rel="stylesheet" href="/f/assets/laypage/skin/laypage.css" />
	<style type="text/css">
	.screen{height:20px;padding: 0 12px;font-size: 12px;line-height: 20px;margin-top: 6px;}
#paging{bottom: 0;right:15px;}	
</style>
	<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="/include_header"/>
	<jsp:include page="/include_content">
		<jsp:param name="i" value="3" />
	</jsp:include>
	
	<div class="" id="row1">

<div class="tabmain wrapper">
  <div class="outerWrap">
  	
  	<jsp:include page="/include_partylsidebar"/>
  	
    <div class="container">
		<div class="content">
		 <div class="tabContent">
		 <h2 class="header"><span class="tabHeader"></span>单身派对</h2>
		 <div class="selectNumberScreen">
	<div id="selectList" class="screenBox screenBackground">
		<dl class="listIndex" attr="sex">
		  <dt>性别：</dt>
		  <dd>
		  <a href="javascript:;" values2="" values1="" attrval="M">男</a> 
		  <a href="javascript:;" values2="" values1="" attrval="W">女</a> 
		  <span class=more><label>筛选条件</label><em class=open></em></span> </dd>
		</dl>
		<dl class="listIndex" attr="collegeId">
		  <dt>所在学院：</dt>
		  <dd>
		  <a href="javascript:;" values2="499" values1="1" attrval="1">计算机学院</a> 
		  <a href="javascript:;" values2="499" values1="1" attrval="2">电气学院</a> 
		  <a href="javascript:;" values2="499" values1="1" attrval="3">化工学院</a> 
		  <a href="javascript:;" values2="499" values1="1" attrval="4">艺术学院</a> 
		  <a href="javascript:;" values2="499" values1="1" attrval="7">文法学院</a> </dd>
		</dl>
		<dl class=" listIndex" attr="fromProvince">
		  <dt>家乡所在省：</dt>
		  <dd>
		  <a href="javascript:;" attrval="北京市">北京</a>
		  <a href="javascript:;" attrval="天津市">天津</a>
		  <a href="javascript:;" attrval="上海市">上海</a>
		  <a href="javascript:;" attrval="重庆市">重庆</a>
		  <a href="javascript:;" attrval="河北省">河北</a>
		  <a href="javascript:;" attrval="山西省">山西</a>
		  <a href="javascript:;" attrval="内蒙古">内蒙古</a>
		  <a href="javascript:;" attrval="辽宁省">辽宁</a>
		  <a href="javascript:;" attrval="吉林省">吉林</a>
		  <a href="javascript:;" attrval="黑龙江省">黑龙江</a>
		  <a href="javascript:;" attrval="江苏省">江苏</a>
		  <a href="javascript:;" attrval="浙江省">浙江</a>
		  <a href="javascript:;" attrval="安徽省">安徽</a> 
		  <a href="javascript:;" attrval="福建省">福建</a> 
		  <a href="javascript:;" attrval="江西省">江西</a> 
		  <a href="javascript:;" attrval="山东省">山东</a> 
		  <a href="javascript:;" attrval="湖南省">湖南</a> 
		  <a href="javascript:;" attrval="广东省">广东</a> 
		  <a href="javascript:;" attrval="广西">广西</a> 
		  <a href="javascript:;" attrval="海南省">海南</a> 
		  <a href="javascript:;" attrval="四川省">四川</a> 
		  <a href="javascript:;" attrval="贵州省">贵州</a> 
		  <a href="javascript:;" attrval="云南省">云南</a> 
		  <a href="javascript:;" attrval="西藏">西藏</a> 
		  <a href="javascript:;" attrval="陕西省">陕西</a> 
		  <a href="javascript:;" attrval="甘肃省">甘肃</a> 
		  <a href="javascript:;" attrval="青海省">青海</a> 
		  <a href="javascript:;" attrval="宁夏省">宁夏</a> 
		  <a href="javascript:;" attrval="香港">香港</a> 
		  <a href="javascript:;" attrval="澳门">澳门</a> 
		  <a href="javascript:;" attrval="台湾省">台湾</a> 
		  <span class="more"><label onclick="$(this).closest('dd').animate({'height':'80px'})">更多</label><em class=open></em></span> 
		  </dd>
		</dl>
		<dl class=" listIndex" attr="fromCity">
		  <dt>家乡所在市：</dt>
		  <dd>
		  <a href="javascript:;" values2="" values1="" attrval="镇江">镇江</a>
		  <a href="javascript:;" values2="" values1="" attrval="">其他</a> 
		  </dd>
		</dl>
		<dl class="noBorder listIndex" attr="age">
		  <dt>年龄：</dt>
		  <dd><a href="javascript:;" values2="" values1="" attrval="18-19">18-19</a>
		  <a href="javascript:;" values2="" values1="" attrval="20-21">20-21</a>
		  <a href="javascript:;" values2="" values1="" attrval="22-23">22-23 </a>
		  <a href="javascript:;" values2="" values1="" attrval="24-25">24-25 </a>
		  </dd>
		</dl>
	</div>
	<div class="hasBeenSelected">
		<dl>
		  <dt>您已选择：</dt>
		  <dd style="DISPLAY: none" class=clearDd>
		  <div class=clearList></div>
		  <div style="DISPLAY: none" class="eliminateCriteria">清除</div>
		  <button class="ui-button ui-button-sorange screen" onclick="loadParty(true);">开始筛选</button>
		</dd></dl>
	</div>
</div>
		 
		 <div id="paging"></div>
		 <div id="party"  class="party"></div>
		 	 </div>
	</div>
</div>
	</div>
</div>
</div>
<jsp:include page="/include_footer"/>
	<script type="text/javascript" src="/f/assets/js/laytpl.js"></script>
	<script type="text/javascript" src="/f/assets/js/jquery.jqfader.js"></script> 
	<script type="text/javascript" src="/f/assets/laypage/laypage.js"></script>
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
{{# if(d.length==0){ }}
暂未查询到符合条件的人╮(╯▽╰)╭试试其它查询条件吧~
{{# } }}
</script>
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript">
pagesize = 50;
criteria ={ps:pagesize,pn:1};

function loadParty(refresh) {
	var load = layer.load("获取中……");
	$.ajax({
		beforeSend : function() {
		},
		data : criteria,
		dataType : 'json',
		type : 'POST',
		url : '/party/show'
	}).done(function(data) {
		layer.close(load);
		if(data.ok === false && data.msg=="未加入派对。"){
			$('#party').html('您还未加入派对，请先<button class="ui-button ui-button-mblue" onclick="enterparty();">加入派对</button>');
			return;
		}
		laytpl($('#tplparty').html()).render(data, function(html) {
			$('#party').html(html);
		});
		if (refresh)
			$('#party .fader').hide().jqfader({
				callback : function() {
				}
			});
	}).fail(function() {
		alert('加载失败，请刷新页面重试');
	});
}
function interact(a, addclass, type, no, clzId) {
	$.get('/partyi/' + type, {
		toNo : no,
		toClz : clzId,
		cancel : false
	}, 'json').done(function(data) {
		if (data && data.ok) {
			// $(a).removeClass('text-weak').addClass(addclass);
			loadParty();
		} else if (data && data.msg)
			alert(data.msg);
		else
			alert('error');
	});
}
$(function(){
	//loadParty(true);
	$.post('/party/count',criteria,
	function(data){
	  laypage({
	        cont: $('#paging'), 
	        pages: (data/pagesize+1)||2, //总页数
	        curr: 1, //当前页
	        jump: function(e){ //触发分页后的回调
	            //var view = document.getElementById('view1'); //你也可以直接使用jquery
	            //view.innerHTML = '假设这是分页内容，目前正出于第：'+ e.curr +'页。jump函数返回的参数e是一个object，e.curr即当前页，通过它去向服务端请求相关数据。'
	            criteria.ps=pagesize;
	            criteria.pn=e.curr;
	            loadParty(true);
	        },
	        skin:'#AF0000'
	    }); 
	},'json');
	
	
	var dlNum  =$("#selectList").find("dl");
	for (i = 0; i < dlNum.length; i++) {
	    $(".hasBeenSelected .clearList").append("<div class=\"selectedInfor selectedShow\" style=\"display:none\"><span></span><label></label><em></em></div>");
	}
	
	var refresh = "true";
	
	
	//单击条件
	$(".listIndex a ").on("click",function(){
	    var text =$(this).text();
	    var selectedShow = $(".selectedShow");
	    var textTypeIndex =$(this).parents("dl").index();
	    var textType =$(this).parent("dd").siblings("dt").text();
	    index = textTypeIndex ;
	    $(".clearDd").show();
	    $(".selectedShow").eq(index).show();
	    $(this).addClass("selected").siblings().removeClass("selected");
	    selectedShow.eq(index).find("span").text(textType);
	    selectedShow.eq(index).find("label").text(text);
	    var show = $(".selectedShow").length - $(".selectedShow:hidden").length;
	    if (show > 1) {
	        $(".eliminateCriteria").show();
	    }
	    var attr = $(this).closest('dl').attr('attr');
	    var val = $(this).attr('attrval');
	    criteria[attr] = val;
	    if(attr == "age"){
	    	criteria ['fromAge'] = val.split('-')[0];
	    	criteria ['toAge'] = val.split('-')[1];
	    }
	});
	//取消某个条件
	$(".selectedShow em").on("click",function(){
	    $(this).parents(".selectedShow").hide();
	    var textTypeIndex =$(this).parents(".selectedShow").index();
	    index = textTypeIndex;
	    var linkcri = $(".listIndex").eq(index).find("a").removeClass("selected");
	    var attr = linkcri.closest('dl').attr('attr');
	    delete criteria[attr];
	    if(attr=="age") {
	    	delete criteria['fromAge'];
	    	delete criteria['toAge'];
	    }
	    
	    if($(".listIndex .selected").length < 2){
	        $(".eliminateCriteria").hide();
	    }
	});
	
	//清除筛选条件
	$(".eliminateCriteria").on("click",function(){
	    $(".selectedShow").hide();
	    $(this).hide();
	    $(".listIndex a ").removeClass("selected");
	    criteria = {};
	    
	   
	}); 
});


</script>
</body>
</html>