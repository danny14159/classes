<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级主页——加入派对</title>
<link href="/f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
	<link rel="stylesheet" href="/f/assets/css/header.css" />
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
  	
  	<jsp:include page="/include_partylsidebar">
  		<jsp:param value="1" name="index"/>
  	</jsp:include>
  	
    <div class="container">
		<div class="content">
		 <div class="tabContent">
		 <h2 class="header"><span class="tabHeader"></span>加入派对</h2>
		 <form class="ui-form text text-dark" name="" method="post" action="#" id="">
		  <fieldset>
        <legend>表单标题</legend>

        <div class="ui-form-item ui-form-item-error">
            <label for="" class="ui-label text text-warning">基本信息：</label>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">姓名：</label>
            <p class="ui-form-text">${me.name }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">来自：</label>
            <p class="ui-form-text">${me.fromProvince }&nbsp;${me.fromCity }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">出生日期：</label>
            <p class="ui-form-text">${me.birth }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">所在班级：</label>
            <p class="ui-form-text">${clz.name }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">兴趣爱好：</label>
            <p class="ui-form-text"><c:out value="${me.hobbies }"></c:out></p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">自我介绍：</label>
            <p class="ui-form-text">${me.signature }</p>
        </div>
        <span class="text text-weak">（去<a href="/icenter_individual_info_basic">个人中心</a>完善信息，让大家更了解你吧！）</span>
        <hr style="margin: 15px 0"/>
        <div class="ui-form-item">
            <label for="" class="ui-label text text-warning">期望的TA：</label>
            <textarea rows="4" cols="75" class="ui-textarea" id="expect"></textarea>
            <p class="ui-form-explain">仔细填写有助你找到你的另一半</p>
        </div>
        <hr style="margin: 15px 0"/>
        <div class="ui-form-item">
            <label for="" class="ui-label text text-warning">更多图片：</label>
            <div id="uploader-demo">
		   	<div id="fileList" class="uploader-list"></div>
		    <div id="filePicker">选择图片</div>
		    <p class="ui-form-explain">用图片展示自己独一无二的一面</p>
			</div>
        </div>
        
        
        
        <div class="ui-form-item">
            <label for="">
                <input class="ui-checkbox" id="test" value="" type="checkbox">
                我已阅读并接受<a href="#">派对注意事项</a>
            </label>
        </div>
        <div class="ui-form-item">
            <input type="button" class="ui-button ui-button-mblue" value="确定加入" onclick="onenter();return false;">
        </div>
         </fieldset>
</form>


		 	 </div>
	</div>
</div>
	</div>
</div>
</div>
<jsp:include page="/include_footer"/>
<script type="text/javascript" src="/f/assets/webuploader-0.1.5/webuploader.min.js"></script>
<script type="text/javascript">
//initial params
var $list=$("#fileList"),
	thumbnailWidth = 120,
	thumbnailHeight = 120;
function onenter() {
	var expect = $('#expect').val();
	if(!expect){alert("在期望的TA一栏里填写什么再加入吧！");return;}
	//首先上传图片
	uploader.upload();
}
function sendenter(){
	var expect = $('#expect').val();
$.get('/party/enter',{expect:expect}, function(data) {
	if (data && data.ok) {
		alert('加入成功。');location.href="/iparty/index";
	} else if (data.msg)
		alert(data.msg);
}, 'json');
}
	
$(function(){
	

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
	console.log(arguments);
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
    alert('文件上传完成');
    sendenter();
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