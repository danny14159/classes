<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>【个人中心】个人资料管理——基础信息</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
	<link rel="stylesheet" href="/f/assets/css/header.css" />
	<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
	<script type="text/javascript" src="/f/assets/location/js/area.js"></script>
<script type="text/javascript" src="/f/assets/location/js/location.js"></script>
<script src="/f/assets/location/js/select2.js"></script>
<script src="/f/assets/location/js/select2_locale_zh-CN.js"></script>
<link href="/f/assets/location/css/select2.css" rel="stylesheet"/>
	
</head>
<body>
<jsp:include page="/include_header"/>
	<jsp:include page="/include_content">
		<jsp:param name="i" value="1" />
	</jsp:include>
	
	<div class="" id="row1">

<div class="tabmain wrapper">
  <div class="outerWrap">
  	
  	<jsp:include page="/include_lsidebar">
  		<jsp:param value="1" name="index"/>
  	</jsp:include>
  	
    <div class="container">
		<div class="content">
		 <div class="tabContent">
		 	<h2 class="header"><span class="tabHeader"></span>个人资料——基础信息</h2>
		 	<h3>基础资料</h3>
		 	<form class="ui-form" name="" method="post" id="ibasic">
			<fieldset>
        <legend>表单标题</legend>
        
        <div class="ui-form-item">
        <label for="" class="ui-label">
            <input type="button" class="ui-button ui-button-morange" value="保存" onclick="return saveInfo();">
 		</label>
        </div>

        <div class="ui-form-item">
            <label for="" class="ui-label">性别</label>
				<!-- <div class="ui-select" style="width: 120px">
				  <a href="#" class="ui-select-trigger">
				    默认选项
				    <i class="iconfont" title="下三角形">&#xF03C;</i>
				  </a>
				  <ul class="ui-select-content">
				    <li class="ui-select-item"><a href="#">选项 1</a></li>
				    <li class="ui-select-item"><a href="#">选项 2</a></li>
				    <li class="ui-select-item"><a href="#">选项3</a></li>
				  </ul>
				</div> -->
            <select id="sex" name="sex">
            	<option value=""></option>
                <option value="W" <c:if test="${me.sex==87 }">selected="selected"</c:if> >女</option>
                <option value="M" <c:if test="${me.sex==77 }">selected="selected"</c:if> >男</option>
            </select>
        </div>

        <div class="ui-form-item">
            <label for="" class="ui-label">
                <!-- <span class="ui-form-required">*</span> -->信息门户密码
            </label>
            <input class="ui-input" type="password" name="pwPortral" value="${me.pwPortral }"> <span class="ui-form-other"><a href="#">保密申明</a></span>
            <p class="ui-form-explain">有助你登录信息门户，获取成绩课表等信息</p>
        </div>
        
        <div class="ui-form-item">
         <label for="" class="ui-label">居住地</label>
         <select id="loc_province" style="width:120px;">
  </select>
  <select id="loc_city" style="width:120px; margin-left: 10px">
  </select>
  <!-- <select id="loc_town" style="width:120px;margin-left: 10px">
  </select> -->
        <!-- 
           
            <select  name="fromProvince" id="fromProvince">
                <option value="安徽">安徽</option><option value="澳门">澳门</option><option value="北京">北京</option><option value="福建">福建</option><option value="甘肃">甘肃</option><option value="广东">广东</option><option value="广西">广西</option><option value="贵州">贵州</option><option value="海南">海南</option><option value="河北">河北</option><option value="河南">河南</option><option value="黑龙江">黑龙江</option><option value="湖北">湖北</option><option value="湖南">湖南</option><option value="吉林">吉林</option><option value="江苏">江苏</option><option value="江西">江西</option><option value="辽宁">辽宁</option><option value="内蒙古">内蒙古</option><option value="宁夏">宁夏</option><option value="青海">青海</option><option value="山东">山东</option><option value="山西">山西</option><option value="陕西">陕西</option><option value="上海">上海</option><option value="四川">四川</option><option value="台湾">台湾</option><option value="天津">天津</option><option value="西藏">西藏</option><option value="香港">香港</option><option value="新疆">新疆</option><option value="云南">云南</option><option value="浙江">浙江</option><option value="重庆">重庆</option><option value="海外">海外</option>
            </select>
            <select name="fromCity" id="fromCity">
                <option>南通市</option>
                <option>宁夏</option>
                <option>镇江市</option>
            </select> -->
        </div>
        
        <div class="ui-form-item">
            <label for="" class="ui-label">生日 </label>
            <input class="ui-input laydate-icon" type="text" name="birth" value="${me.birth }" onclick="laydate()"><span class="ui-form-other"></span>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">兴趣爱好 </label>
            <input class="ui-input" type="text" name="hobbies" value="${me.hobbies }"> <span class="ui-form-other"></span>
            <p class="ui-form-explain">填写详细的兴趣爱好有助于你找到情投意合的TA</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">自我介绍 </label>
            <script id="editor" type="text/plain" style="width:500px;height:200px;" name="signature">${me.signature }</script>
        </div>
        
        <h3>联系方式</h3>
         <div class="ui-form-item">
            <label for="" class="ui-label">QQ</label>
            <input class="ui-input" type="text" id="cq" name="cq"> <span class="ui-form-other"></span>
        </div>
         <div class="ui-form-item">
            <label for="" class="ui-label">常用手机号</label>
            <input class="ui-input" type="text" id="cp" name="cp"> <span class="ui-form-other"></span>
        </div>
         <div class="ui-form-item">
            <label for="" class="ui-label">微信</label>
            <input class="ui-input" type="text" id="cw" name="cw"> <span class="ui-form-other"></span>
            <p class="ui-form-explain">其他联系方式将显示在<a href="/publics/telbook">班级通讯录</a>和<a href="/iparty/index">单身派对</a>中你的详情页</p>
        </div>
        
        <h3>找回信息</h3>
         <div class="ui-form-item">
            <label for="" class="ui-label">手机号码</label>
            <input class="ui-input" type="text" name="phone" value="${me.phone }"> <span class="ui-form-other"></span>
        </div>
         <div class="ui-form-item">
            <label for="" class="ui-label">电子邮箱</label>
            <input class="ui-input" type="text" name="email" value="${me.email }"> <span class="ui-form-other"></span>
            <p class="ui-form-explain">手机和邮箱任填一项，用于<a href="#">找回密码</a></p>
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
<script type="text/javascript" src="/f/assets/laydate/laydate.js"></script>
<script type="text/javascript" src="/f/assets/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="/f/assets/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/f/assets/ueditor/lang/zh-cn/zh-cn.js"></script>

