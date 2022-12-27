<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 회원 정보 수정</title>
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

        /* ----- 회원정보수정 style ----- */
    /* 목록 테이블 */
    #member_info { margin-top: 20px; }
    #member_info>tbody>tr { height: 50px; }

    /* 테이블 안 input, select */
    #member_info input, #member_info select { width: 35%; display: inline-block; }

    /* 처리 버튼 */
    #process_btn>button {
        width: 110px;
        height: 40px;
        margin: 0px 5px;
    }

    

</style>

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


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
                        
                        <form action="adMyPageUpdate.me" method="post">
                            <table id="member_info">
                            <input type="hidden" name="memberNo" value="${ m.memberNo }">
                            <input type="hidden" name="memberId" value="${ m.memberId }">
                                <tr>
                                    <th width="25%">회원번호</th>
                                    <td colspan="3">${ m.memberNo }</td>
                                </tr>

                                <tr>
                                    <th>아이디</th>
                                    <td colspan="3">${ m.memberId }</td>
                                </tr>
                                <tr>
                                    <th>이름</th>
                                    <td colspan="3"><input type="text" class="form-control" name="memberName" value="${ m.memberName }" required></td>
                                </tr>
                                <tr>
                                    <th>휴대폰번호</th>
                                    <td colspan="3"><input type="text" class="form-control" name="phone" value="01012345678" placeholder="-제외" maxlength="11" required></td>
                                </tr>
                                <tr >
                                    <th>이메일</th>
                                    <td >
                                        <input type="text" class="form-control" name="email" placeholder="이메일 입력" value="${ m.email }" required  maxlength="30">
                                    </td>
                                
                                </tr>
                                <tr>
                                    <th>성별</th>
                                    <td colspan="3">
                                        <select class="form-select" name="gender">
                                            <option disabled selected>${ m.gender }</option>
                                            <option value="M">남성</option>
                                            <option value="F">여성</option>
                                        </select>
                                        <!-- loginUser 의 성별을 selected 하도록 -->
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td colspan="3">
                                        <input type="text" class="form-control" name="addressZip" id="address_zip" placeholder="${ m.addressZip }" style="display:inline-block; width: 60%;">
                                        <input type="button" class="btn btn-secondary" id="address_btn" onclick="getAddress();" value="우편번호 찾기" style="width:20%; vertical-align: top; color: white;">
                                    </td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td colspan="3">
                       
                                        <input type="text" class="form-control" name="address1" id="address1" placeholder="${ m.address1 }" required style="width: 60%;">
                                    </td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td colspan="3">
                                        
                                        <input type="text" class="form-control" name="address2" id="address2" placeholder="${ m.address2 }" required style="width: 60%;">
                                    </td>
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
                                    <td colspan="3">${ m.memberEnrollDate }</td>
                                </tr>
                                <tr>
                                    <th>상태</th>
                                    <c:choose>
                                        <c:when test="${ m.memberStatus.equals('Y') }">
                                            <td colspan="3">가입</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td colspan="3">탈퇴</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>

                            </table>

                            <script>
                                /* 우편번호 검색 API */
                                function getAddress() {
                                    new daum.Postcode({
                                        oncomplete: function(data) {
                                            
                                            // 지번을 선택해도 도로명으로만 표시
                                            var address = data.roadAddress;
                                            
                                            // 건물명이 있을 경우 추가
                                            if(data.buildingName != '') {
                                                address += ' (' + data.buildingName + ')';
                                            }
                                            
                                            // 우편번호
                                            $("#address_zip").val(data.zonecode).attr("readonly", true);
                                            // 선택한 주소
                                            $("#address1").val(address).attr("readonly", true);
                                            
                                            // 커서 포커스
                                            $("#address2").focus();
                            
                                        }
                                    }).open();
                                }
                            </script>

                            
                            <br><br>

                            <div id="process_btn" align="center">
                                <button type="submit" class="btn btn-primary" >수정</button>
                                <button type="button" class="btn btn-secondary">취소</button>
                            </div>
                        </form>

                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>

        <div>
            <jsp:include page="../common/footer.jsp" />
        </div>
    </div>
    
</body>
</html>