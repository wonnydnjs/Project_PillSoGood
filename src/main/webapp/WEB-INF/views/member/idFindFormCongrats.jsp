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

    div { box-sizing : border-box; }
    body { font-family: 'Noto Sans KR', sans-serif !important; }

    .wrap {
        width: 100%;
        height: inherit;
        margin : auto;
    }
    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }
	#header { height: 130px; }
	
    #content { display: flex; height: auto; }
    #content>div { height : 100%; float : left; }
    
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }
    
    #content_2>div { width: 100%; }
    #content_2_1, #content_2_3 { height: 115px; }
    #content_2_2 { height: auto; color: black; }

    /* 여기부터는 내가 준 스타일 영역 */
    #idFindTitle {
        font-weight: bold;
        text-align: center;
        line-height: 115px;
        color: black;
    }
    #checkicon {
    	color: #78C2AD;
    	font-size: 50px;
    }

    #findIdArea {
        background-color: #78c2ad36;
        border-radius: 10px;
        width: 400px;
        height: 100px;
        margin: auto;
        text-align: center;
        line-height: 100px;
        margin-top: 30px;
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
                	<h1 id="idFindTitle">아이디 찾기</h1>
                </div>
                <div id="content_2_2">
                    <div align="center">
                    	<i class="fa-sharp fa-solid fa-circle-check" id="checkicon"></i>
                    	<br><br>
                        입력하신 정보와<br>일치하는 아이디를 찾았습니다.
                    </div>
                    
                    <div id="findIdArea">${ findId }</div>

                    <div align="center">
                        <button class="btn btn-primary" style="width: 400px; height: 50px; margin-top: 30px;" onclick="location.href='loginForm.me'">로그인</button>
                    </div>
                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>