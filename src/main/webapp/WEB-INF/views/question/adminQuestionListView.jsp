<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 문의 관리</title>
<style>

    div {
       /*  border : 1px solid #78C2AD; */
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
    #content { height: auto; display:flex; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 10%; }
    #content_2_2 { height:90%; color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 15px;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; padding-bottom: 200px;}
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* ----- 마이페이지 공통 style ----- */
    /* 영역 구분 */
    #content2_2>div { height: 100%; }
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


    /* ----- 문의조회 style ----- */
    /* 목록 테이블 */
    #qna_list {
        margin-top: 30px;
        color: black;
        text-align: center;
        /* 말줄임용 테이블 고정 */
        table-layout: fixed;
    }
    #qna_list>thead { background-color: #78c2ad36; }
    #qna_list>tbody td { vertical-align: middle; }

    #qna_list>tbody>tr:hover { cursor: pointer; }

    /* 제목이 길 때 말줄임과 1줄만 보이도록 */
    .qna_title {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

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
                                        
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div id="mypage_content">
                        <h4>문의 관리</h4>
                        <hr>

                        <div id="admin_menu">
                            <p>[ 문의 목록 ]</p>
                        </div>
                        
                        <table class="table table-hover" id="qna_list">
                            <thead>
                                <tr>
                                    <th width="10%">No</th>
                                    <th width="50%">제목</th>
                                    <th width="10%">작성자</th>
                                    <th width="20%">등록일</th>
                                    <th width="10%">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="q" items="${ list }">
	                           		<tr>
	                           			<td>${ q.questionNo }</td>
	                           			<td>${ q.questionTitle }</td>
                               			<td>${ q.memberNo }</td>
                               			<td>${ q.questionDate }</td>
	                           			<td>
	                           				<c:choose>
	                            				<c:when test="${ empty q.answer }">미답변</c:when>
	                            				<c:otherwise>답변완료</c:otherwise>
	                           				</c:choose>
	                           			</td>
	                           		</tr>
	                           	</c:forEach>
                            </tbody>
                        </table>
                        <br>

                        <script>
                            $(function() {
                                $("#qna_list>tbody>tr").click(function() {

                                	location.href = "detail.qu?qno=" + $(this).children().eq(0).text();
                                });
                            });
                        </script>

                        <div>
	                        <ul class="pagination">
	                        	<c:if test="${ not empty list }">
		                        	<c:choose>
				                		<c:when test="${ pi.currentPage eq 1 }">
				                			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
				                		</c:when>
				                		<c:otherwise>
				                			<li class="page-item"><a class="page-link" href="qlist.ad?cpage=${ pi.currentPage - 1 }">&laquo;</a></li>
				                		</c:otherwise>
				                	</c:choose>
				                	
				                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
			                    		<c:choose>
                                    		<c:when test="${ pi.currentPage eq p }">
                                    			<li class="page-item disabled"><a class="page-link" href="qlist.ad?cpage=${ p }">${ p }</a></li>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<li class="page-item"><a class="page-link" href="qlist.ad?cpage=${ p }">${ p }</a></li>
                                    		</c:otherwise>
                                    	</c:choose>
				                    </c:forEach>
		                        
		                            <c:choose>
				                		<c:when test="${ pi.currentPage eq pi.maxPage }">
				                			<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
				                		</c:when>
				                		<c:otherwise>
				                			<li class="page-item"><a class="page-link" href="qlist.ad?cpage=${ pi.currentPage + 1 }">&raquo;</a></li>
				                		</c:otherwise>
				                	</c:choose>
	                            </c:if>
	                        </ul>
	                    </div>
                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>