<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page session="true" %>
<!doctype html>
<html lang='ko'>
<head>
	<%@ include file="/WEB-INF/inc/head.jsp" %>
	<title>productCartList</title>
</head>
<body>
	<%@ include file="/WEB-INF/inc/topbar.jsp" %>
	
	<div class="container">
		<h1 class="page-header">장바구니</h1>
		
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
		    	</tbody>
			</table>
		</div>
		<!--// 장바구니 목록 끝 -->
		
		<!-- 결제 폼 시작 -->
		<div class="clearfix">
		    <div id="pay_form" class="pull-right">
			</div>
		</div>
		<!--// 결제 폼 끝 -->
	</div>
	
	<%@ include file="/WEB-INF/inc/footer.jsp" %>
	
	<!-- 카트 삭제 모달 시작 [사용 안함] -->
	<div id="cart_delete_modal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!--// 카트 삭제 모달 끝 -->
	
	<!-- 결제 완료 모달 시작 -->
	<div id="pay_ok_modal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
			</div>
		</div>
	</div>
	<!--// 결제 완료 모달 끝  -->
	
	<script>
		$(function() {
			/** 페이지가 열리면서 동작하도록 이벤트 정의 없이 Ajax요청 */
			$.get("${pageContext.request.contextPath}/user/cart/memberCartList.do", {
				user_id: "2"	// 세션 후 수정
			}, function(json) {
				if (json.rt != "OK") {
					alert(json.rt);
					return false;
				}
				
				var member_id = json.cartList[0].member_id;
				var total = 0;
				
				for(var i = 0; i < json.productList.length; i++) {
					var image = json.productList[i].image;
					var name = json.productList[i].name;
					var amount = json.cartList[i].amount;
					var price = json.productList[i].price;
					var id = json.cartList[i].id;
					var total = total + price*amount;
					
					$('#cart_table_body').append(
						'<tr id=cart_' + id + '><td class="text-center">' + image
						+ '</td><td class="text-center">' + name
						+ '</td><td class="text-center">' + amount
						+ '</td><td class="text-center">' + price
						+ '</td><td class="text-center"><a href="${pageContext.request.contextPath}/user/cart/memberCartDelete.do?cart_id=' + id
						+ '" data-toggle="modal" data-target="#cart_delete_modal" class="btn btn-danger">삭제하기</a></td></tr>');
				}
				
				$('#pay_form').append(
					'<h5>총 제품금액: ' + total + '원</h5><h5>배송비: 2500원</h5><hr><h5>총 결제금액: ' + (total+2500) + '원</h5>'
					+ '<a href="${pageContext.request.contextPath}/user/order/memberOrderInsert.do?member_id=' + member_id + '&total=' + (total+2500)
					+ '" class="btn btn-primary"><span class="glyphicon glyphicon-credit-card"></span> 결제하기</a>');
			});
		
			/** 모든 모달창의 캐시 방지 처리 */
			$('.modal').on('hidden.bs.modal', function (e) {
				// 모달창 내의 내용을 강제로 지움.
	    		$(this).removeData('bs.modal');
			});
			
			/** 동적으로 로드된 폼 안에서의 submit 이벤트 */
			$(document).on('submit', "#cart_delete_form", function(e) {
				e.preventDefault();

				// AjaxForm 플러그인의 강제 호출
				$(this).ajaxSubmit(function(json) {
					if (json.rt != "OK") {
						alert(json.rt);
						return false;
					}
					
					$("#cart_delete_modal").modal('hide'); // modal 강제로 닫기
					alert("삭제되었습니다.");
					
					// JSON 결과에 포함된 덧글일련번호를 사용하여 삭제할 <li>의 id값을 찾는다.
					var cart_id = json.cart_id;
					$("#cart_" + cart_id).remove();
				});
			});
		});
		
	</script>
</body>
</html>