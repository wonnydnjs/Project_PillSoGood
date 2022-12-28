<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 비밀번호 변경</title>
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

    /* ----- 비밀번호변경 style ----- */
    /* form 사이즈 지정 */
    #change_pwd { padding: 20px; }

    /* 비밀번호 입력 div 들 */
    .pwds {
        width: 100%;
        height: 60px;
        position: relative;
    }
    /* 사이즈 정렬 */
    .pwds>b { display: inline-block; width: 20%; }
    .pwds>input { display: inline-block; width: 60%; }

    /* 눈 아이콘 위치 지정 */
    .eyes {
        position: absolute;
        top: 0;
        bottom: 0;
        right: 0;
        cursor: pointer;
        margin-right: 170px;
        line-height: 37px;
        color: #78C2AD;
    }


</style>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<!-- bootswatch minty -->
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- ajax jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- font-awesome -->
<script src="https://kit.fontawesome.com/6cda7ccd12.js" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>

    <div class="wrap">
            <jsp:include page="../common/menubar.jsp" />
        <div id="navigator2"></div>
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
                            <p style="font-size: 20px;"><b style="font-size: 25px;">${loginUser.memberName}</b> 님</p>
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
                        <h4>비밀번호 변경</h4>
                        <hr>

                        <form id="change_pwd" action="changePwd.me" method="post">

                            <div class="pwds">
                                <b>현재 비밀번호</b>
                                <input type="password" class="form-control" name="memberPwd" placeholder="현재 비밀번호 입력" required>
                                <div class="eyes">
                                    <i class="fas fa-eye fa-lg"></i>
                                </div>
                            </div>
                            
                            <div class="pwds">
                                <b>새 비밀번호</b>
                                <input type="password" class="form-control" name="changePwd" placeholder="영문, 숫자, 특수문자 포함 8 ~ 20자" required id="memberPwd">
                                <div class="eyes">
                                    <i class="fas fa-eye fa-lg"></i>
                                </div>
                            </div>

                            <div class="pwds">
                                <b>비밀번호 확인</b>
                                <input type="password" class="form-control" name="checkPwd" placeholder="동일한 비밀번호 입력" required id="checkPwd">
                                <div class="eyes">
                                    <i class="fas fa-eye fa-lg"></i>
                                </div>
                            </div>
                            <br>

                            <div align="center">
                                <button type="submit" class="btn btn-primary" style="width: 40%; height: 45px;" onclick="return validate();">변경</button>
                            </div>

                            <script>
                                $(function() {

                                    // 눈 표시 클릭시 비밀번호가 보이도록
                                    $(".eyes").on("click", function() {
                                        
                                        if($(this).siblings("input").attr("type") == "password") {

                                            $(this).siblings("input").attr("type", "text");
                                        } else {

                                            $(this).siblings("input").attr("type", "password");
                                        } 

                                    });
                                });
                            </script>

							<script>
						     function validate() {

						          var changePwd = document.getElementById("changePwd");
						          var checkPwd = document.getElementById("checkPwd");

						         var regExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}$/;
						         if(!regExp.test(changePwd.value)) {
						             
						        	  alert("특문(!@#$%^), 영문(대소문자), 숫자 포함하여 8자 이상 20자 이하로 총 12~20자로 입력해주세요.");
						             
						        	  changePwd.value = "";
						        	  changePwd.focus(); // 재입력 유도
						              return false;
						          }
						          
						          if($("input[name=changePwd]").val() != $("input[name=checkPwd]").val()) {
						            
						        	  alert("비밀번호가 일치하지 않습니다.");
						              checkPwd.select(); // 재입력 유도
						             
						              return false;
						          }
						     }
							</script>
                        </form>
                        <hr>

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