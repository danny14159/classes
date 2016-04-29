<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>【个人中心】系统设置</title>
<link href="f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="1" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<jsp:include page="/include_lsidebar">
					<jsp:param value="5" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>系统设置</h2>
<form action="" method="post" id="fmclz">
	<input type="hidden" name="logo" id="hidlogo" value="${clz.logo }"/>
	
<div class="ui-form-item">
	<label for="" class="ui-label">编辑班级介绍： </label>
	<script id="editor" type="text/plain" style="width:500px;height:200px;" name="intro">${clz.intro }</script>
</div>
<div class="ui-form-item">
            <label for="" class="ui-label">班级logo： </label>
            <div id="uploader-demo">
    <!--用来存放item-->
    <div id="fileList" class="uploader-list"></div>
    <div id="filePicker">选择图片</div>
</div>
        </div>
<div class="ui-form-item">
            <label for="" class="ui-label">班级微博url：</label>
            <input class="ui-input laydate-icon" type="text" name="weibo" value="${clz.weibo }" style="width: 50%;" id="weibo">
            <span class="ui-form-other">前往<a href="${clz.weibo }" target="_blank">班级微博</a></span>
        </div>
	<input type="submit" value="完成" onclick="return onfinish();" class="ui-button ui-button-morange"/>
</form>
</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/include_footer" />

<script type="text/javascript" src="/f/assets/webuploader-0.1.5/webuploader.min.js"></script>

<script type="text/javascript" src="/f/assets/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="/f/assets/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/f/assets/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="/f/assets/js/sys_mgr.js"></script>
</body>
</html>