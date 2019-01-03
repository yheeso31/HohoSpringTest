<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page session="true" %>
<!doctype html>
<html lang='ko'>
<head>
	<%@ include file="/WEB-INF/inc/head.jsp" %>
	<title>memberOrderView</title>
</head>
<body>
	<%@ include file="/WEB-INF/inc/topbar.jsp" %>
	
	<div class="container">
		<h1 class="page-header">주문 상세보기</h1>
		
		<!-- 장바구니 목록 시작 -->
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
		        	<tr>
		            	<th class="text-center" style="width: 150px">사진</th>
		            	<th class="text-center">제품명</th>
		            	<th class="text-center" style="width: 120px">수량</th>
		            	<th class="text-center" style="width: 120px">금액</th>
		            	<th class="text-center" style="width: 120px">선택</th>
		        	</tr>
		    	</thead>
		    	<tbody id="cart_table_body">
		    		<tr>
		    	</tbody>
			</table>
		</div>
		<!--// 장바구니 목록 끝 -->
		
		<!-- 금액 폼 시작 -->
		<div class="clearfix">
		    <div id="pay_form" class="pull-right">
			</div>
		</div>
		<!--// 금액 폼 끝 -->
	</div>
	
	<%@ include file="/WEB-INF/inc/footer.jsp" %>
</body>
</html>