<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>주문서 작성</title>
<!-- daum 우편번호검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>

    div { box-sizing : border-box; }
    body { font-family: 'Noto Sans KR', sans-serif !important; }

    .wrap {
        width: 100%;
        height: inherit;
        margin : auto;
    }
    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }
	#header { height: 130px; }
	
    #content { display: flex; height: auto; }
    #content>div { height : 100%; float : left; }
    
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }
    
    #content_2>div { width: 100%; }
    #content_2_1, #content_2_3 { height: 115px; }
    #content_2_2 { height: auto; color: black; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
    }
	
	/* 주문서 작성 */
	#content_2_2>table {
		width: 100%;
		color: black;
	}
	#content_2_2>table>thead { border-bottom: solid lightgray; }
	
	/* 주문제품 정보 */
	#bill_product>tbody {  }
	#bill_product>tbody tr { height: 50px; }
	.ptitle { padding-left: 20px; }
	
	
	/* 배송지 정보 */
	#bill_delivery>tbody tr { height: 50px; }
	#bill_delivery .form-control {
		display: inline-block;
		width: 300px;
	}
	
	#address_btn {
		display:inline-block;
		vertical-align: top;
		margin-left: 11px;
		width: 150px;
	}
	#address1, #address2 { width: 465px!important; }
	
	/* 결제 안내 */
	#bill_price>tbody div {
		width: 50%;
		margin: auto;
		border: 1px solid #78C2AD;
		border-radius: 10px;
	}
	#price_info {
		width: 90%;
		margin: 15px;	
	}
	#price_info tr { height: 40px; }
	#price_info thead th, #price_info tbody th { text-align: right; }
	#price_info tbody>tr {
		border-top: 1px solid #78C2AD;
		font-size: 25px;
		height: 60px;
	}
	#price_info tfoot>tr { height: 100px;}
	#price_info tfoot div {
		width: 70%;
		background-color: #78c2ad36;
		border: none;
		border-radius: 10px;
		text-align: center;
		padding: 20px;
	}
	
	/* 결제 버튼 */
	#bill_btn { margin-top: 50px; }
	#bill_btn>button {
		width: 250px;
		height: 55px;
	}
	
	/* 카드정보 입력 모달 */
	.modal-body>table tr { height: 60px; }
