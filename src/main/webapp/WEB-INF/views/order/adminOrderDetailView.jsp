<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 주문 관리</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!-- daum 우편번호검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>

	div { box-sizing : border-box; }
    body { font-family: 'Noto Sans KR', sans-serif !important; }

    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }
    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }
	#header { height: 130px; }
	
    #content { height: auto; display:flex; }
    #content>div { height : 100%; float : left; }
    
    #content_1 { width : 20%; }
    #content_2 { width : 60%; padding-bottom: 200px;}
    #content_3 { width : 20%; }
    
    #content_2>div { width: 100%; }
    #content_2_2 { height: auto; color: black; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 15px;
        font-weight: bold;
    }

    /* ----- 마이페이지 공통 style ----- */
    /* 영역 구분 */
    #content_2_2>div { height: 100%; }
    #mypage_navi { width: 20%; padding: 10px; float: left; }
    #mypage_content { width: 80%; padding: 30px; float: left; }

    /* MYPAGE 사이드메뉴바 */
    #mypage_navi>div {
        border: 2px solid #78C2AD;
        border-radius: 5px;
        padding: 15px;
    }
    /* 사이드바의 각 메뉴들 */
    #mypage_navi a {
        text-decoration: none;
        color: black;
    }
    #mypage_navi a:hover { color: #78C2AD; }

    /* 모든 table 공통 너비 */
    #mypage_content table { width: 100% }
    
    /* mypage_content h4, input. select 태그들 글자색 */
    #mypage_content h4, #mypage_content input, #mypage_content select { color: black; }

    /* 부트스트랩 페이징 */
    .pagination { justify-content: center; }

    /* ----- 관리자 공통 style ----- */
    /* 드롭다운 관련 */
    #mypage_navi .nav-link {
        padding: 0px 30px 16px 0px;
    }
    .dropdown-item:hover, .dropdown-item:focus {
        background-color: #78C2AD !important;
        color: white !important;
    }

    /* content 안에 소메뉴 */
    #admin_menu>p {
        font-size: large;
        font-weight: bold;
    }

    /* ----- 주문상세 style ----- */
    /* 텍스트 테이블들 table 정렬 */
    #order th, #delivery th, #price th { text-align: right; font-weight: bold; }
    #order tr, #delivery tr, #price tr { height: 35px; }

    /* modal 안의 테이블 */
    #change_delivery table tr { height: 50px; }

    /* 라디오 버튼의 라벨 */
    .form-check-label { margin: 0px 20px 0px 5px; }
    
    /* 배송지 변경 모달 */
    .modal-body>table { 
    	width: 80%!important;
    	margin: auto;
    }
    .modal-body>table td { width: 15%; }
    .modal-body>table th { width: 85%; }
	
