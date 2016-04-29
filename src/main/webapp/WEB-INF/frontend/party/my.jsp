<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派对中心——我的派对</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css"/>
<link rel="stylesheet" href="/f/assets/css/party.css"/>
<link href="/f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<style type="text/css">
.stupics{width:110px;height:110px;display: inline-block;margin-top: 15px;margin-right: 5px;position: relative;}
</style>
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="3" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<jsp:include page="/include_partylsidebar"><jsp:param value="3" name="index"/></jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>单身派对--我的派对</h2>
							<div class="ui-form">
						
						        <div class="ui-form-item">
						            <label for="" class="ui-label">姓名：</label>
						            <p class="ui-form-text">${myparty.name }</p>
						            <p><a href="/iparty/show${myparty.no }-${myparty.clzId }" target="_blank">查看我的详情页</a></p>
						        </div>
						        <div class="ui-form-item">
						            <label for="" class="ui-label">期望的TA：</label>
						            <p class="ui-form-text" id="myexpect"><!--  
						            --><c:out value="${myexp.expect }"></c:out><!-- 
						             --></p>
						            <a href="javascript:;" onclick="onModExpect();" id="btnMod">修改</a>
						            <a class="text text-warning" href="javascript:;" onclick="onCancelExpect();" id="btnCancel" style="display: none;">取消</a>
						        </div>
						        <div class="ui-form-item">
						            <label for="" class="ui-label">更多照片：</label>
						            <div id="uploader-demo">
									   	<div id="fileList" class="uploader-list"></div>
									    <div id="filePicker">添加图片</div>
									    <button onclick="uploader.upload();" class="ui-button ui-button-mwhite" id="btnupd" style="display: none;">开始上传</button>
									    <p class="ui-form-explain">用图片展示自己独一无二的一面</p>
									</div>
						            <p class="ui-form-text">
						            <c:forEach var="pho" items="${mypho }" varStatus="status">
								<!-- --><div class="stupics bordered-img">
									<a href="${pho.picPath }" target="_blank"> <img
										src="${pho.picPath }thumb110-110" alt="avatar"
										onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';"
										onload="FillImage(this,110,110);" />
									</a>
									<a href="javascript:;" class="btnshade" onclick="ondelpic(${pho.id });">删除</a>
								</div><!-- -->
								</c:forEach>
						            </p>
						        </div>
							</div>
							
							<h3>对我心动的</h3>
							<div id="loveme" class="party"></div>
							<h3>我心动的</h3>
							<div id="ilove" class="party"></div>
							<h3>赞我的</h3>
							<div id="praiseme" class="party"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript" src="/f/assets/js/laytpl.js"></script>
