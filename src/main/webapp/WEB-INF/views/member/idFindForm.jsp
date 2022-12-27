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

    #navigator2 { height: 0px; }

    #content { height: 1000px; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 10%; float: left; }
    #content_2_2 { height: 80%; float: left; }
    #content_2_3 { height: 10%; float: left; }

    #header { height: 0px; }

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
    #search_id_main_text {
        font-size: 35px;
        color : rgb(40, 40, 40);
        font-weight: bold;
        padding: 20px;
        text-align: center;
    }

    #search_id_text {
        color : rgb(40, 40, 40);
        display: inline-block;
        padding-top: 30px;
        padding-bottom: 30px;
        width: 100%;
        text-align: center
    }

    #searchId {
        padding: 30px;
        margin-top: -30px;
        box-sizing : border-box;
        width: 100%;
        display: inline-block;
    }

    #searchId table {
        height: 100px;
        color : rgb(40, 40, 40);
        
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
                <div id="content_2_1" style="height: 100px;">
                    <p></p>
                </div>
                <div id="content_2_2">
                    <div id="search_id_main_text">아이디 찾기</div>
                    <div id="search_id_text">
			                        회원가입때 등록하신 <br>
			                        이름과 이메일을 입력해주세요.
                    </div>
                    
                    <form action="idFind.me" method="post">
                        <div id="searchId" >
                            <table align="center">
                                <tr>
                                    <th width="80px">이름</th>
                                    <td>
                                        <input class="form-control" type="text" placeholder="이름 입력" maxlength="10" size="30" id="memberName" name="memberName" required>
                                    </td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input type="text" class="form-control" placeholder="이메일 입력" maxlength="20" id="email" name="email" required>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div></div>

                        <div align="center">
                            <button class="btn btn-secondary" style="width: 400px; height: 50px;" id="findIdbtn">다음</button>
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