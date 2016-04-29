<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级主页——单身派对</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<style type="text/css">
.tainfo {
	padding: 20px;
	padding-left:40px;
	width: 10%;
	position: absolute;
	background-color: #fff;
	border:2px dashed #C4CCDF;
}
.tadet .ui-label{width:300px;}
.ui-label{width:}
.ui-form-item:nth-child(odd){background: #eee;}
.stupics{width:110px;height:110px;display: inline-block;margin-top: 15px;}
.btninter{margin: 7px;text-align: center;width:70%;}
.btninter button{width:100%;}
.ui-form-text{width:80%;}
.ui-button{padding: 0}
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

				<jsp:include page="/include_partylsidebar" />

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>单身派对--个人详情
							<a href="/iparty/index">&lt;&lt;返回派对</a>
							</h2>
							<div class="tainfo">
								<div class="avatar bordered-img">
									<a href="${tap.avatar}" target="_blank"> <img
										src="${tap.avatar }thumb102-102" alt="avatar"
										onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';"
										onload="FillImage(this,102,102);" />
									</a>
								</div>
								访问：${tap.visit }
								<div class="btninter"><button class="ui-button ui-button-mwhite" onclick="interact(this,'text-warm','praise','${ta.no}',${ta.classId} );">赞(${tap.praise })</button></div>
								<div class="btninter"><button class="ui-button ui-button-mwhite" onclick="interact(this,'text-warm','flower','${ta.no}',${ta.classId} );">送鲜花(${tap.flower })</button></div>
								<div class="btninter"><button class="ui-button ui-button-mwhite" onclick="interact(this,'text-warm','love','${ta.no}',${ta.classId} );">心动(${tap.love })</button></div>
								<div class="btninter"><button class="ui-button ui-button-mwhite" onclick="location.href='/icenter_newmsg?no=${ta.no}&classId=${ta.classId }'">发送消息</button></div>
							</div>
							<div class="tadet">
							<form class="ui-form text text-dark">
    <fieldset>

        <div class="ui-form-item">
            <label for="" class="ui-label">姓名：</label>
            <p class="ui-form-text">${tap.name }
            <c:if test="${tap.sex == 77 }"><img src="/f/assets/img/man.png" width="18px" height="18px"/></c:if>
            <c:if test="${tap.sex == 87 }"><img src="/f/assets/img/woman.png" width="18px" height="18px"/></c:if>
            </p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">来自：</label>
            <p class="ui-form-text">${tap.fromProvince }&nbsp;${tap.fromCity }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">出生日期：</label>
            <p class="ui-form-text">${ta.birth }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">所在班级：</label>
            <p class="ui-form-text">${tap.univName }&nbsp;${tap.collegeName }&nbsp;${tap.profName }&nbsp;${tap.clzName }</p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">兴趣爱好：</label>
            <p class="ui-form-text">
            <c:if test="${empty ta.hobbies}"><span class="text text-weak">TA的兴趣爱好暂时没有填写</span></c:if>
           <c:if test="${!empty ta.hobbies }"><c:out value="${ta.hobbies }"></c:out></c:if>
            </p>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">自我介绍：</label>
            <div class="ui-form-text">
            <c:if test="${empty ta.signature}"><span class="text text-weak">TA的自我介绍还在酝酿中...</span></c:if>
           <c:if test="${!empty ta.signature }">${ta.signature}</c:if>
            </div>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">期望的TA：</label>
            <p class="ui-form-text">
            <c:if test="${empty taexp.expect}"><span class="text text-weak">TA还没有填写TA的期望</span></c:if>
           <c:if test="${!empty taexp.expect }"><c:out value="${taexp.expect}"></c:out></c:if>
            </p>
        </div>
        
       
        <div class="ui-form-item">
            <label for="" class="ui-label text text-warning" style="padding-top:5px;">TA的联系方式：</label>
            <c:if test="${ta.connection!='NA' }">
            <p class="ui-form-text" id="con2trans">
	            <c:if test="${empty ta.connection}"><span class="text text-weak">TA还没有填写TA的联系方式</span></c:if>
	           <c:if test="${!empty ta.connection }">${ta.connection }</c:if>
	           
            </p>
	         <script type="text/javascript">(function (){
	        	var con = JSON.parse($('#con2trans').html());
	        	$('#con2trans').html("微信："+(con.W||'（暂无）')+"，QQ："+(con.Q||'（暂无）')+"，手机号码："+(con.P||'（暂无）'));
	        })()</script>
       		 </c:if>
       		 <c:if test="${ta.connection=='NA' }"><p class="ui-form-text"><span class="ui-form-text text text-weak">小提示：只有在对方选择对你心动时才可以看到联系方式~</span></p></c:if>
        </div>
        <div class="ui-form-item">
            <label for="" class="ui-label">更多照片：</label>
            <p class="ui-form-text">
            <c:forEach var="pho" items="${tapho }" varStatus="status">
				<div class="stupics bordered-img">
									<a href="javascript:;" 
										onclick="photoGallery('${ta.no }',${ta.classId },${status.index })"> <img
										src="${pho.picPath }thumb110-110" alt="avatar"
										onerror="this.onerror=null;this.src='/f/assets/img/defavatar.jpg';"
										onload="FillImage(this,110,110);" />
									</a>
								</div>
								</c:forEach>
            </p>
        </div>

        </fieldset></form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript" src="/f/assets/layer/extend/layer.ext.js"></script>
	<script type="text/javascript">
function photoGallery(no,classId,start){
	if(!no ||!classId) return;
	start = start||0;
	$.get('/stupics/photo.json',{stuNo:no,clzId:classId,start:start},'json')
	.done(function(data){
		layer.photos({
	        json: data
	    });
	});
}
		function interact(a, addclass, type, no, clzId) {
			if((type=="love" && confirm("对TA心动之后，对方将在你的详情页里看到你的联系方式，确认继续？") || type!="love"))
				$.get('/partyi/' + type, {
					toNo : no,
					toClz : clzId,
					cancel : false
				}, 'json').done(function(data) {
					if (data && data.ok) {
						alert('操作成功！',function(){
							location.reload();
						})
					} else if (data && data.msg)
						alert(data.msg);
					else
						alert('error');
				});
		}
	</script>
</body>
</html>