<script type="text/javascript" src="/f/assets/webuploader-0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="/f/assets/js/jquery.jqfader.js"></script> 
<script type="text/html" id="tplparty">
{{# for(var i = 0, len = d.length; i < len; i++){ }}
<div class="item fader"><a href="/iparty/show{{ d[i].no }}-{{ d[i].clzId }}" class="imglink"><img src="{{ d[i].avatar }}thumb102-102" onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';" onload="FillImage(this,102,102)"/></a>
				<div class="abstract">
					<p class="name"><a href="/iparty/show{{ d[i].no }}-{{ d[i].clzId }}" class="text text-dark">{{ d[i].name }}</a></p>
					<p class="from"><a href="javascript:;" title="{{ d[i].univName }}{{ d[i].collegeName }}{{ d[i].profName }}{{ d[i].clzName }}" class="btn text text-plain">
					来自{{ d[i].univName }}{{ d[i].clzName }}</a></p>
</div>
</div>
{{# } }}
{{# if(d.length==0){ }}
暂时还没有╮(╯▽╰)╭返回<a href="/iparty/index">派对中心</a>看看吧~
{{# } }}
</script>
<script type="text/javascript">
function loadstus(refresh,url,render) {
	$.ajax({
		beforeSend : function() {
		},
		data : window.criteria||{},
		dataType : 'json',
		type : 'POST',
		url : url
	}).done(function(data) {
		if(data && !data.ok && data.msg) alert(data.msg);
		else {
			laytpl($('#tplparty').html()).render(data, function(html) {
				$(render).html(html);
			});
			if (refresh)
				$(render+' .fader').hide().jqfader({
					callback : function() {
					}
				});
		}
	}).fail(function() {
		alert('加载失败，请刷新页面重试');
	});
}
$(function(){
	loadstus(true,'/partyi/who_1','#loveme');
	loadstus(true,'/partyi/i_love','#ilove');
	loadstus(true,'/partyi/who_2','#praiseme');
	
	//初始化图片的删除按钮
	$('.stupics').mouseover(function(){
		$(this).find('.btnshade').stop(true,false).animate({bottom:0},100);
	})
	.mouseout(function(){
		$(this).find('.btnshade').stop(true,false).animate({bottom:'-18px'},50);
	});
	
	var $list=$("#fileList"),
	thumbnailWidth = 120,
	thumbnailHeight = 120;
	
	uploader = WebUploader.create({

	    // swf文件路径
	    swf:'/f/assets/webuploader-0.1.5/Uploader.swf',

	    // 文件接收服务端。
	    server: '/upd/stupics',

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#filePicker',

	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/*'
	    },
		fileVal:'stupics',
		fileSizeLimit : 500*1024
	});

	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file ) {
	    var $li = $(
	            '<div id="' + file.id + '" class="file-item thumbnail">' +
	                '<img>' +
	                '<div class="picFileInfo">' + file.name + '</div>' +
	            '</div>'
	            ),
	        $img = $li.find('img');


	    // $list为容器jQuery实例
	    $list.append( $li );

	    // 创建缩略图
	    // 如果为非图片文件，可以不用调用此方法。
	    // thumbnailWidth x thumbnailHeight 为 100 x 100
	    uploader.makeThumb( file, function( error, src ) {
	        if ( error ) {
	            $img.replaceWith('<span>不能预览</span>');
	            return;
	        }

	        $img.attr( 'src', src );
	    }, thumbnailWidth, thumbnailHeight );
	    
	    $('#btnupd').show()
	});

	// 文件上传过程中创建进度条实时显示。
	uploader.on( 'uploadProgress', function( file, percentage ) {
		console.log(file.id+':'+percentage);
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress span');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<p class="progress"><span></span></p>')
	                .appendTo( $li )
	                .find('span');
	    }

	    $percent.css( 'width', percentage * 100 + '%' );
	});

	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadSuccess', function( file ,response) {
		if(!response.ok){
			alert(response.msg);return;
		}
		$("#hidlogo").val(response.msg);
	    $( '#'+file.id ).addClass('upload-state-done');
	});

	// 文件上传失败，显示上传出错。
	uploader.on( 'uploadError', function( file ) {
	    var $li = $( '#'+file.id ),
	        $error = $li.find('div.error');

	    // 避免重复创建
	    if ( !$error.length ) {
	        $error = $('<div class="error"></div>').appendTo( $li );
	    }

	    $error.text('上传失败');
	});

	// 完成上传完了，成功或者失败，先删除进度条。
	uploader.on( 'uploadComplete', function( file ) {
	    $( '#'+file.id ).find('.progress').remove();
	});
	uploader.on( 'uploadFinished',function(){
	    alert('文件上传完成');location.reload();
	});

	uploader.on('error',function(reason,limit,file){
		var prompt={
				'Q_EXCEED_NUM_LIMIT':'上传图片数量应不超过'+limit+'幅',
				'Q_EXCEED_SIZE_LIMIT':'上传图片大小应不超过'+limit/1024+'KB',
				'Q_TYPE_DENIED':'文件类型选择不正确！'
		};
		alert(prompt[reason]);
	});
});
function onModExpect(){
	var expect = $('#myexpect').text();
	
	$('#myexpect').html($('<textarea rows="4" cols="75" class="ui-textarea" id="fmexpect">').text(expect))
	.data('data',expect);
	$('#btnCancel').show();
	$('#btnMod').get(0).onclick=postModExpect;
}
function postModExpect(){
	var expect = $('#fmexpect').val();
	$.post('/party/upd',{expect:expect},'json')
	.done(function(data){
		if(data) {location.reload();}
		else {alert('修改失败，请稍后重试！');}
	});
}
function onCancelExpect(a){
	$('#myexpect').text($('#myexpect').data('data'));
	$('#btnCancel').hide();
	$('#btnMod').get(0).onclick=onModExpect;
}
function ondelpic(id){
	if(confirm('确认删除这幅图片，删除后将不可恢复？'))
	$.get('/stupics/del/'+id,'json')
	.done(function(data){
		if(data) location.reload();
		else alert('系统繁忙，请稍后重试！');
	});
}
</script>
</body>
</html>