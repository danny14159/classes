<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级主页——写消息</title>
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
					<jsp:param value="2" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>写消息</h2>
<form class="ui-form" name="" method="post" action="#" id="fmain">
    <fieldset>
        <legend>写消息</legend>

        <div class="ui-form-item">
            <label for="" class="ui-label">
                <span class="ui-form-required">*</span>收件人学号：
            </label>
            <input class="ui-input" type="text" name="toNo" value="${no }"> <span class="ui-form-other"><a href="#">常用联系人</a></span>
            <p class="ui-form-explain">请填写收件人。</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">
                <span class="ui-form-required">*</span>收件人所在班级：
            </label>
            <input type="hidden" name="toClz" value="${classId }"/>
            <input class="ui-input" type="text" name="" value="${className }"> <span class="ui-form-other"></span>
            <p class="ui-form-explain">选择收件人所在班级可以将消息准确发送至收件人。</p>
        </div>

        <div class="ui-form-item">
            <label for="" class="ui-label"> <span class="ui-form-required">*</span>消息正文：</label>
            <p class="ui-form-explain">请书写300字以内的文本</p>
            <textarea class="ui-input" name="content" rows=4 cols=75></textarea>
        </div>

        <div class="ui-form-item">
            <input type="button" class="ui-button ui-button-lorange" value="发送" onclick="onsend();return false;">
        </div>

    </fieldset>
</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/include_footer" />

<script type="text/javascript">
function onsend(){
	var param = $('#fmain').serializeObject();
	if(!param.content) return alert('写点什么再发出去吧。')
	$.post('/msg/sndmsg',param,function(data){
		if(data && data.ok){
			alert('发送成功！');location.href="/icenter_msg_mgr";
		}
		else alert(data.msg);
	});
}
$(function(){
});
</script>
</body>
</html>