</style>
</head>
<body>

    <div class="wrap">
        <div id="navigator2"><jsp:include page="../common/menubar.jsp" /></div>
        <div id="header"></div>
        <div id="content">
            <div id="content_1"></div>
            <div id="content_2">
                <div id="content_2_1">
                    <p>ADMIN PAGE</p>
                </div>
                <div id="content_2_2" style="padding-top:10px;">
                    
                    <div id="mypage_navi">
                        <div>
                            <p style="font-size: 20px;"><b style="font-size: 25px;">관리자</b> 님</p>
                            <br>
                            <ul class="nav nav-pills">
								<li class="nav-item"><a href="adminMypage.me" class="nav-link">회원 관리</a></li>
                                <li class="nav-item"><a href="ProductList.ad" class="nav-link">제품 관리</a></li>
                                <li class="nav-item"><a href="olist.ad" class="nav-link">주문 관리</a></li>
                                <li class="nav-item"><a href="qlist.ad" class="nav-link">문의 관리</a></li>
                                <li class="nav-item"><a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button">통계 관리</a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="salesStatistics.ad">매출 통계</a>
                                        <a class="dropdown-item" href="productSalesStatistics.ad">제품 통계</a>
										<a class="dropdown-item" href="productLikestatistics.ad">성별/연령 통계</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div id="mypage_content">
                        <h4>주문 관리</h4>
                        <hr>

                        <div id="admin_menu">
                            <p>[ 주문 정보 ]</p>
                        </div>
                        
                        <div>
                            <b>주문제품 정보</b>
                            <hr>
                            
                            <c:forEach var="p" items="${ plist }">
                            	<table>
	                                <tr height="40px">
	                                    <th rowspan="2" width="80px">
	                                        <img src="${ p.productImgPath }" width="100%">
	                                    </th>
	                                    <td rowspan="2" width="20px"></td>
	                                    <td style="vertical-align: bottom; font-size: small;">${ p.productExplain }엔</td>
	                                    <th rowspan="2" class="price" style="text-align: right;">
	                                    	<c:forEach var="c" items="${ clist }">
	                                    		<c:if test="${ p.productNo eq c.productNo }">
	                                    			<fmt:formatNumber value="${ c.cartAmount * p.productPrice }"/>
	                                    		</c:if>
	                                    	</c:forEach>
	                                    	 원
	                                    </th>
	                                </tr>
	                                <tr height="40px">
	                                    <td style="vertical-align: top;"><b>${ p.productName }</b> 30일분&nbsp;&nbsp;<b style="color: #78C2AD;">
	                                    	<c:forEach var="c" items="${ clist }">
	                                    		<c:if test="${ p.productNo eq c.productNo }">
		                                    		${ c.cartAmount }
		                                    	</c:if>
	                                    	</c:forEach>
	                                    </b> 개</td>
	                                </tr>
	                            </table>
	                            <br>
                            </c:forEach>

                        </div>
                        <br>

                        <div>
                            <b>주문 정보</b>
                            <c:if test="${ o.orderStatus ne 'C' and o.subsStatus ne 'C' and o.delivery eq 1 }">
                            	<button type="button" id="canOrderBtn" class="btn btn-outline-primary btn-sm" style="float: right;" onclick="cancelOrder('${ o.subsStatus }');">주문취소</button>
                            </c:if>
                            <hr>
                            
                            <script>
                            	function cancelOrder(st) {
                            		
                            		if(st == 'N') { // 일반결제
                            			
                            			if(confirm("해당 주문건을 취소하시겠습니까?")) {
                                			
                                			$.ajax({
                                				url: "payments/cancel",
                                				type: "post",
                                				data: {
                                					merchant_uid: "${ o.orderNo }"
                                				}
                                			}).done(data => {
                                				console.log(data);
                                				
                                				if(data.response.status == 'cancelled') {
                                					
                                					$.ajax({
                                						url: "delete.or",
                                						data: {
                                							orderNo: "${ o.orderNo }",
                                							orderDate: moment(data.response.cancelledAt).format('YYYYMMDDHHmmss'),
                                							subsStatus: 'N'
                                						},
                                						success: result => {
                                							
                                							if(result == "success") {
                                								alert("주문번호 : ${ o.orderNo }\n취소 처리되었습니다.");
                                    	    					location.href = 'olist.ad';
                                							}
                                						}
                                					});
                                				}
                                			});
                                		}
                            			
                            		} else { // 정기구독
                            			
                            			if(confirm("정기구독 중인 주문건입니다.\n주문 취소와 동시에 구독이 해지처리됩니다.")) {
                                			
                                			$.ajax({
                                				url: "subscribe/payments/unschedule",
                                				type: "post",
                                				data: {
                                					customer_uid: "${ o.customerUid }"
                                				}
                                			}).done(data => {
                                				console.log(data);
                                				
                            					if(data.code == 0) {
                            						
                                					$.ajax({
                                						url: "delete.or",
                                						type: "post",
                                						data: {
                                							orderNo: "${ o.orderNo }",
                                							orderDate: moment(data.response.cancelledAt).format('YYYYMMDDHHmmss'),
                                							customerUid: data.response[0].customerUid,
                                							subsStatus: 'Y'
                                						},
                                						success: result => {
                                							
                                							if(result == "success") {
                                								
                           										$.ajax({
                           						    				url: "payments/cancel",
                           						    				type: "post",
                           						    				data: {
                           						    					merchant_uid: "${ o.orderNo }"
                           						    				}
                           						    			}).done(data => {
                           						    				
                           						    				if(data.response.status == 'cancelled') {
                           						    					
                           						    					$.ajax({
                           						    						url: "delete.or",
                           						    						data: {
                           						    							orderNo: "${ o.orderNo }",
                           						    							orderDate: moment(data.response.cancelledAt).format('YYYYMMDDHHmmss'),
                           						    							subsStatus: 'N'
                           						    						},
                           						    						success: result => {
                           						    							
                           						    							if(result == "success") {
                           						    								alert("주문번호 : ${ o.orderNo }\n취소 처리되었습니다.\n정기구독이 해지되었습니다.");
                                                           	    					location.href = 'olist.ad';
                           						    							}
                           						    						}
                           						    					});
                           						    				}
                           						    			});
                                							}
                                						}
                                					});
                                				}
                                			});
                                		}
                            		}
                            	}
                            </script>

                            <table id="order">
                                <tr>
                                    <td width="30%">주문번호</td>
                                    <th width="70%">${ o.orderNo }</th>
                                </tr>
                                <tr>
                                    <td>주문일</td>
                                    <th>${ fn:substring(o.orderDate, 0, 11) }</th>
                                </tr>
                                <tr>
                                    <td>주문금액</td>
                                    <th id="total"></th>
                                </tr>
                                <tr>
                                    <td>주문상태</td>
                                    <th>
										<c:choose>
                                    		<c:when test="${ o.orderStatus eq 'Y' }">
                                    			결제완료
                                    		</c:when>
                                    		<c:when test="${ o.orderStatus eq 'C' }">
                                    			주문취소
                                    		</c:when>
                                    		<c:otherwise>
                                    			미결제
                                    		</c:otherwise>
                                    	</c:choose>
									</th>
                                </tr>
                            </table>
                        </div>
                        <br><br>
                        
                        <script>
                        	$(() => {
                        		
                        		var priceArr = $(".price").text().replace(/[\s,]/g,'').split('원');
                        		priceArr.pop();
                        		
                        		for(var i = 0; i < priceArr.length; i++) {
                        			priceArr[i] = parseInt(priceArr[i]);
                        		}
                        		
                        		var total = priceArr.reduce((a, b) => a + b);
                        		
                        		$("#total").text(total.toLocaleString('ko-KR') + ' 원');
                        	});
                        </script>

                        <div>
                            <b>배송지 정보</b>
                            <!-- 배송완료 전일 때만 보이도록 -->
                            <c:if test="${ o.orderStatus ne 'C' and o.delivery ne 3 }">
                            	<button type="button" id="upDeliveryBtn" class="btn btn-outline-primary btn-sm" style="float: right;" data-bs-toggle="modal" data-bs-target="#change_delivery">배송지 변경</button>
                            </c:if>
                            <hr>

                            <table id="delivery">
                                <tr>
                                    <td width="30%">받는분</td>
                                    <th width="70%">${ m.memberName }</th>
                                </tr>
                                <tr>
                                    <td>연락처</td>
                                    <th>${ fn:substring(m.phone, 0, 3) }-${ fn:substring(m.phone, 3, 7) }-${ fn:substring(m.phone, 7, 11) }</th>
                                </tr>	
                                <tr>
                                    <td>주소</td>
                                    <th id="upAddress">${ o.address }</th>
                                </tr>
                                <c:if test="${ o.orderStatus ne 'C' }">
	                                <tr>
	                                    <td>배송상태</td>
	                                    <th id="upDelivery">
	                                    	<c:choose>
	                                    		<c:when test="${ o.delivery eq 1 }">
	                                    			배송준비중
	                                    		</c:when>
	                                    		<c:when test="${ o.delivery eq 2 }">
	                                    			배송중
	                                    		</c:when>
	                                    		<c:otherwise>
	                                    			배송완료
	                                    		</c:otherwise>
	                                    	</c:choose>
	                                    </th>
	                                </tr>
                                </c:if>
                            </table>
                        </div>
                        <br><br>

                        <div class="modal" id="change_delivery">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" style="color: black; font-weight: bold;">배송지 변경</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true"></span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <table>
                                        	<tr>
												<td>받는분</td>
												<th><input type="text" class="form-control" value="${ m.memberName }" readonly style="width: 40%;"></th>
											</tr>
											<tr>
											    <td>연락처</td>
											    <th><input type="text" class="form-control" value="${ m.phone }" placeholder="-제외" readonly style="width: 40%;"></th>
											</tr>
											<tr>
											    <td>주소</td>
											    <th>
													<c:choose>
														<c:when test="${ o.delivery eq 1 }">
															<input type="text" class="form-control" id="newAddress" value="${ o.address }" required  style="display: inline-block; width: 85%;">
															<button type="button" class="btn btn-primary" onclick="getAddress();" style="font-size: small; box-sizing: border-box; height: 37px; vertical-align: top;">검색</button>
														</c:when>
														<c:otherwise>
															<input type="text" class="form-control" id="newAddress" value="${ o.address }" readonly>
														</c:otherwise>
													</c:choose>
											    </th>
											</tr>
                                            <tr>
                                                <td>배송상태</td>
                                                <th>
                                                    <input type="radio" class="form-check-input" id="delivery_status1" name="delivery_status" value="1" ${ o.delivery eq 1 ? "checked" : ""}> <label class="form-check-label" for="delivery_status1">배송전</label>
                                                    <input type="radio" class="form-check-input" id="delivery_status2" name="delivery_status" value="2" ${ o.delivery eq 2 ? "checked" : ""}> <label class="form-check-label" for="delivery_status2">배송중</label>
                                                    <input type="radio" class="form-check-input" id="delivery_status3" name="delivery_status" value="3" ${ o.delivery eq 3 ? "checked" : ""}> <label class="form-check-label" for="delivery_status3">배송완료</label>
                                                </th>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" onclick="changeDelivery();">저장</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
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
					                	
					                	var addressZip = data.zonecode;
					                	
					                	address = '(' + data.zonecode + ') ' + address;
					                	
					                	$("#newAddress").val(address);
					                }
					            }).open();
					        }
                        
                        	function changeDelivery() {
                        		
                        		var address = $("#newAddress").val();
                        		var delivery = $("input:radio[name='delivery_status']:checked").val();
                        		
                        		$.ajax({
                        			url: "update.or",
                        			type: "post",
                        			data: {
                        				orderNo: "${ o.orderNo }",
                        				delivery: delivery,
                        				address: address
                        			},
                        			success: result => {
                        				
                        				if(result == "success") {
                        					
                        					alert("배송정보가 수정되었습니다.");
                        					
                        					$("#upAddress").text(address);
                        					
                        					if(delivery == 1) {
                        						$("#upDelivery").text("배송준비중");
                        						$("#canOrderBtn").css("display", "inline-block");
                        					} else if(delivery == 2) {
                        						$("#upDelivery").text("배송중");
                        						$("#canOrderBtn").css("display", "none");
                        					} else {
                        						$("#upDelivery").text("배송완료");
                        						$(".btn-outline-primary").css("display", "none");
                        					}
                        					
                        					$(".btn-close").click();
                        				}
                        			},
                        			error: () => {
                        				console.log("update.or ajax 실패");
                        			}
                        		});
                        	}
                        </script>
                          
                        <div>
                        	<c:choose>
                        		<c:when test="${ o.orderStatus eq 'C' }">
		                            <b>환불 금액</b>
		                            <hr>
		
		                            <table id="price">
		                                <tr>
		                                    <td><b>최종 환불금액</b></td>
		                                    <th><fmt:formatNumber value="${ o.orderPrice }"/> 원</th>
		                                </tr>
		                                <tr>
		                                    <td><b>환불일시</b></td>
		                                    <th>${ o.orderDate }</th>
		                                </tr>
		                            </table>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<b>결제 금액</b>
		                            <hr>
		
		                            <table id="price">
		                                <tr>
		                                    <td><b>최종 결제금액</b></td>
		                                    <th><fmt:formatNumber value="${ o.orderPrice }"/> 원</th>
		                                </tr>
		                                <tr>
		                                    <td><b>결제일시</b></td>
		                                    <th>${ o.orderDate }</th>
		                                </tr>
		                            </table>
		                    	</c:otherwise>
                            </c:choose>
                        </div>
                        <br><br>
                        
                        <div align="center">
		                	<button type="button" class="btn btn-primary" onclick="location.href='olist.ad'">목록으로</button>
		                </div>
                        
                    </div>

                </div>
                <br clear="both">
                
				<div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>