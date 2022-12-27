<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 내 정보 관리</title>

<style>

    div {
        /*border : 1px solid #78C2AD;*/
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        /* 전체 길이 개별 커스텀 */
        height: 1400px;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    /* 내용 길이 개별 wrap - 350px */
    #content { height: 1050px; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 115px; }
    #content_2_2 { color: black; }

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

    /* ----- 내정보수정 style ----- */
    /* 테이블들 크기 지정 */
    #my_info table tr, #health_info table tr { height: 50px; }
    #my_info table th, #health_info table th { width: 30%; }
    #my_info table td, #health_info table td { width: 70%; }

    /* 테이블 안 input, select */
    #my_info table input { width: 50%; }
    #health_info table input, #health_info table select { width: 35%; display: inline-block; }

    /* 비밀번호 변경 버튼 */
    #change_pwd>button {
        width: 100%;
        height: 50px;
        background-color: #78c2ad36;
        text-align: left;
        color: black;
        line-height: 36px;
        border: none;
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
                        <form action="update.me" method="post">
                        <input type="hidden" name="memberId" value="${loginUser.memberId}">
                            <h4 style="display: inline;">내 정보 관리</h4>
                            <button type="submit" class="btn btn-outline-primary btn-sm" style="float: right;">저장</button>
                            <hr>

                            <div id="my_info">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="2">필수 정보</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>아이디</th>
                                            <td>${loginUser.memberId}</td>
                                        </tr>
                                        <tr>
                                            <th>이름</th>
                                            <td><input type="text" class="form-control" name="memberName" value="${loginUser.memberName}" required maxlength="6"></td>
                                        </tr>
                                        <tr>
                                            <th>휴대폰번호</th>
                                            <td><input type="text" class="form-control" name="phone" value="${loginUser.phone}" placeholder="-제외" required maxlength="11"></td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td>${loginUser.email}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <div id="health_info">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="2">건강설문 정보</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>성별</th>
                                            <td>
                                                <select class="form-select" name="gender">
                                                    <option value="M" name="gender">남성</option>
                                                    <option value="F" name="gender">여성</option>
                                                </select>
                                                <!-- loginUser 의 성별을 selected 하도록 -->
                                            </td>
                                        </tr>
                                        <tr>
                                        	<!-- loginUser 의 출생연도를 selected 하도록 -->
                                            <th>출생일</th>
                                            <td>
                                            <input type="date" class="form-control" name="memberBirthYear" value="${loginUser.memberBirthYear}">
                                                <%-- <select class="form-select" name="year">
                                                    <c:forEach var="i" begin="0" end="${2022-1900}">
														<c:set var="yearOption" value="${2022-i}" />
														<option value="${yearOption}">${yearOption}</option>
													</c:forEach>	
                                               </select> --%>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키</th>
                                            <td><input type="number" class="form-control" name="height" value="${loginUser.height}" min="0" max="250"> cm</td>
                                        </tr>
                                        <tr>
                                            <th>몸무게</th>
                                            <td><input type="number" class="form-control" name="weight" value="${loginUser.weight}" min="0" max="200"> kg</td>
                                        </tr>
                                      
                                    </tbody>

                                </table>
                            </div>
                        </form>
                        

                        <script>
                        $(function() {
                            
                            if("${loginUser.gender}" != "") {

                                $("option[value=${loginUser.gender}]").attr("selected", true);
                            }
                        });

                        </script>


                        <hr>
                        <div id="change_pwd">
                         <!--비밀번호 변경  -->
                            <button type="button" class="btn btn-primary" style="font-family: 'Noto Sans KR', sans-serif !important;" onclick="changePwdForm();">비밀번호 변경 <p style="float: right;">&gt;</p></button>
                        </div>
                        <br>
    					<button type="button" class="btn btn-outline-secondary btn-sm" style="float: right;" onclick="deleteForm()">회원탈퇴</button>
				    <script>			    
					    function changePwdForm() {
					    	
					    	location.href = "changePwdForm.me";
					    
					    }
					    
					    function deleteForm() {
					    	
					    	location.href = "deleteForm.me"
					    }
				    </script>
                        
         
                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>



</body>
</html>