<!-- <script type="text/javascript" src="f/assets/webuploader-0.1.5/webuploader.min.js"></script> -->
<script type="text/html" id="tplcon">${me.connection }</script>
<script type="text/javascript">
$(function(){
	$('#select2-chosen-2').text('${me.fromCity }');
	$('#select2-chosen-1').text('${me.fromProvince }');
	
	var strcon = $('#tplcon').html();
	var con = JSON.parse(strcon||"{}");//联系方式
	if(con){
		$('#cq').val(con.Q);
		$('#cp').val(con.P);
		$('#cw').val(con.W);
	}
	
	//date控件皮肤初始化
	laydate.skin('molv');
	
	//ueditor编辑器初始化
	var ue = UE.getEditor('editor', {
	    toolbars: [
	        ['fullscreen', 'source', 'undo', 'redo'],
    ['bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc']
	    ],
	    autoHeightEnabled: true,
	    autoFloatEnabled: true,
	    enableAutoSave :false
	});
});
function saveInfo(){
	var fmdata = jQuery('#ibasic').serializeObject();
	fmdata.connection=JSON.stringify({
		P:fmdata.cp||'',
		Q:fmdata.cq||'',
		W:fmdata.cw||''
	});
/* 	$.each(fmdata,function(name,value){
		if(!value) delete fmdata[name];
	}); */
	fmdata.fromProvince = $('#loc_province').val()?$('#loc_province').select2('data').text:null;
	fmdata.fromCity =$('#loc_city').val()? $('#loc_city').select2('data').text:null;
	console.log(fmdata);
	$.post('/stu/upd',fmdata,'json')
	.done(function(data){
		if(data && data.ok){
			alert('保存成功',function(){
				location.reload();
			});
		}
		else alert(data.msg)
	});
	return false;
}
</script>
</body>
</html>