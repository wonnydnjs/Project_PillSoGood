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
<title>MY PAGE 주문 조회</title>
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

    /* ----- 주문상세 style ----- */
    /* 텍스트 테이블들 table 정렬 */
    #order th, #delivery th, #price th { text-align: right; font-weight: bold; }
    #order tr, #delivery tr, #price tr { height: 35px; }
	
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
                        <h4>주문 조회</h4>
                        <hr>
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
                            <c:if test="${ o.orderStatus ne 'C' and o.delivery eq 1 }">
                            	<c:choose>
                            		<c:when test="${ o.subsStatus eq 'N' }">
                            			<button type="button" class="btn btn-outline-primary btn-sm" style="float: right;" onclick="cancelOrder();">주문취소</button>
                            		</c:when>
                            		<c:when test="${ o.subsStatus eq 'Y' }">
                            			<p style="float: right; font-size: small; color: #78C2AD; margin-bottom: 0px;">* 구독해지는 구독정보에서 가능합니다.</p>
                            		</c:when>
                            	</c:choose>
                            </c:if>
                            <hr>
                            
                            <script>
                            	function cancelOrder() {
                            		
                            		$.ajax({
                            			url: "checkdel.or",
                            			data: { orderNo: "${ o.orderNo }" },
                            			success: result => {
                            				
                            				if('${ o.orderStatus }' != 'C' && result == 1) {
                                    			location.href = 'cancel.or?ono=${ o.orderNo }&st=N';
                                    		} else {
                                    			alert("배송이 시작된 주문은 취소할 수 없습니다.");
                                    			location.reload();
                                    		}
                            			}
                            		});
                            		
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
                            <hr>

                            <table id="delivery">
                                <tr>
                                    <td width="30%">받는분</td>
                                    <th width="70%">${ loginUser.memberName }</th>
                                </tr>
                                <tr>
                                    <td>연락처</td>
                                    <th>${ fn:substring(loginUser.phone, 0, 3) }-${ fn:substring(loginUser.phone, 3, 7) }-${ fn:substring(loginUser.phone, 7, 11) }</th>
                                </tr>	
                                <tr>
                                    <td>주소</td>
                                    <th>${ o.address }</th>
                                </tr>
                                <c:if test="${ o.orderStatus ne 'C' }">
	                                <tr>
	                                    <td>배송상태</td>
	                                    <th>
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
		                                <tr>
		                                	<td><b>취소영수증</b></td>
		                                	<th><a href="${ o.orderReceipt }" target="_blank">영수증 조회</a></th>
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
		                                <tr>
		                                	<td><b>결제영수증</b></td>
		                                	<th><a href="${ o.orderReceipt }" target="_blank">영수증 조회</a></th>
		                                </tr>
		                            </table>
		                    	</c:otherwise>
                            </c:choose>
                        </div>
                        <br><br>
                        
                        <div align="center">
		                	<button type="button" class="btn btn-primary" onclick="location.href='myPage.or'">목록으로</button>
		                	
		                	<c:if test="${ o.subsStatus ne 'N' }">
		                		<button type="button" class="btn btn-secondary" onclick="location.href='detail.subs?ono=${ o.orderNo }'">구독정보</button>
		                	</c:if>
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