<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心——修改密码</title>
<link rel="stylesheet" href="f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="f/assets/css/header.css" />
<style type="text/css">
#queryResult{margin-top: 15px;}
</style>
<script type="text/javascript" src="f/assets/js/jquery-2.1.0.min.js"></script>
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
					<jsp:param value="6" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>个人资料--修改密码</h2>
							<form class="ui-form" name="" method="post" action="#" id="fmain">
    <fieldset>
        <legend>修改密码</legend>

        <div class="ui-form-item">
            <label for="" class="ui-label">
                <span class="ui-form-required">*</span>原密码：
            </label>
            <input class="ui-input" type="password" name="o" value="">
            <p class="ui-form-explain">系统初始密码为学号后6位。</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">
                <span class="ui-form-required">*</span>新密码：
            </label>
            <input type="hidden" name="toClz" value="1"/>
            <input class="ui-input" type="password" name="n" value="">
        </div>

        <div class="ui-form-item">
            <label for="" class="ui-label"> <span class="ui-form-required">*</span>新密码确认：</label>
            <input class="ui-input" type="password" name="cn" value="">
        </div>

        <div class="ui-form-item">
            <input type="button" class="ui-button ui-button-lorange" value="确认修改" onclick="onupdpwd();return false;">
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
<script type="text/javascript">
function onupdpwd(){
	var param = $('#fmain').serializeObject();
	if(!param.o) return alert('请输入原密码~');
	if(!param.n) return alert('请输入新密码~');
	if(param.n != param.cn) return alert('请确认两次输入的新密码一致~');
	$.post('/stu/pwdupd',param,'json')
	.done(function(data){
		if(data && data.ok){
			alert('恭喜你，密码修改成功！请使用新密码登录系统。',function(){
				location.href="/logout";
			});
		}
		else alert(data.msg);
	});
}
</script>
</body>
</html>