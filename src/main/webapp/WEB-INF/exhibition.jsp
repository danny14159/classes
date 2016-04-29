
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>-班级主页 -功能展示 </title>
<link href="/f/assets/css/jquery.fullPage.css"/>
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="/f/assets/js/jquery.fullPage.min.js"></script>
<script type="text/javascript" src="/f/assets/js/jquery.easing.min.js"></script>
<style type="text/css">
body{margin:0;padding: 0;color:#333;}
#menu { margin: 0; padding: 0; position: fixed; left: 10px; top: 10px; list-style-type: none; z-index: 70;}
#menu li { float: left; margin:  0 10px 0 0; font-size: 14px;}
#menu a { float: left; padding: 10px 20px; background-color: #fff; color: #333; text-decoration: none;border-radius:5px;}
#menu .li1 a{border:1px solid #1bbc9b;}#menu .active.li1 a,#menu .li1:hover a { color: #fff; background-color: #1bbc9b;}
#menu .li2 a{border:1px solid #4BBFC3;}#menu .active.li2 a,#menu .li2:hover a { color: #fff; background-color: #4BBFC3;}
#menu .li3 a{border:1px solid #7BAABE;}#menu .active.li3 a,#menu .li3:hover a { color: #fff; background-color: #7BAABE;}
#menu .li4 a{border:1px solid #f90;}#menu .active.li4 a,#menu .li4:hover a { color: #fff; background-color: #f90;}
#menu .li5 a{border:1px solid red;}#menu .active.li5 a,#menu .li5 a { color: #fff; background-color: red;}
.section { text-align: center; font: 50px "Microsoft Yahei"; color: #fff;}
.section img{width:600px;height:400px;border:5px solid #fff;border-radius:5px;position: relative;left:-200px;opacity:0;}
.section .desc{font-size: 25px;vertical-align: top;display: inline-block;width:40%;opacity:0 }
</style>
</head>
<body>
<ul id="menu">
	<li data-menuanchor="page1" class="active li1"><a href="#page1">单身派对-Hi翻到底</a></li>
	<li data-menuanchor="page2" class="li2"><a href="#page2">班级之间相互交流</a></li>
	<li data-menuanchor="page3" class="li3"><a href="#page3">班级记忆</a></li>
	<li data-menuanchor="page4" class="li4"><a href="#page4">轻松应对班级事务</a></li>
	<li class="li5"><a href="/">开始使用&nbsp;班·集</a></li>
</ul>

<div id="dowebok">
	<div class="section">
		<h3>单身派对-High翻到底</h3>
		
		<p><img src="/f/assets/img/exh/03.jpg"/>
		<span class="desc">
		没有勇气去表白？<br/>
对异性交往恐惧？<br/>
为世界看脸绝望？<br/>
还是…………<br/>
忘掉这些，加入我们，向单身狗Say no!<br/>
</span>
		</p>
	</div>
	<div class="section">
		<h3>班级之间相互交流</h3>
		<p><img src="/f/assets/img/exh/02.jpg"/><span class="desc">请查看左上角，点击可以控制</span></p>
	</div>
	<div class="section">
		<h3>班级记忆</h3>
		<p><img src="/f/assets/img/exh/01.jpg"/><span class="desc">
		毕业遥遥无期<br/>
		转眼各奔东西<br/>
		那些青春故事<br/>
		要是偶尔忘记<br/>
		就回班级记忆<br/>
		我们和你一起<br/></span></p>
	</div>
	<div class="section">
		<h3>轻松应对班级事务</h3>
		<p><img src="/f/assets/img/exh/04.jpg"/>
		<span class="desc">
作业安排，查询简单<br/>
班级活动，通知方便<br/>
班费使用，透明公开<br/>
集体生活，井井有条<br/>
一切尽在，事务管理<br/></span>
		<button>立即体验</button>
		</p>
	</div>
</div>

</body>
<script type="text/javascript">
$(function(){
	//初始化dom变量，加快动画速度
	var sections=$('#dowebok .section');
	sections.each(function(index){
		$(this).data({
			'img':$(this).find('img'),
			'desc':$(this).find('.desc')
		}); 
	});
	
	$('#dowebok').fullpage({
 		sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', '#f90','#fff'],
		anchors: ['page1', 'page2', 'page3', 'page4','page5'],
		menu: '#menu',
		'navigation': true,
		afterLoad:function(anchorLink,index){
			var section = sections.eq(index-1);
			section.data('img').css({top:'0px',left:'-200px'}).animate({left:'0px',opacity:1},500,'easeOutQuad',function(){
				section.data('desc').animate({opacity:1},300);
			});
		},
		onLeave:function( index,nextIndex , direction ){
			var section = sections.eq(index-1);
			section.data('img').animate({top:'100px',opacity:0},500,'easeOutQuad');
			section.data('desc').animate({opacity:0},300);
		},
		afterRender:function(){
			var section = sections.eq(0);
			section.data('img').css({top:'0px',left:'-200px'}).animate({left:'0px',opacity:1},500,'easeOutQuad',function(){
				section.data('desc').animate({opacity:1},300);
			});
		}
	});
});


</script>
</html>