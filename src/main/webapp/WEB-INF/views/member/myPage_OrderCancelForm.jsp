<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% int delivery = (int)request.getAttribute("delivery"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 주문 취소</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: inherit;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { display: flex; height: auto; }
    #content_2>div { width: 100%; float: left; }
    #content_2_1 { height: 115px; }
    #content_2_2 { height: auto; color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* ----- 마이페이지 공통 style ----- */
    /* 영역 구분 */
    #content_2_2>div { height: 100%; float: left; }
    #mypage_navi { width: 20%; padding: 10px; }
    #mypage_content { width: 80%; padding: 30px; }

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

    /* ----- 주문취소 style ----- */
    /* 텍스트 테이블들 table 정렬 */
    #refund th { text-align: right; font-weight: bold; }
    #refund tr { height: 35px; }

    /* 취소 유의사항 div */
    #refund_note {
        width: 70%;
        height: 80px;
        background-color: rgba(209, 209, 209, 0.603);
        margin: auto;
    }
	
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
                    <p>MY PAGE</p>
                </div>
                <div id="content_2_2" style="padding-top:10px;">
                    
                    <div id="mypage_navi">
                        <div>
                            <p style="font-size: 20px;"><b style="font-size: 25px;">${ loginUser.memberName }</b> 님</p>
                            <br>
                            <p><a href="myPage.or">주문 조회</a></p>
                            <p><a href="myPage.subs">정기구독 관리</a></p>
                            <p><a href="myPage.info">내 정보 관리</a></p>
                            <p><a href="myPage.poll">건강설문 관리</a></p>
                            <p><a href="myPage.prod">내 관심 제품</a></p>
                            <p><a href="myPage.re">내 후기 조회</a></p>
                            <p><a href="myPage.ev">찜한 이벤트</a></p>
                        </div>
                    </div>

                    <div id="mypage_content">
                        <h4>주문 취소</h4>
                        <hr>
                        <div>
                            <b>취소제품 정보</b>
                            <p style="float: right;">
                            	<c:choose>
                            		<c:when test="${ st eq 'Y' }">
                            			정기구독
                            		</c:when>
                            		<c:otherwise>
                            			일반구매
                            		</c:otherwise>
                            	</c:choose>
                            </p>
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
						
						<c:choose>
                       		<c:when test="${ st eq 'N' }">
		                        <div>
		                            <b>환불 정보</b>
		                            <hr>
		
		                            <table id="refund">
		                                <tr>
		                                    <td width="30%">환불 예정금액</td>
		                                    <th width="70%"><fmt:formatNumber value="${ o.orderPrice }"/> 원</th>
		                                </tr>
		                            </table>
		                        </div>
		                        <br><br>
		
		                        <div id="refund_note">
		                            <div style="font-size: small; padding-left: 20px;">
		                                <br>
		                                - 부분 취소는 불가능합니다. <br>
		                                - 상품이 출고된 이후 취소가 불가한 점 양해 부탁드립니다.
		                                <br>
		                            </div>
		                        </div>
		                        <br><br>

		                        <div align="center">
		                        	<button type="button" class="btn btn-primary" style="width: 20%; height: 45px;" onclick="refund();">주문 취소</button>
		                        	<button type="button" class="btn btn-secondary" style="width: 20%; height: 45px;" onclick="history.back();">뒤로가기</button>
		                        </div>
							</c:when>
		                    <c:otherwise>
		                        <div id="refund_note">
		                            <div style="font-size: small; padding-left: 20px;">
		                                <br>
		                                - PG사 규정상 결제 예정 당일에는 해지가 불가합니다.<br>
		                                - 정기구독 해지시 다음 결제 예정일부터 결제가 진행되지 않습니다.
		                                <br>
		                            </div>
		                        </div>
		                        <br><br>

		                        <div align="center">
		                        	<button type="button" class="btn btn-primary" style="width: 20%; height: 45px;" data-bs-toggle="modal" data-bs-target="#unsubscribeModal">구독 해지</button>
		                        	<button type="button" class="btn btn-secondary" style="width: 20%; height: 45px;" onclick="history.back();">뒤로가기</button>
		                        </div>
		                        
		                        <div class="modal" tabindex="-1" id="unsubscribeModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title"><b>구독 해지</b></h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body" align="center">
												<b>${ loginUser.memberName }</b> 고객님!<br>
												정기구독 서비스 유지시 아래와 같은 혜택을 누리실 수 있습니다.<br><br>
												
												<div style="border: 3px double #78C2AD; width: 50%; padding: 5px; border-radius: 5px;">
												- 10% 할인<br>
												- 배송비 무료
												</div>
												<br>
												정말 정기구독 서비스를 해지하시겠습니까?
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
												<button type="button" class="btn btn-primary" onclick="unsubscribe();">해지하기</button>
											</div>
										</div>
									</div>
								</div>
		                    </c:otherwise>
                       	</c:choose>
                    </div>

                </div>
                <div style="height: 150px;"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
    <script>
    	function refund() {
    		
    		if(confirm("주문을 취소하시겠습니까?")) {
    			
    			$.ajax({
    				url: "payments/cancel",
    				type: "post",
    				data: {
    					merchant_uid: "${ o.orderNo }"
    				}
    			}).done(data => {
    				// console.log(data);
    				
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
    								alert("주문번호 : ${ o.orderNo }\n주문이 취소되었습니다.\n환불은 즉시 진행되며, PG사에 따라 시간이 소요될 수도 있습니다.");
        	    					location.href = 'myPage.or';
    							}
    	    					
    						},
    						error: () => {
    							console.log("delete.or ajax 실패");
    						}
    					});
    				}
    			});
    		}
    	}
    	
    	function unsubscribe() {
    		
    		if(confirm("구독을 해지하시면 더이상 정기구독 혜택을 받으실 수 없습니다.\n정말 정기구독 서비스를 해지하시겠어요?")) {
    			
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
    								
    								alert("정기구독이 해지되었습니다.\n다음 결제일부턴 결제가 진행되지 않습니다.");
    								
    								if(<%= delivery %> == 1) {
    									if(confirm("해지하시는 구독 서비스의 마지막 회차 상품이 발송 전입니다.\n취소하시겠습니까?")) {
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
    						    								alert("주문번호 : ${ o.orderNo }\n주문이 취소되었습니다.\n환불은 즉시 진행되며, PG사에 따라 시간이 소요될 수도 있습니다.");
    						        	    					location.href = 'myPage.or';
    						    							}
    						    						}
    						    						
    						    					});
    						    				}
    						    			});
    									}
    								}
    							}
    	    					
    						},
    						error: () => {
    							console.log("delete.or ajax 실패");
    						}
    					});
    				}
    			});
    		}
    	}
    </script>

</body>
</html>