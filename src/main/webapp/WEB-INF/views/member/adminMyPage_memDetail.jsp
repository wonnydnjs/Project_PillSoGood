<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">

<title>ADMIN PAGE 회원 상세조회</title>
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

     /* ----- 회원상세 style ----- */
    /* 목록 테이블 */
    #member_info { margin-top: 20px; }
    #member_info>tbody>tr { height: 50px; }

    /* 처리 버튼 */
    #process_btn>button {
        width: 110px;
        height: 40px;
        margin: 0px 5px;
    }
</style>

<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
                            <p>[ 회원 정보 ]</p>
                        </div>
                        
                        <table id="member_info">
                            <tr>
                                <th width="25%">회원번호</th>
                                <td width="75%">${ m.memberNo }</td>
                            </tr>

                            <tr>
                                <th>아이디</th>
                                <td>${ m.memberId }</td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td>${ m.memberName }</td>
                            </tr>
                            <tr>
                                <th>휴대폰번호</th>
                                <td>${ m.phone }</td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>${ m.email }</td>
                            </tr>
                            <tr>
                                <th>성별</th>
                                <td>${ m.gender }</td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>${ m.addressZip }</td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>${ m.address1 }</td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>${ m.address2 }</td>
                            </tr>
                            <tr>
                                <th>출생연도</th>
                                <td>
                                	<fmt:formatDate value="${m.memberBirthYear}" pattern="yyyy" />
                                </td>
                            </tr>
                            <tr>
                                <th>키</th>
                                <td>${ m.height } cm</td>
                            </tr>
                            <tr>
                                <th>몸무게</th>
                                <td>${ m.weight } kg</td>
                            </tr>
                            <tr>
                                <th>가입일</th>
                                <td>${ m.memberEnrollDate }</td>
                            </tr>
                            <tr>
                                <th>상태</th>
                                <c:choose>
                                	<c:when test="${ m.memberStatus.equals('Y') }">
                                		<td>가입</td>
                                	</c:when>
                                	<c:otherwise>
                                		<td>탈퇴</td>
                                	</c:otherwise>
                                
                                </c:choose>
                            </tr>

                        </table>
                        <br><br>


                        <div id="process_btn" align="center">
                            
                            <button type="button" class="btn btn-warning" onclick="location.href='adMyPageUpdateForm.me?mno=${ m.memberNo }'">정보수정</button>
                            <c:choose>
	                            <c:when test="${ m.memberStatus.equals('Y') }">
	                            	<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteMember">탈퇴처리</button>
	                            </c:when>
	                            
                            </c:choose>

                        </div>

                        <!-- 모달창 -->
                        <div class="modal" id="deleteMember" >
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
	                                <div class="modal-header">
	                                    <h5 class="modal-title">회원탈퇴 처리</h5>
	                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="location.href='adMyPageDetail.me?mno=${ m.memberNo }'">
	                                    <span aria-hidden="true"></span>
	                                    </button>
	                                </div>
	                                <div class="modal-body">
	                                    <p>정말 회원탈퇴 처리 하시겠습니까?</p>
	                                </div>
	                                <form action="adMyPageDelete.me" method="post">
		                                <div class="modal-footer">
		                                    <button type="submit" class="btn btn-primary">탈퇴 진행</button>
		                                    <input type="hidden" name="memberNo" value="${ m.memberNo }">
		                                </div>
	                                </form>
                                </div>
                            </div>
                        </div>

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