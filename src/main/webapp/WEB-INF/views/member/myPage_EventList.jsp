<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 찜한 이벤트</title>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        /* 전체 길이 개별 커스텀 */
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    /* 내용 길이 개별 wrap - 350px */
    #content { height: auto; display: flex; }
    #content_2>div { width: 100%; float: left; }
    #content_2_1 { height: 115px; }
    #content_2_2 { height: 550px; color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
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
    
    .eventT {
        float: left;
        width: 50%;
    }

    .evtTitle {
        font-weight: bold;
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
                        <h4>찜한 이벤트</h4>
                        <hr>
                        
                        <c:choose>
	                        <c:when test="${myList.size()>=1}">
                                <div style="height: 400px;">
                                    <c:forEach var="e" begin="0" end="${ myList.size()-1}">
                                        <div id="eventT" class="eventT" align="center" style="cursor: pointer;">
                                            <div>
                                                <div><input type="hidden" value="${ myList[e].evtNo }"></div>
                                                <div><img src="${ myList[e].evtImgName }" width="120" height="120" ></div>
                                            </div>
                                            <div>
                                                <div class="evtTitle" width="600px" style="font-size: 20px; padding-top: 20px; color: black;">${ myList[e].evtTitle }</div>
                                                <div style="height: 10px;"></div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
							</c:when>
							<c:when test="${myList.size()==0}">
								<div align="center">
									<br>
									    <p>찜한 이벤트가 없습니다.</p>
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
                                            <li class="page-item disabled"><a class="page-link">&lt;</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="myPage.ev?cpage=${ pi.currentPage - 1 }">&lt;</a></li>	
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                                        <c:choose>
                                            <c:when test="${ p eq pi.currentPage }">
                                                <li class="page-item disabled"><a class="page-link"  href="myPage.ev?cpage=${ p }">${ p }</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item"><a class="page-link" href="myPage.ev?cpage=${ p }">${ p }</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${ (pi.currentPage eq pi.maxPage) or (pi.maxPage eq 0) }">
                                            <li class="page-item disabled" ><a class="page-link">&gt;</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="myPage.ev?cpage=${ pi.currentPage + 1 }">&gt;</a></li>	
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
		
        // 이벤트 상세 조회
        $(function() {
            $(".eventT").click(function() {
                var eno = $(this).children('div').eq(0).children('div').eq(0).children('input').eq(0).val();
                location.href = "detail.ev?eno=" + eno;
            });
        });
        
    </script>

</body>
</html>