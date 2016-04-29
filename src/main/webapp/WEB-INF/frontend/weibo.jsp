<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>作业管理</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css" />
<link rel="stylesheet" href="/f/assets/css/party.css" />
<script type="text/javascript" src="/f/assets/js/jquery-2.1.0.min.js"></script>
<script type="text/javascript" src="/f/assets/js/header.js"></script>
<style type="text/css">
.balance{line-height: 2em;margin: 15px 0;}
.balance span{font-size: 2.5em;font-weight: bold;}
.balance i{font-weight: normal;}
#tbmain{margin-top: 15px;}
#frame{width: 100%;min-height: 800px;border: none;}
</style>
</head>
<body>
<jsp:include page="/include_header" />
	<jsp:include page="/include_content">
		<jsp:param name="i" value="6" />
	</jsp:include>

	<div class="" id="row1">

		<div class="tabmain wrapper">
			<div class="outerWrap">

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<div class="ui-tiptext-container ui-tiptext-container-question">
							    <p class="ui-tiptext ui-tiptext-success">
							       本页面来自 外部链接<a href="${clz.weibo }" target="_blank">${clz.weibo }</a>
							    </p>
							</div>
							<iframe src="${clz.weibo }" id="frame"></iframe>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/include_footer" />
</body>
</html>