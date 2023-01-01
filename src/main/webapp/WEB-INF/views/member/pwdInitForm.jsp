<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>비밀번호 초기화</title>
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
    #pwdInitTitle {
        font-weight: bold;
        text-align: center;
        line-height: 115px;
        color: black;
    }

    #pwdInit tr { height: 50px; }
    
    #pwdInitBtn {
    	width: 403px;
    	height: 50px;
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
                	<h1 id="pwdInitTitle">비밀번호 초기화</h1>
                </div>
                <div id="content_2_2">
                    <div align="center">
                    	비밀번호가 기억나지 않으실 경우<br>
                    	비밀번호를 임의로 초기화할 수 있습니다<br>
                    	<br>
                    	회원가입시 등록하신 아이디와 이메일을 입력해주세요
                    </div>
                    <br clear="both">
                    
                    <form action="pwdInit.me" method="post">
                        <div id="pwdInit">
                            <table align="center">
                                <tr>
                                    <th width="80px">아이디</th>
                                    <td>
                                        <input class="form-control" type="text" placeholder="아이디를 입력해주세요" maxlength="20" size="30" name="memberId" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input type="text" class="form-control" placeholder="이메일을 입력해주세요" maxlength="40" name="email" required>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div align="center">
                            <button class="btn btn-secondary" id="pwdInitBtn">다음</button>
                        </div>

					 </form>

                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>