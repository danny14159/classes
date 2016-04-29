<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>【个人中心】个人资料管理——头像修改</title>
<link href="/f/assets/webuploader-0.1.5/webuploader.css" rel="stylesheet"/>
<link rel="stylesheet" href="${initParam.staticCtx }/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
	<link rel="stylesheet" href="/f/assets/css/header.css" />
	<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="/include_header"/>
	<jsp:include page="/include_content">
		<jsp:param name="i" value="1" />
	</jsp:include>
	
	<div class="" id="row1">

<div class="tabmain wrapper">
  <div class="outerWrap">
  	
  	<jsp:include page="/include_lsidebar"/>
  	
    <div class="container">
		<div class="content">
		 <div class="tabContent">
		 	<h2 class="header"><span class="tabHeader"></span>个人资料——设置头像</h2>
		 	<div id="filePicker">选择图片</div>
			<div class="attention">
					<ul>
                        	<li>请上传您的个人头像</li>
                        	<li>请勿在形象标示上留有任何联系方式的信息</li>
                        	<li>支持JPG格式，图片大小不超过5MB</li>
                        	<li>请保证图片质量，分辨率至少为180*180</li>
                        	<li>请不要在头像上面留电话，QQ，网址，邮箱等联系方式信息，会导致您的头像无法通过审核</li>
                        </ul>
			
			</div>
		 	<form action="" method="post" id="fmain" style="display: none;">
		 	<h2>预览：</h2>
		 	<div id="fileList" class="uploader-list"></div>
				<input type="submit" value="完成" onclick="return onfinish();" class="ui-button ui-button-mblue"/>
				<input type="hidden" name="avatar" id="hidlogo" value=""/>
			</form>
		 </div>
		 </div>
	</div>
</div>
	</div>
</div>
<!-- 上传头像 demo：
<form action="" method="post" id="fmain">
	<input type="submit" value="完成" onclick="return onfinish();"/>
	<input type="hidden" name="avatar" id="hidlogo" value=""/>
</form>

<div id="uploader-demo">
    用来存放item
    <div id="fileList" class="uploader-list"></div>
    <div id="filePicker">选择图片</div>
</div> -->

<jsp:include page="/include_footer"/>

<script type="text/javascript" src="f/assets/webuploader-0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="f/assets/js/individual_info_avatar.js"></script>
</body>
</html>