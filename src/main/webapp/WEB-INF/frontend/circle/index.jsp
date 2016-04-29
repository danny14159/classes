<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班集-班级圈</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/circle.css" />
<link rel="stylesheet" href="/f/assets/waterfall/index.css" />
<!--[if lt IE 9]>
		<script src="/f/assets/waterfall/css3-mediaqueries.js"></script>
	<![endif]-->
<script type="text/html" id="tplevt">
{{each list as val i}}
			<li class="item">
					<a href="/circle/evtdetail?param={{val.id}}" class="a-img">
					<h2 class="li-title" title=""><span class="quotation">“</span>{{val.title}}<span class="quotation down">”</span></h2>
					{{if val.pics!=""}}
						<p class="description">{{val.desc}}</p>
						<img src="{{val.pics}}" alt="">
					{{else}}
						<p class="description no-pics">{{val.desc}}</p>
					{{/if}}
					<div class="qianm clearfloat">
						<span class="sp1"><b>{{val.npraise}}</b>赞</span>
						<span class="sp1"><b>{{val.ncomment}}</b>评论</span>
						<span class="sp2">{{val.act_time | FormatDate:'yyyy年MM月dd日'}}</span>
						<span class="sp3">{{val.type | FormatType}}</span>
					</div>
					</a>
				</li>
{{/each}}
</script>
<script type="text/javascript" src="/f/assets/js/art-template.js"></script>
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="/f/assets/js/header.js"></script>
<script type="text/javascript" src="/f/assets/waterfall/jQueryColor.js"></script>
<script type="text/javascript" src="/f/assets/waterfall/jquery.masonry.min.js"></script>
<script type="text/javascript">
pager={ps:6,pn:1};

		$(function(){
				/*瀑布流开始*/
				var container = $('.waterfull ul');
				var loading=$('#imloading');
				// 初始化loading状态
				loading.data("on",true);
				/*判断瀑布流最大布局宽度，最大为1280*/
				function tores(){
					var tmpWid=$(window).width();
					if(tmpWid>1133){
						tmpWid=1133;
					}else{
						var column=Math.floor(tmpWid/320);
						tmpWid=column*320;
					}
					$('.waterfull').width(tmpWid);
				}
				tores();
				/* $(window).resize(function(){
					tores();
				}); */
				
				template.helper('FormatDate',FormatDate);
				template.helper('FormatType',function(data){
					return data=='G'?'集体':'个人';
				});
				function loadJson(autho){
					//加载更多数据
					loading.data("on",false).fadeIn(800);
					$.get('/evt/lstp?autho='+(autho||'G'),window.pager,'json')
					.done(function(sqlJson){
						if(!sqlJson) {
							alert('数据加载失败，请刷新重试！');return;
						}
						//处理sqlJson
						for(var i in sqlJson.list){
							sqlJson.list[i].pics = sqlJson.list[i].pics ? sqlJson.list[i].pics.split(';')[0]+'thumb284-250' : "";
						}
						
						window.pager.pn++;
						(function(sqlJson){
							if(window.itemNum>=sqlJson.pager.recordCount){
								loading.text('就有这么多了！');
							}else{
								var html=template('tplevt', sqlJson);
								//alert(html)
								/*模拟ajax请求数据时延时800毫秒*/
								//var time=setTimeout(function(){
									$(html).find('img').each(function(index){
										loadImage($(this).attr('src'));
									})
									var $newElems = $(html).css({ opacity: 0}).appendTo(container);
									$newElems.imagesLoaded(function(){
										$newElems.animate({ opacity: 1},800);
										container.masonry( 'appended', $newElems,true);
										loading.data("on",true).fadeOut();
										//clearTimeout(time);
							        });
								//},800)
							}
						})(sqlJson);
					});
				}
				function switchAutho(autho,btn){
					window.autho = autho||'G';
					window.pager.pn=1;
					window.itemNum=0;
					$('#waterfull ul').empty();
					container.masonry('destroy');
					container.imagesLoaded(function(){
						  container.masonry({
						  	columnWidth: 320,
						    itemSelector : '.item',
						    isFitWidth: true,//是否根据浏览器窗口大小自动适应默认false
						    isAnimated: true,//是否采用jquery动画进行重拍版
						    isRTL:false,//设置布局的排列方式，即：定位砖块时，是从左向右排列还是从右向左排列。默认值为false，即从左向右
						    isResizable: true,//是否自动布局默认true
						     animationOptions: {
								duration: 300,
								//easing: 'easeInOutBack',//如果你引用了jQeasing这里就可以添加对应的动态动画效果，如果没引用删除这行，默认是匀速变化
								queue: false//是否队列，从一点填充瀑布流
							} 
						  });
						});
					if(btn)$(btn).addClass('current').siblings('.fallfilter').removeClass('current');
					loadJson(window.autho);
				}
				window.switchAutho = switchAutho;
				/*模拟从后台获取到的数据*/
						/*本应该通过ajax从后台请求过来类似sqljson的数据然后，便利，进行填充，这里我们用sqlJson来模拟一下数据*/
						$(window).scroll(function(){
							if(!loading.data("on")) return;
							// 计算所有瀑布流块中距离顶部最大，进而在滚动条滚动时，来进行ajax请求，方法很多这里只列举最简单一种，最易理解一种
							window.itemNum=$('#waterfull').find('.item').length;
							var itemArr=[];
							itemArr[0]=$('#waterfull').find('.item').eq(itemNum-1).offset().top+$('#waterfull').find('.item').eq(itemNum-1)[0].offsetHeight;
							itemArr[1]=$('#waterfull').find('.item').eq(itemNum-2).offset().top+$('#waterfull').find('.item').eq(itemNum-1)[0].offsetHeight;
							itemArr[2]=$('#waterfull').find('.item').eq(itemNum-3).offset().top+$('#waterfull').find('.item').eq(itemNum-1)[0].offsetHeight;
							var maxTop=Math.max.apply(null,itemArr);
							if(maxTop<$(window).height()+$(document).scrollTop()){
								loadJson(window.autho||'G');
							}
						});
				switchAutho('G');
				function loadImage(url) {
				     var img = new Image(); 
				     //创建一个Image对象，实现图片的预下载
				      img.src = url;
				      if (img.complete) {
				         return img.src;
				      }
				      img.onload = function () {
				       	return img.src;
				      };
				 };
				 //loadImage('./images/one.jpeg');
				/*item hover效果*/
			/* 	var rbgB=['#71D3F5','#F0C179','#F28386','#8BD38B'];
				$('#waterfull').on('mouseover','.item',function(){
					var random=Math.floor(Math.random() * 4);
					$(this).stop(true,true).animate({'backgroundColor':rbgB[random]},150);
					$(this).find('.qianm span').stop(true).animate({'color':'#fff'},150);
				});
				$('#waterfull').on('mouseout','.item',function(){
					$(this).stop(true,true).animate({'backgroundColor':'#fff'},150);
					$(this).find('.qianm span').stop(true).animate({'color':'#898686'},150);
				}); */
		})
    </script>

<style type="text/css">
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
							<div class="fallheader">
								<a class="fallnew ui-button ui-button-lorange" href="/circle/publish">发表新鲜事</a>
								<div class="fallfilter current" onclick="switchAutho('G',this)">广场</div>
								<div class="fallfilter" onclick="switchAutho('P',this)">本班</div>
							</div>
							<div class="fallcontent">
		<!-- 瀑布流样式开始 -->
		<div class="waterfull clearfloat" id="waterfull">
			<ul>
			</ul>
		</div>
		<!-- loading按钮自己通过样式调整 -->
		<div id="imloading" style="width:150px;height:30px;line-height:30px;font-size:16px;text-align:center;border-radius:3px;opacity:0.7;background:#000;margin:10px auto 30px;color:#fff;display:none">
		加载中.....
		</div>
							
							</div>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
</body>
</html>