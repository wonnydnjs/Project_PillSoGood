<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 주문 조회</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { height: auto; display: flex; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 115px; }
    #content_2_2 { height: 1100px; color: black; }

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

    /* ----- 주문조회 style ----- */
    /* 기간별 조회 button, input 들 */
    #search_date {
        height: 38px;
        width: 100%;
    }

    /* 기간 선택 button */
    #search_date button {
        margin: 0px 3px;
        box-sizing: border-box;
    }

    /* 날짜 선택 input */
    #search_date>input[type=date] {
        height: 100%;
        border: none;
        text-align: center;
        padding: 0px 5px;
        margin: 0px 10px;
    }

    /* button 들이 div 테두리를 밑으로 벗어나서 맞춤 */
    #search_date>button, #search_date>input[type=button] { vertical-align: top; }
	
	#all {
		margin: 0px 3px;
		box-sizing: border-box;
		color: #78C2AD!important;
	}

	#all:hover {
		color: white;
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
                        <h4>주문 조회</h4>
                        <hr>
                        <div id="search_date" align="center">
                            <button type="button" class="btn btn-outline-dark" id="m3">3개월</button>
                            <button type="button" class="btn btn-outline-dark" id="m6">6개월</button>
                            <button type="button" class="btn btn-outline-dark" id="m12">12개월</button>
                            <input type="button" class="btn btn-outline-primary" id="all" value="전체" onclick="location.href='myPage.or'">
							
                            <input type="date" id="startDate"> - 
                            <input type="date" id="endDate">
                            
                            <input type="button" class="btn btn-primary" id="searchBtn" style="width: 90px; margin-left: 10px; color: white;" value="검색">
                        </div>
                        <hr>
                        <br>
                        
                        <c:if test="${ not empty s and s ne '3' and s ne '6' and s ne '12' }">
                      		<script>
                      			$(() => {
                      				$("#startDate").val(new Date("${ s }").toISOString().substring(0, 10));
                      				$("#endDate").val(new Date("${ e }").toISOString().substring(0, 10));
                      			});
                      		</script>
                      	</c:if>
                        
                        <script>
		                	$(() => {
		                		
		                		$("#search_date>button").on("click", function() {
		                            
		                			// $(this).attr("class", "btn btn-outline-primary");
		                            // $(this).siblings("button").attr("class", "btn btn-outline-dark");
		                        	
		                       		location.href = 'search.or?cpage=1&s=' + $(this).attr("id").substring(1) + '&e=0';
		                		});
		                		
		                		$("#searchBtn").on("click", function() {
		                			
		                			var start = $("#startDate").val();
		                			var end = $("#endDate").val();
		                			
		                			// validate
		                			var startDate = new Date(start);
		                			startDate.setHours(0, 0, 0, 0);
		                			var endDate = new Date(end);
		                			endDate.setHours(0, 0, 0, 0);
		                			
		                			if(start == "" || end == "") {
		                				alert("날짜를 입력해주세요");
		                				return false;
		                			} else {
		                				if(endDate < startDate) {
		                					alert("조회하신 기간이 올바르지 않습니다.");
		                					return false;
		                				} else {
		                					location.href = 'search.or?cpage=1&s=' + start + '&e=' + end;
		                				}
		                			}
		                		});
		                	});
		                </script>

                        <div id="order_list">
							
							<c:choose>
								<c:when test="${ empty olist }">
									<table>
										<tr height="100px">
											<th style="text-align: center;">주문내역이 없습니다.</th>
										</tr>
									</table>
								</c:when>
								<c:otherwise>
								
									<c:forEach var="o" items="${ olist }" varStatus="status">
			                            <table class="olist">
			                                <tr>
			                                    <td>
			                                    	<c:choose>
			                                    		<c:when test="${ o.orderStatus eq 'Y' }">
			                                    			<button class="btn btn-primary btn-sm" disabled>결제완료</button>
			                                    		</c:when>
			                                    		<c:when test="${ o.orderStatus eq 'C' }">
			                                    			<button class="btn btn-dark btn-sm" disabled>주문취소</button>
			                                    		</c:when>
			                                    		<c:otherwise>
			                                    			<button class="btn btn-dark btn-sm" disabled>미결제</button>
			                                    		</c:otherwise>
			                                    	</c:choose>
			                                        &nbsp;${ o.orderDate }
			                                    </td>
			                                    <th style="text-align: right;"><a href="detail.or?ono=${ o.orderNo }" style="text-decoration: none; color: #78C2AD; font-size: 20px;">&gt;</a></th>
			                                </tr>
			                                <tr height="40px">
			                                    <th width="80%">
			                                    	<c:choose>
			                                    		<c:when test="${ o.subsStatus eq 'N' }">
			                                    			일반구매
			                                    		</c:when>
			                                    		<c:otherwise>
			                                    			정기구독 <b style="color: #78C2AD;">${ o.subsCount } 회차</b>
			                                    		</c:otherwise>
			                                    	</c:choose>
			                                    </th>
			                                    <th rowspan="2" style="text-align: right;"><fmt:formatNumber value="${ o.orderPrice }"/> 원</th>
			                                </tr>
			                                <tr>
			                                    <td style="font-size: small;">${ o.productNames }</td>
			                                </tr>
			                            </table>
			                            <br><hr>
		                            </c:forEach>
		                            
								</c:otherwise>
							</c:choose>
                            
                        </div>
						
						<c:if test="${ not empty olist }">
	                        <div>
	                            <ul class="pagination pagination-sm">
	                            	<c:choose>
				                		<c:when test="${ pi.currentPage eq 1 }">
				                			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
				                		</c:when>
				                		<c:otherwise>
			                                <c:choose>
				                				<c:when test="${ empty s or empty e }">
				                					<li class="page-item"><a class="page-link" href="myPage.or?cpage=${ pi.currentPage - 1 }">&laquo;</a></li>
				                				</c:when>
				                				<c:otherwise>
				                					<li class="page-item"><a class="page-link" href="search.or?cpage=${ pi.currentPage - 1 }&s=${ s }&e=${ e }">&laquo;</a></li>
				                				</c:otherwise>
				                			</c:choose>
				                		</c:otherwise>
				                	</c:choose>
				                	
				                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				                    	<c:choose>
				               				<c:when test="${ pi.currentPage eq p }">
					               				<c:choose>
						               				<c:when test="${ empty s or empty e }">
						               					<li class="page-item disabled"><a class="page-link" href="myPage.or?cpage=${ p }">${ p }</a></li>
						               				</c:when>
						               				<c:otherwise>
						               					<li class="page-item disabled"><a class="page-link" href="search.or?cpage=${ p }&s=${ s }&e=${ e }">${ p }</a></li>
						               				</c:otherwise>
						               			</c:choose>
											</c:when>
				               				<c:otherwise>
				               					<c:choose>
						               				<c:when test="${ empty s or empty e }">
						               					<li class="page-item"><a class="page-link" href="myPage.or?cpage=${ p }">${ p }</a></li>
						               				</c:when>
						               				<c:otherwise>
						               					<li class="page-item"><a class="page-link" href="search.or?cpage=${ p }&s=${ s }&e=${ e }">${ p }</a></li>
						               				</c:otherwise>
						               			</c:choose>
				               				</c:otherwise>
				               			</c:choose>
				                    </c:forEach>
	                                
	                                <c:choose>
				                		<c:when test="${ pi.currentPage eq pi.maxPage }">
				                			<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
				                		</c:when>
				                		<c:otherwise>
			                                <c:choose>
				                				<c:when test="${ empty s or empty e }">
				                					<li class="page-item"><a class="page-link" href="myPage.or?cpage=${ pi.currentPage + 1 }">&raquo;</a></li>
				                				</c:when>
				                				<c:otherwise>
				                					<li class="page-item"><a class="page-link" href="search.or?cpage=${ pi.currentPage + 1 }&s=${ s }&e=${ e }">&raquo;</a></li>
				                				</c:otherwise>
				                			</c:choose>
				                		</c:otherwise>
				                	</c:choose>
	                            </ul>
	                        </div>
                        </c:if>

                    </div>
                </div>
				<div style="height: 150px;"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

</body>
</html>