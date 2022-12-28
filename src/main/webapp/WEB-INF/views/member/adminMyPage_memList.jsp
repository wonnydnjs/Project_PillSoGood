<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 회원 관리</title>
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

    /* ----- 회원조회 style ----- */
    /* 검색창 정렬 */
    #admin_menu {
        height: 45px;
        position: relative;
    }
    #search_mem {
        float: right;
        width: 300px;
        position: absolute;
        right: 0;
        bottom: 0;
    }

    /* 검색창, 버튼 글씨 크기 */
    #search_mem>input, #search_mem>button { font-size: 15px; }

    /* 목록 테이블 */
    #member_list {
        margin-top: 30px;
        color: black;
        text-align: center;
    }
    #member_list>thead { background-color: #78c2ad36; }
    #member_list>tbody td { vertical-align: middle; }

    #member_list>tbody>tr:hover { cursor: pointer; }

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
                        <h4>회원 관리</h4>
                        <hr>

                        <div id="admin_menu">
                            <p>[ 회원 목록 ]</p>
                            <form class="input-group" id="search_mem" action="adMyPageSearch.me" method="post">
                                <input type="text" class="form-control" name="keyword" placeholder="아이디 / 이름 / 이메일 검색">
                                <button id="searchBtn" class="btn btn-primary" type="submit">검색</button>
                            </form>
                        </div>
                        
                        <table class="table table-hover" id="member_list">
                            <thead>
                                <tr>
                                    <th width="10%">No</th>
                                    <th width="15%">아이디</th>
                                    <th width="15%">이름</th>
                                    <th width="30%">이메일</th>
                                    <th width="20%">가입일자</th>
                                    <th width="10%">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:choose>
                            		<c:when test="${not empty searchList}">
		                            	<c:forEach var="s" items="${ searchList }">
			                                <tr>
			                                    <td>${ s.memberNo }</td>
			                                    <td>${ s.memberId }</td>
			                                    <td>${ s.memberName }</td>
			                                    <td>${ s.email }</td>
			                                    <td>${ s.memberEnrollDate }</td>
			                                    <td>${ s.memberStatus }</td>
			                                </tr>
		                                </c:forEach>
		                    		</c:when>
		                    		<c:when test="${empty searchList and not empty list }">
		                    			<c:forEach var="m" items="${ list }">
			                                <tr>
			                                    <td>${ m.memberNo }</td>
			                                    <td>${ m.memberId }</td>
			                                    <td>${ m.memberName }</td>
			                                    <td>${ m.email }</td>
			                                    <td>${ m.memberEnrollDate }</td>
			                                    <td>${ m.memberStatus }</td>
			                                </tr>
		                                </c:forEach>
		                    		</c:when>
		                    	</c:choose>
                            </tbody>
                        </table>
                        <br>

                        <script>
                            $(function() {
                                $("#member_list>tbody>tr").click(function() {
									
                                	location.href="adMyPageDetail.me?mno=" + $(this).children().eq(0).text();
                                    // 클릭시 상세조회로 이동
                                });
                            });
                        </script>
						<c:choose>
							<c:when test="${not empty searchList}">
								<div>
		                            <ul class="pagination">
		                                <c:choose> 
				                    		<c:when test="${ pi.currentPage eq 1 }">
				                    			<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<li class="page-item"><a class="page-link" href="adMyPageSearch.me?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
				                    		</c:otherwise>
			                    		</c:choose>
			                    	
				                    	<c:forEach var="m" begin="${ pi.startPage }" end="${ pi.endPage }">
				                    		<li class="page-item"><a class="page-link" href="adMyPageSearch.me?cpage=${ m }">${ m }</a></li>
				                    	</c:forEach>
			                    	
				                    	<c:choose>
				                    		<c:when test="${pi.currentPage eq pi.maxPage }">
				                    			<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<li class="page-item"><a class="page-link" href="adMyPageSearch.me?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
				                    		</c:otherwise>
				                    	</c:choose>
		                            </ul>
		                        </div>
		                    </c:when>
							<c:when test="${empty searchList and not empty list }">	
		                        <div>
		                            <ul class="pagination">
		                                <c:choose> 
				                    		<c:when test="${ pi.currentPage eq 1 }">
				                    			<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<li class="page-item"><a class="page-link" href="adminMypage.me?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
				                    		</c:otherwise>
			                    		</c:choose>
			                    	
				                    	<c:forEach var="m" begin="${ pi.startPage }" end="${ pi.endPage }">
					                		<c:choose>
	                                    		<c:when test="${ pi.currentPage eq m }">
	                                    			<li class="page-item disabled"><a class="page-link" href="adminMypage.me?cpage=${ m }">${ m }</a></li>
	                                    		</c:when>
	                                    		<c:otherwise>
	                                    			<li class="page-item"><a class="page-link" href="adminMypage.me?cpage=${ m }">${ m }</a></li>
	                                    		</c:otherwise>
	                                    	</c:choose>
					                    </c:forEach>
			                    	
				                    	<c:choose>
				                    		<c:when test="${pi.currentPage eq pi.maxPage }">
				                    			<li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<li class="page-item"><a class="page-link" href="adminMypage.me?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
				                    		</c:otherwise>
				                    	</c:choose>
		                            </ul>
		                        </div>
							</c:when>
						</c:choose>
                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>
       
    </div>
    
     <div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>