</style>
</head>
<body>

    <div class="wrap">
        <div id="navigator2">
            <jsp:include page="../common/menubar.jsp" />
        </div>
        <div id="header"></div>
        <div id="content">
            <div id="content_1"></div>
            <div id="content_2">
                <div id="content_2_1">
                    <p>주문서 작성</p>
                </div>
                <div id="content_2_2">
                    <table id="bill_product">
                        <thead>
                            <tr height="50px">
                                <th align="left">주문 제품 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<tr style="height: 10px!important;"></tr>
                        	
                        	<c:forEach var="c" items="${ clist }">
                        		<c:forEach var="p" items="${ plist }">
                        			
                        			<c:if test="${ c.productNo eq p.productNo }">
		                        		<tr>
		                                <td rowspan="2" align="center" width="10%;"><img src="${ p.productImgPath }" width="100px" height="100px"></td>
		                                <td width="60%;" class="ptitle">${ p.productExplain }엔</td>
		                                <td rowspan="2" width="10%;" align="right">${ c.cartAmount } 개</td>
		                                <td rowspan="2" align="right" style="font-size: 23px;" width="20%;"><b class="prices"><fmt:formatNumber value="${ c.cartAmount * p.productPrice }" /> 원</b></td>
		                                
			                            </tr>
			                            <tr style="border-bottom: 1px solid lightgray;">
			                                <td style="font-size: 20px; vertical-align: top;" class="ptitle" id="product_name"><b>${ p.productName }</b></td>
			                            </tr>
		                            </c:if>
		                            
	                            </c:forEach>
                        	</c:forEach>
                        	
                        </tbody>
                    </table>
                    
                    <div style="height: 100px;"></div>
                    <table>
                        <thead>
                            <tr height="50px">
                                <th align="left">배송지 정보</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<tr style="height: 30px!important;"></tr>
                        	<tr><td><div align="center">
	                        	<table id="bill_delivery">
			                        <tr>
			                            <td>이름</td>
			                        </tr>
			                        <tr>
			                            <td><input class="form-control" value="${ loginUser.memberName }" readonly></td>
			                        </tr>
			                        <tr>
			                            <td>전화번호</td>
			                        </tr>
			                        <tr>
			                            <td><input class="form-control" value="${ loginUser.phone }" readonly></td>
			                        </tr>
			                        <tr>
			                            <td>우편번호</td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <input type="text" class="form-control" name="addressZip" value="${ loginUser.addressZip }" id="address_zip" placeholder="우편번호" readonly>
			                                <input type="button" class="btn btn-primary" id="address_btn" onclick="getAddress();" value="우편번호 찾기">
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>주소</td>
			                        </tr>
			                        <tr>
			                            <td><input type="text" class="form-control" name="address1" value="${ loginUser.address1 }" id="address1" placeholder="도로명 주소" readonly></td>
			                        </tr>
			                        <tr>
			                            <td>상세주소</td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <input type="text" class="form-control" name="address2" value="${ loginUser.address2 }" id="address2" placeholder="상세 주소 (선택)" style="display:inline-block;">
			                            </td>
			                        </tr>
		                        </table>
	                        </div></td></tr>
                        </tbody>
                    </table>
                    
                    <script>
				        /* 우편번호 검색 API */
				        function getAddress() {
				            new daum.Postcode({
				                oncomplete: data => {
				                	
				                	// 지번을 선택해도 도로명으로만 표시
				                	var address = data.roadAddress;
				                	
				                	// 건물명이 있을 경우 추가
				                	if(data.buildingName != '') {
				                		address += ' (' + data.buildingName + ')';
				                	}
				                	
				                	// 우편번호
				                	$("#address_zip").val(data.zonecode).attr("readonly", true);
				                	// 선택한 주소
				                	$("#address1").val(address).attr("readonly", true);
				                	
				                	// 커서 포커스
				                	$("#address2").focus();
				    
				                }
				            }).open();
				        }
				    </script>
                    
                    <div style="height: 100px;"></div>
                    <table id="bill_price">
                        <thead>
                            <tr height="50px">
                                <th align="left">결제 예정 금액</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<tr style="height: 30px!important;"></tr>
                            <tr><td><div align="center">
                                <table id="price_info">
                                	<thead>
                                        <tr>
                                            <td>총 제품 금액</td>
                                            <th id="total"></th>
                                        </tr>
                                        <!-- 정기구독 여부 Y 일 경우에만 보이기 -->
                                        <c:if test="${ num eq 1 }">
	                                        <tr>
	                                            <td>정기 구독 10% 할인</td>
	                                            <th id="discount"></th>
	                                        </tr>
                                        </c:if>
                                        
                                        <tr>
                                            <td>배송비</td>
                                            <!-- 정기구독 여부 N 이고 5만원 미만일 때만 -->
                                       		<th id="deliverPay">0 원</th>
                                        </tr>
                                        <tr style="height:10px!important;"></tr>
                                    </thead>
                                    <tbody>
                                    	<tr>
                                    		<td>최종 결제 금액</td>
                                    		<th id="finalprice"></th>
                                    	</tr>
                                    </tbody>
                                    <c:if test="${ num eq 1 }">
	                                    <tfoot>
	                                        <tr>
	                                        	<th colspan="2"><div></div></th>
	                                        </tr>
	                                    </tfoot>
                                    </c:if>
                                </table>
	                            </div></td></tr>
                        </tbody>
                    </table>
                    
                    <script>
	                    $(() => {
				        	
				        	var prices = $('.prices').text().split(' 원');
				        	var total = 0;
				        	
				        	for(var i = 0; i < prices.length - 1; i++) {
				        		total += parseInt(prices[i].replace(',', ''));
				        	}
				        	
				        	var discount = total * 0.1;
				        	
				        	$('#total').text(total.toLocaleString('ko-KR') + ' 원');
				        	
				        	var date = new Date();
				        	date.setMonth(date.getMonth() + 1);
				        	date = moment(date).format('YYYY.MM.DD');
				        	
				        	$("#price_info>tfoot div").html('다음 결제 예정일&nbsp;&nbsp;&nbsp;' + date);
				        }); 
                    </script>
                    
                    <c:choose>
	                    <c:when test="${ num eq 2 }">
	                    	<script>
	                    		$(() => {
	                    			
	                    			var total = parseInt($('#total').text().substring(0, $('#total').text().indexOf(' 원')).replace(',',''));
	                    			var deliverPay = 0;
	
									if(total < 50000) {
										$("#deliverPay").text('+ 3,000 원');
										deliverPay = 3000;
									}
									
									$("#finalprice").text((total + deliverPay).toLocaleString('ko-KR') + ' 원');
	                    		});
	                    	</script>
	                    </c:when>
	                    <c:otherwise>
	                    	<script>
			                    $(() => {
						        	
			                    	var total = parseInt($('#total').text().substring(0, $('#total').text().indexOf(' 원')).replace(',',''));
						        	var discount = total * 0.1;
						        	
						        	$('#discount').text('- ' + discount.toLocaleString('ko-KR') + ' 원');
						        	$('#finalprice').text((total - discount).toLocaleString('ko-KR') + ' 원');
						        	
						        	var date = new Date();
						        	date.setMonth(date.getMonth() + 1);
						        	date = moment(date).format('YYYY.MM.DD');
						        	
						        	$("#price_info>tfoot div").html('다음 결제 예정일&nbsp;&nbsp;&nbsp;' + date);
						        }); 
	                    </script>
	                    </c:otherwise>
                    </c:choose>
                    
                    <div id="bill_btn" align="center">
                    	<c:choose>
                    		<c:when test="${ num eq 1 }">
                    			<!-- 정기결제 -->
                    			<button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#subscription">구독하기</button>
                    			
                    			<!-- 카드정보 입력폼 모달 -->
                    			<div class="modal" tabindex="-1" id="subscription">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">카드 정보 입력</h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<table id="customer_uid">
													<tr>
														<th width="40%;">카드 번호</th>
														<td width="60%;"><input id="card_number" class="form-control" type="text" maxlength="19" placeholder="XXXX-XXXX-XXXX-XXXX (- 포함)" pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}"></td>
													</tr>
													<tr>
														<th>유효기간</th>
														<td><input id="expiry" class="form-control" type="text" maxlength="7" placeholder="YYYY-MM (- 포함)" pattern="[0-9]{4}-[0-9]{2}"></td>
													</tr>
													<tr>
														<th>생년월일</th>
														<td><input id="birth" class="form-control" type="text" maxlength="6" placeholder="YYMMDD" pattern="[0-9]{6}"></td>
													</tr>
													<tr>
														<th>비밀번호 앞 두자리</th>
														<td><input id="pwd_2digit" class="form-control" type="password" maxlength="2" placeholder="XX" pattern="[0-9]{2}"></td>
													</tr>
													<tr>
														<th colspan="2" style="color: red; font-size: small; height: 80px; text-align: center;">유효하지 않은 카드정보를 입력할 경우 결제가 거절될 수 있습니다.<br>결제 전 확인 부탁드립니다.</th>
													</tr>
												</table>
											
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-primary" onclick="subscription();">정기구독 결제하기</button>
											</div>
										</div>
									</div>
								</div>
                    		</c:when>
                    		<c:otherwise>
                    			<!-- 일반결제 -->
                    			<button type="button" class="btn btn-primary btn-lg" onclick="regular();">결제하기</button>
                    		</c:otherwise>
                    	</c:choose>
                    </div>

                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
    	function regular() {
    		
    		if($("#address1").val().length != 0) {
    			
   			 	var date = moment(new Date()).format('YYYYMMDDHHmmss');
   				var orderNo = date + (parseInt(Math.random() * 90000) + 10000);
   				var amount = parseInt($("#finalprice").text().substring(0, $("#finalprice").text().lastIndexOf(' ')).replace(',', ''));
	    		// amount = 100;
	    		
	    		var address = $("#address1").val();
	    		if($("#address2").val() != '') {
	    			address += ' ' + $("#address2").val();
	    		}
   				
	    		IMP.init("imp00813715"); // 가맹점 식별코드 초기화
	    		
	    		// IMP.request_pay(param, callback)
	    		IMP.request_pay({ // param
	    			pg: "nice", // PG사 코드값
	    			pay_method: "card", // 결제방법
	    			merchant_uid: orderNo, // 가맹점 주문번호 (중복X, 한 주문번호로 재결제 불가)
	    			name: $("#product_name").text() + ' 외 1개', // 결제창에 노출될 상품명 (16자 이내 권장), 0번째 인덱스 상품명 + 외 n개
	    			amount: amount, // 결제할 금액
	    			buyer_name: "${ loginUser.memberName }", // 구매자 이름
	    			buyer_email: "${ loginUser.email }", // 구매자 이메일
	    			buyer_postcode: $("#address_zip").val(),
	    			buyer_addr: address,
	    			custom_data: { memberNo: ${ loginUser.memberNo } }
	    		}, rsp => { // callback
	    			
	    			// console.log(rsp);
	    		
	    			if(rsp.error_code == 'STOP') {
	    				alert(rsp.error_msg);
	    				location.href = 'list.cart';
	    			} else {
	    				
	    				$.ajax({
		    				type: "post",
		    				url: "verifyIamport/" + rsp.imp_uid
		    			}).done(data => {
		    				
		    				// console.log(data);
		    				
		    				if(rsp.paid_amount == data.response.amount) {
		    					
		    					location.href = 'paid?ono=' + rsp.merchant_uid; 
		    				
		    				} else {
		    					
		    					alert("결제에 실패했습니다.");
		    					location.href = 'list.cart';
		    				}
		    			});
	    			}
	    		});
    		} else {
    			alert("배송지 정보를 입력해주세요.");
    			setTimeout(() => {$("#address_zip").focus();}, 1);
    		}
    	}
    	
		function subscription() {
			
			if($("#address1").val().length != 0) {
    			
   			 	var date = moment(new Date()).format('YYYYMMDDHHmmss');
   				var orderNo = date + (parseInt(Math.random() * 90000) + 10000);
   				var amount = parseInt($("#finalprice").text().substring(0, $("#finalprice").text().lastIndexOf(' ')).replace(',', ''));
	    		// amount = 100;
	    		
	    		var customerUid = "${ loginUser.memberNo }" + '_' + $("#card_number").val().substring(15);
	    		
	    		var address = $("#address1").val();
	    		if($("#address2").val() != '') {
	    			address += ' ' + $("#address2").val();
	    		}
			
				// 빌링키 발급, 저장 동시에 첫 결제
				$.ajax({
					url: "subscribe/payments/onetime",
					type: "post",
					data: {
						merchant_uid: orderNo,
		    			amount: amount,
		    			customer_uid: customerUid,
		    			pg: "nice",
		    			name: $("#product_name").text() + ' 외 1개',
		    			buyer_name: "${ loginUser.memberName }",
		    			buyer_email: "${ loginUser.email }",
		    			buyer_postcode: $("#address_zip").val(),
		    			buyer_addr: address,
		    			custom_data: JSON.stringify({ "memberNo" : ${ loginUser.memberNo } }),
						card_number: $("#card_number").val(),
						expiry: $("#expiry").val(),
						birth: $("#birth").val(),
						pwd_2digit: $("#pwd_2digit").val()
					}
				}).done(data => {
					
					console.log(data);
					
					if(data.response.status == 'paid') {
						
						// 주문 성공 화면으로 이동
						location.href = 'paid?ono=' + data.response.merchantUid; 
					} else {
						alert(data.message);
					}
				});
						
			} else {
    			alert("배송지 정보를 입력해주세요.");
    			setTimeout(() => {$("#address_zip").focus();}, 1);
    		}
    	}
    </script>
    
</body>
</html>