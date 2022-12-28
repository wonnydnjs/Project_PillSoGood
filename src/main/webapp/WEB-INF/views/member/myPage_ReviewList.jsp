<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 내 후기 조회</title>
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

    /* ----- 후기조회 style ----- */
    .myPageReview {
        width: 840px;
        height: 70px;
        cursor: pointer;
    }
    .myPageReview>div {
        float: left;
        height: 100%;;
    }
    .myPageImg {
        width: 11%;
    }
    .myPageContent {
        width: 82%;
    }
    .myPageContent>div {
        height: 50%;
    }
    .myPageContent1>div {
        float: left;
        height: 100%;
    }
    .myPageBtn {
        width: 7%;
    }
    
    img {
    	height: 100%;
        width: 100%;
        object-fit: contain;
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
                        <h4>내 후기 조회</h4>
                        <hr>
                        
                        <c:choose>
                        	<c:when test="${myList.size()>=1}">
								<c:forEach var="i" begin="0" end="${ myList.size()-1}">
									<div class="myPageReview" style="border-bottom: 1px solid lightgray;">
		                                <div class="myPageImg" align="center" style="width:70px; height: 70px;">
		                                    <div>
		                                        <c:forEach var="f" begin="0" end="0" items="${myList[i].flist}">
		                                            <img src="${ f.filePath }${ f.changeName }" width="70px;" height="70px;" >
		                                        </c:forEach>
		                                    </div>
		                                </div>
		                                <div class="myPageContent" style="padding: 5px;">
		                                    <div class="myPageContent1">
		                                        <div style="font-size: 20px; width: 85%;"><p>${ myList[i].reviewTitle }</p></div>
		                                        <div style="width: 15%;"><p>${ myList[i].reviewDate }</p></div>
		                                    </div>
		                                    <div class="myPageContent2" style="font-size: 15px;"><p style="margin: 0px; padding: 1px;">${fn:substring(myList[i].reviewContent, 0, 10)}...</p></div>
		                                </div>
		                                <div class="myPageBtn" style="padding: 5px;">
		                                    <div>
		                                        <div><input type="hidden" value="${ myList[i].reviewNo }"></div>
		                                        <div align="right"><button type="submit" class="btn btn-secondary btn-delete btn-sm" onclick="location.href='myDelete.re?rno=${ myList[i].reviewNo }'">삭제</button></div>
		                                    </div>
		                                </div>
			                        </div>
								</c:forEach>
							</c:when>
							<c:when test="${myList.size()==0}">
								<div align="center">
									<br>
									    <p>내 후기가 없습니다.</p>
									<br>
								</div>
							</c:when>
						</c:choose>
                        
                        <div style="height: 10px;"></div>
                        <!-- 페이지 -->
                        <div id="noticePagination">
	                        <nav aria-label="Page navigation">
	                            <ul class="pagination  justify-content-center">
	                            	<c:choose>
				                		<c:when test="${ pi.currentPage eq 1 }">
				                			<li class="page-item disabled" ><a class="page-link">&lt;</a></li>
				                		</c:when>
				                		<c:otherwise>
				                			<li class="page-item"><a class="page-link" href="myPage.re?cpage=${ pi.currentPage - 1 }">&lt;</a></li>	
				                		</c:otherwise>
				                	</c:choose>
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:choose>
											<c:when test="${ p eq pi.currentPage }">
												<li class="page-item disabled"><a class="page-link"  href="myPage.re?cpage=${ p }">${ p }</a></li>
											</c:when>
										
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="myPage.re?cpage=${ p }">${ p }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
				                    <c:choose>
				                		<c:when test="${ (pi.currentPage eq pi.maxPage) or (pi.maxPage eq 0) }">
				                			<li class="page-item disabled" ><a class="page-link">&gt;</a></li>
				                		</c:when>
				                		<c:otherwise>
				                			<li class="page-item"><a class="page-link" href="myPage.re?cpage=${ pi.currentPage + 1 }">&gt;</a></li>	
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
            $(".myPageImg").click(function() { // 리뷰 상세 조회
                var rno = $(this).next('div').next('div').children('div').eq(0).children('div').eq(0).children('input').eq(0).val();
                location.href = "detail.re?rno=" + rno;
            });
        });
        $(function() {
            $(".myPageContent").click(function() { // 리뷰 상세 조회
                var rno = $(this).next('div').children('div').eq(0).children('div').eq(0).children('input').eq(0).val();
                location.href = "detail.re?rno=" + rno;
            });
        });
        
    </script>  	

</body>
</html>