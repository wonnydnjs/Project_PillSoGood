<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 내 관심 제품</title>
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

    /* ----- 관심제품 style ----- */
    #product>div { 
        width: 33.3%; 
        height: 200px; 
        float: left;
        padding: 15px;
    }

    #product>div>div { 
        width: 100%;
        height: 100%;
        float: left; 
        border-radius: 15px;
    }

    #product>div>div>div { width: 100%; float: left; }

    #productT { height: 65%; }
    #productP { height: 35%; }

    #productT>div { height: 100%; float: left; }
    #productTT { width: 60%; }
    #productPP { width: 40%; }

    #productPP>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
    }

    #productTT>div { width: 100%; height: 33.3%; float: left; }
    
    #productTT p { margin: 0px; margin-left: 20px; color: black; }
    #productTT_1>p { font-size: 13.5px; line-height: 55px; }
    #productTT_3>p { font-size: 15px; line-height: 45px; }
    #productTT_2>p { font-size: 20px; line-height: 50px; font-weight: bold; }

    #productP>p {
        font-size: 20px;
        font-weight: bold;
        color: black;
        margin-left: 20px;
        line-height: 40px;
    }

    /* 배경색 스타일 미리 지정 */
    .prod { background-color: #fef7f8; }
    
    .prodback0 { background-color: #fef7f8; }
    .prodback1 { background-color: #f9faf0; }
    .prodback2 { background-color: #faf4f1; }
    .prodback3 { background-color: #fef6ec; }
    .prodback4 { background-color: #edf7fd; }
    .prodback5 { background-color: #fef5f4; }
    .prodback6 { background-color: #fbf7fd; }
    .prodback7 { background-color: #e9f7f5; }
    .prodback8 { background-color: #f9f9f9; }

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
                            <p style="font-size: 20px; color: black;"><b style="font-size: 25px;">${loginUser.memberName}</b> 님</p>
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
                        <h4>내 관심 제품</h4>
                        <hr>
                        
                        <c:choose>
                        	<c:when test="${myList.size()>=1}">
		                        <div id="product" style="height: 400px;">
			                        <c:forEach var="i" begin="0" end="${ myList.size()-1}">
										<div id="product_1">
			                                <div id="product_1_1" class="prod" style="cursor:pointer;">
			                                    <div id="productT">
			                                        <div id="productTT">
			                                        	<input type="hidden" value="${ myList[i].productNo }">
			                                            <div id="productTT_1"><p>${ myList[i].productExplain }엔</p></div>
			                                            <div id="productTT_2"><p>${ myList[i].productName }</p></div>
			                                            <div id="productTT_3"><p>30일분</p></div>
			                                        </div>
			                                        <div id="productPP"><img src="${ myList[i].productImgPath }"></div>
			                                    </div>
			                                    <div id="productP">
			                                        <p><fmt:formatNumber value="${ myList[i].productPrice }" pattern="#,###.##"/>원</p>
			                                    </div>
			                                </div>
			                            </div>
									</c:forEach>
								</div>
							</c:when>
							<c:when test="${myList.size()==0}">
								<div align="center">
									<br>
										<p style="color: black;">내 관심 제품이 없습니다.</p>
									<br>
								</div>
							</c:when>
						</c:choose>

                        <div style="height: 10px;"></div>
                        <!-- 페이지 -->
                        <div id="noticePagination">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <c:choose>
                                        <c:when test="${ pi.currentPage eq 1 }">
                                            <li class="page-item disabled" ><a class="page-link">&lt;</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="myPage.prod?cpage=${ pi.currentPage - 1 }">&lt;</a></li>	
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                                        <c:choose>
                                            <c:when test="${ p eq pi.currentPage }">
                                                <li class="page-item disabled"><a class="page-link"  href="myPage.prod?cpage=${ p }">${ p }</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item"><a class="page-link" href="myPage.prod?cpage=${ p }">${ p }</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${ (pi.currentPage eq pi.maxPage) or (pi.maxPage eq 0) }">
                                            <li class="page-item disabled" ><a class="page-link">&gt;</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="myPage.prod?cpage=${ pi.currentPage + 1 }">&gt;</a></li>	
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <div style="height: 150px;"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        $(function() {
            $(".prod").click(function() { // 제품 상세 조회
                
                location.href = "detail.pr?pno=" + $(this).children().eq(0).children().eq(0).children().eq(0).val();
            });

            var $prods = $(".prod");

            $.each($prods, function(index, prod) { // 제품 배경색

                let indexNum = index % 9;

                $(prod).addClass("prodback" + indexNum);
            });
        });	
    </script>

</body>
</html>