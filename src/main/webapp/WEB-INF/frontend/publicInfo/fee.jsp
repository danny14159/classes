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
</style>
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
					<jsp:param value="3" name="index"/>
				</jsp:include>

				<div class="container">
					<div class="content">
						<div class="tabContent">
							<h2 class="header"><span class="tabHeader"></span>班费收支记录</h2>
							<div class="balance ui-tiptext-container ui-tiptext-container-success">
							    <p class="ui-tiptext ui-tiptext-success">
							       班费剩余：<span class="text text-warning"><i class="iconfont">&#xf0150;</i>${balance }</span>
							    </p>
							</div>
							<div id="addfee">
								<script type="text/javascript">
									function addfee(){
										var param = $('#fmaddfee').serializeObject();
										console.log(param);
										if(!param.reason){alert('请填写原因');return;}
										if(!param.amount){alert('请填写金额');return;}
										$.post('/money/ins',param,'json')
										.done(function(data){
											alert(data?'记录添加成功':'系统繁忙，请稍后再试！');
											if(data)location.reload(); 
										})
										.fail(function(){
											alert('添加失败，请确认是否有权限添加。')
										});
									}
								</script>
								<p><button class="ui-button ui-button-mblue" onclick="$('#addmain').show(200);">添加记录</button></p>
								
								<div id="addmain" style="display: none;">
								<h3>添加记录</h3>
								<form class="ui-form" method="post" id="fmaddfee">
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>原因
						            </label>
						            <input class="ui-input" type="text" name="reason" value=""> 
						            <p class="ui-form-explain">请输入原因</p>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">
						                <span class="ui-form-required">*</span>金额
						            </label>
						            <input class="ui-input" type="text" name="amount" value=""> 
						        	<p class="ui-form-explain">请输入金额，如+250.5或-50.5,最多精确到小数点后两位</p>
						        </div>
								<div class="ui-form-item">
						            <label for="" class="ui-label">备注 </label>
						            <input class="ui-input" type="text" name="remark" value="">	
						        </div>
						        <div class="ui-form-item">
						            <input type="submit" class="ui-button ui-button-morange" value="提交" onclick="addfee();return false;">
						        </div>
								</form>
								</div>
							</div>
							<table class="ui-table" id="tbmain">
								<thead>
									<tr>
										<th width="20%">记录流水号</th>
										<th width="20%">收支时间</th>
										<th>原因</th>
										<th>收支金额</th>
										<th>余额</th>
										<th>备注</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach  var="r" items="${iorecord}">
									<tr>
										<td>${r.payNo }</td>
										<td><fmt:formatDate value="${r.payTime }" pattern="yyyy-MM-dd E"/></td>
										<td>${r.reason }</td>
										<td>
										<c:if test="${r.amount>0 }"><span class="text text-success">+${r.amount }</span></c:if>
										<c:if test="${r.amount<=0 }"><span class="text text-warm">${r.amount }</span></c:if>
										</td>
										<td>${r.balance }</td>
										<td>${r.remark	 }</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div class="ui-tiptext-container ui-tiptext-container-question">
							    <p class="ui-tiptext ui-tiptext-success">
							        小班为你保存前50条记录：）
							    </p>
							</div>
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