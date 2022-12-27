<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 건강설문 관리</title>

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
    #content_2_2 { height: 100%;  color: black; }

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

    /* ----- 설문조회 style ----- */
    #go_survey {
        background-color: #78c2ad36;
        color: black;
        height: 60px;
        line-height: 56px;
        border-radius: 10px;
        cursor: pointer;
    }

    /* 설문 삭제 div 버튼화 */
    .survey { position: relative; }
    .survey>div {
        display: inline-block;
        position: absolute;
        top: 0;
        bottom: 0;
        right: 0;
        cursor: pointer;
        height: 25px;
    }

    /* 설문상세조회 버튼 */
    .survey>button { width: 120px; }

    .survey b, .survey sub, .fa-solid { color: black; }

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
                        <h4>건강설문 관리</h4>
                        <hr>

                        <div align="center" id="go_survey" onclick="location.href='survey.po'">
                            건강설문으로 맞춤 영양성분을 확인하세요. <b>건강설문 시작하기 &gt;</b>
                        </div>
                        <hr>
                    
                        <c:if test="${ pollList.size() ne 0 }">
                            <c:forEach var="i" begin="0" end="${ pollList.size() - 1}">
                                <div class="survey">
                                    <b>${ pollList[i].pollDate }</b> <div><i class="fa-solid fa-xmark fa-lg" onclick="deleteSurvey(${ pollList[i].pollNo })"></i></div>
                                    <br><br>
                                    <c:forEach var="j" begin="0" end="${ pollResult.size() -1 }">
                                        <c:if test="${ pollList[i].pollNo eq pollResult[j].pollNo }">
                                            <b>
                                                # ${ pollResult[j].productExplain }
                                            </b>
                                        </c:if>
                                    </c:forEach>

                                    <br>
                                    <sub>
                                        <c:forEach var="j" begin="0" end="${ pollResult.size() -1 }">
                                            <c:if test="${ pollList[i].pollNo eq pollResult[j].pollNo }">
                                                ${ pollResult[j].productName },
                                            </c:if>
                                        </c:forEach>
                                    </sub>
                                    <br><br>
                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="selectPollResult(${ pollList[i].pollNo })"><small>설문결과 보기</small></button>
                                </div>
                                <hr>
                            
                            </c:forEach>
                        </c:if>

                        <script>
                        	function selectPollResult(pollNo) {
                        		
                        		location.href='pollResult.po?pollNo='+pollNo;
                        	}
                            
                        	function deleteSurvey(pollNo) {
                        		if(window.confirm("정말 삭제하시겠습니까?")) {
                        			
                        			location.href='delete.po?pollNo='+pollNo;
                        		}
                        	}
                        </script>

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