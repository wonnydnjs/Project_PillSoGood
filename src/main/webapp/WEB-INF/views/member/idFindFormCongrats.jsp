<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>아이디 찾기</title>
<style>

    div {
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%; 
        height: 1530px;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { height: 1000px; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 10%; float: left; }
    #content_2_2 { height: 80%; float: left; }
    #content_2_3 { height: 10%; float: left; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        text-align : center;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; color: }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* 여기부터는 내가 준 스타일 영역 */
    #success_id_main_text {
        font-size: 35px;
        color : rgb(40, 40, 40);
        font-weight: bold;
        padding: 20px;
        text-align: center;
    }

    #success_id_text {
        color : rgb(40, 40, 40);
        display: inline-block;
        padding-top: 30px;
        padding-bottom: 30px;
        width: 100%;
        text-align: center
    }

    #successId {
        background-color: lightgrey;
        color : rgb(40, 40, 40);
        border-radius: 10px;
        width: 400px;
        height: 100px;
        margin: auto;
        text-align: center;
        vertical-align: middle;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    #successId>p {
        margin-top: 33px;
    }


    #checkicon {
        color: #78C2AD;
    }
    





</style>

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
                    <p></p>
                </div>
                <div id="content_2_2">
                    <div id="success_id_main_text">
                        <i class="fa-sharp fa-solid fa-circle-check" id="checkicon"></i> <br>
                        		아이디 찾기 성공
                    </div>
                    <div id="success_id_text">
                        		입력하신 정보와 <br>
                      		  일치하는 아이디를 찾았습니다.
                    </div>
                    
                    <div id="successId">
                        <p style="padding-top:10%;">${ findId }</p>
                    </div>

                    <div align="center">
                        <button class="btn btn-secondary" style="width: 400px; height: 50px;" onclick="loginForm()">로그인</button>
                    </div>
                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <script>
         function loginForm () {
        	 
        	 location.href = "loginForm.me";
         }
        </script>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>