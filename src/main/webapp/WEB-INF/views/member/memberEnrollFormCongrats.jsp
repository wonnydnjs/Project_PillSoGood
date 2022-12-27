<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%
     request.setCharacterEncoding("utf-8"); 
%>  
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>환영합니다.</title>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { height: auto; display: flex; color: black;}
    #content_2>div { width: 100%; float: left; }
    #content_2_2 { height: auto; }

    #header { height: 130px; }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* 여기서부터는 내가 준 스타일 영역 */
    #checkicon {
        text-align: center;
        font-size: 80px;
        padding: 20px;
        color: #78C2AD;
    }

    #completeMsg {
        font-size: 35px;
        padding: 20px;
        font-weight:900;
    }

    #completeMsg2 {
        padding: 40px;
        font-size: 17px;
    }

    #btn {
        padding: 30px;
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
                <div id="content_2_2">
                    <div id="checkicon">
                        <i class="fa-sharp fa-solid fa-circle-check" ></i>
                    </div>
                    <div align="center" id="completeMsg">
                    	
                   	<label> 
                   	회원가입을 축하합니다. <br>
                   	<span style="color:#78C2AD;"><%= request.getParameter("memberName") %></span>님 환영합니다.
                   	 
                   	</label>
    			        
                    </div>
                    <div align="center" id="completeMsg2">
				                        설문을 통해 나만을 위한 <br> 
				                        맞춤 영양 성분을 확인해보세요.
                    </div>
                    <div align="center" id="btn">
                        <button class="btn btn-primary" onclick="location.href='loginForm.me'">로그인하기</button> &ensp;
                        <button class="btn btn-secondary" onclick="location.href='survey.po'">건강설문 시작하기</button>
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