<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派对中心——我的派对</title>
<link rel="stylesheet" href="/f/assets/iconfont/iconfont.css" />
<link media="all" href="/f/assets/css/one.css" rel="stylesheet">
<link rel="stylesheet" href="/f/assets/css/header.css"/>
<link rel="stylesheet" href="/f/assets/css/party.css"/>
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

				<jsp:include page="/include_partylsidebar"><jsp:param value="2" name="index"/></jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>单身派对——我的派对历史</h2>
							<table class="ui-table">
								<tr>
									<th>加入时间</th>
									<th>退出时间</th>
									<th>期望的TA</th>
									<th>浏览数</th>
									<th>心动</th>
									<th>赞</th>
									<th>鲜花</th>
								</tr>
								<c:forEach items="${history }" var="h">
									<tr>
									<td><fmt:formatDate value="${h.enterTime }" pattern="yyyy-MM-dd E"/></th>
									<td><fmt:formatDate value="${h.exitTime }" pattern="yyyy-MM-dd E"/></th>
									<td style="width:35%;word-break:break-all;"><c:out value="${h.expect }"></c:out></th>
									<td>${h.visit }</th>
									<td>${h.love }</th>
									<td>${h.praise }</th>
									<td>${h.flower }</th>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	<jsp:include page="/include_footer" />
<script type="text/javascript" src="/f/assets/layer/layer.min.js"></script>
<script type="text/javascript">
</script>
</body>
</html>