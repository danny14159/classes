<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班集-班级圈-发表事件</title>
<link href="/f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/circle.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="/f/assets/js/header.js"></script>
<style type="text/css">
#cc-form{padding-left: 20%;margin-top: 50px;min-height: 450px;}
#desc{height: inherit;}
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
						<a href="/circle/index">&lt;&lt;返回班级圈</a>
						<div class="tabContent">
							<div class="cc-header">
								<h1 class="cc-title">发表事件</h1>
								<hr class="cc-hr"/>
							</div>
							<form class="ui-form ui-form-large" name="" method="post" action="#" id="cc-form">
    <fieldset>
        <legend>表单标题</legend>

        <div class="ui-form-item">
            <label for="" class="ui-label">
                <span class="ui-form-required">*</span>事件标题
            </label>
            <input class="ui-input" type="text" name="title" id="title">
        </div>

        <div class="ui-form-item">
            <label for="" class="ui-label">事件描述</label>
            <textarea class="ui-input" cols="60" rows="4" id="desc" name="desc"></textarea>
            <p class="ui-form-explain">可选描述</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">上传图片</label>
            <div id="uploader-demo">
		   	<div id="fileList" class="uploader-list"></div>
		    <div id="filePicker">选择图片</div>
			</div>
			<input type="hidden" value="" name="pics" id="pics"/>
        </div>

        <div class="ui-form-item">
			<input type="hidden" value="" name="autho"/>
            <input class="ui-checkbox" value="" type="checkbox" id="bpublic" checked="checked">
            <label class="ui-checkbox-label" for="bpublic">是否在广场中公开</label>
            <span class="ui-form-explain">勾选此项则该事件可以被其他班的人浏览和评论</span>
        </div>
        <div class="ui-form-item">
            <label class="ui-checkbox-label" for="test2"></label>
			<input type="radio" value="I" name="type" checked="checked"/>个人事件
			<input type="radio" value="G" name="type"/>集体事件
        </div>

        <div class="ui-form-item">
            <input type="submit" class="ui-button ui-button-lorange" value="发表" onclick="onenter();return false;">
        </div>

    </fieldset>
</form>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/webuploader-0.1.5/webuploader.min.js"></script>
<script type="text/javascript">
//initial params
var $list=$("#fileList"),
	thumbnailWidth = 120,
	thumbnailHeight = 120;
function onenter() {
	var param = $('#cc-form').serializeObject();
	if(!param.title){alert("给事件起一个标题吧！");return;}
	if(!param.type){alert("请选择事件类型！");return;}
	//首先上传片
	uploader.upload();
}
function sendpublish(){
	var param = $('#cc-form').serializeObject();
	param.autho = $('#bpublic').is(':checked')?'G':'P';
	$.get('/evt/ins',param, function(data) {
		if (data) {
			alert('发表成功。',function(){
				location.href="/circle/index";
			});
		} else
			alert('服务器繁忙，请稍后重试！');
	}, 'json');
}
	
$(function(){
	

uploader = WebUploader.create({

    // swf文件路径
    swf:'/f/assets/webuploader-0.1.5/Uploader.swf',

    // 文件接收服务端。
    server: '/upd/evtpics',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker',

    // 只允许选择图片文件。
    accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    },
	fileVal:'pics',
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
});

// 文件上传过程中创建进度条实时显示。
uploader.on( 'uploadProgress', function( file, percentage ) {
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
    $( '#'+file.id ).addClass('upload-state-done');
    var pics = $("#pics").val();
    $("#pics").val(pics+(pics?';':'')+response.msg);
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
    sendpublish();
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
</script>
</body>
</html>