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
<title>로그인</title>
<style>

    /* 여기는 내가 넣은 스타일 영역 */
    #loginFrom {
        
        box-sizing: border-box;
        width: 400px;
        height: 100px;
        margin-top: 40px;
        margin-bottom: 40px;
        color : rgb(40, 40, 40);

    }

    #loginText {
        font-size: 35px;
        color : rgb(40, 40, 40);
        font-weight: bold;
        padding-top: 20px;
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
                <div style="height: 100px;"></div>
                <div id="content_2_2">
                    <div align="center" id="loginText">로그인</div>
                    <form action="login.me" method="post">
                        <table id="loginFrom" align="center">
                            <tr>
                                <th>아이디</th>
                                <td>
                                    <input class="form-control" type="text" placeholder="아이디를 입력해주세요" maxlength="20" id="memberId" name="memberId" autofocus>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td>
                                    <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요" maxlength="20" id="memberPwd" name="memberPwd">
                                </td>
                            </tr>
                        </table>

                        <div align="center">
                            <button class="btn btn-secondary" style="width: 400px; height: 45px;">로그인</button>
                        </div>

                    </form>

                    <div align="center" style="padding: 20px; margin-top: 15px;">
                        <a href="idFindForm.me" style="text-decoration:none; color:black;">ID 찾기</a>
                        &ensp; | &ensp;
                        <a href="enrollForm.me" style="text-decoration:none; color:black;">회원가입</a>
                    </div>
                    

                </div>
                <div style="height: 100px;"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>