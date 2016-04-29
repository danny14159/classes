<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>作业管理</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<link href="/f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<style type="text/css">
.file-item{display: inline-block;margin: 5px 7px;}
</style>
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="2" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<jsp:include page="/include_publiclsidebar">
					<jsp:param value="2" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>新作业</h2>
							<h3>新作业</h3>
							<form class="ui-form" method="post" id="fmnhw">
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>科目
						            </label>
						            <input class="ui-input" type="text" name="subject" value="${hw.subject }" id="subject"> 
						            <input type="hidden" name="id" value="${hw.id }"> 
						            
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>交作业时间
						            </label>
						            <input id="expire" value="${hw.expire }" class="ui-input laydate-icon" type="text" name="expire" onclick="laydate()"><span class="ui-form-other"></span>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>作业内容
						            </label>
						            <textarea rows="5" cols="100" class="ui-input" name="content" id="fmcontent">${hw.content }</textarea>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">补充说明
						            </label>
						            <textarea rows="5" cols="100" class="ui-input" name="expireAdd">${hw.expireAdd }</textarea>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">图片附件
						            </label>
						            <div id="filePicker">选择图片</div>
						            <h2>预览：</h2>
						            <div id="fileList" class="uploader-list"></div>
						            <input type="hidden" name="pics" id="hidpics" value="${hw.pics }"/>
						        	<p class="ui-form-explain">图片附件暂不支持删除</p>
						        </div>
						        </form>
								<div class="ui-form-item">
									<input type="button" class="ui-button ui-button-morange" value="提交" onclick="addhw();return false;">
						        </div>
						    
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
	<script type="text/javascript" src="/f/assets/laydate/laydate.js"></script>
<script type="text/javascript" src="/f/assets/webuploader-0.1.5/webuploader.min.js"></script>

	
<script type="text/javascript">
function postadd(){
	$.post("/homework/ins?",$("#fmnhw").serializeObject(),'json').
	done(function(data){
		if(data && data.ok){
			alert('提交成功');location.href="/publics/homework";
		}
		else{
			alert(data.msg || '系统繁忙，请稍后重试！');
		}
	})
	.fail(function(){
		alert('添加失败，请确认是否有权限添加。')
	});
}
function postupdate(){
	$.post("/homework/upd?",$("#fmnhw").serializeObject(),function(data){
		if(data){
			alert('修改成功');location.href="/publics/homework";
		}
		else{
			alert('系统繁忙，请稍后重试！');
		}
	},'json'); 
}
fupdate = '${hw.subject}'?true:false;
function addhw(){
	if(!$('#subject').val()) {alert("请填写科目！");return;}
	if(!$('#expire').val()) {alert("请填写交作业时间！");return;}
	if(!$('#fmcontent').val()) {alert("请填写作业内容！");return;}
	if(window.fupdate){
		postupdate();
	}
	else{
		if(window.hasfile)
			uploader.upload();
		else postadd();
	}
	return false;
}
$(function(){
	//是否修改
	
	//date控件皮肤初始化
	laydate.skin('molv');
	
	//initial params
	var $list=$("#fileList"),
		thumbnailWidth = 112,
		thumbnailHeight = 112;
	
	uploader = WebUploader.create({

	    // swf文件路径
	    swf:'/f/assets/webuploader-0.1.5/Uploader.swf',

	    // 文件接收服务端。
	    server: '/upd/hwpics',

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
		fileNumLimit : 10,
		fileSizeLimit : 400*1024 /*200KB*/,
		/*auto:true*/ /*选中即自动上传*/
	});
	
	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file ) {
		//TODO 先把当前文件队列和预览队列清空
		
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
	    
	    $('#fmain').show();
	    hasfile=true;
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
	    var hidpics = $("#hidpics").val();
	    $("#hidpics").val(hidpics+(hidpics?';':'')+response.msg);
	    
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
	uploader.on( 'uploadFinished', function( file ) {
		postadd();
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