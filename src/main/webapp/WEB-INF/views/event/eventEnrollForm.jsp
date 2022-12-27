<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>이벤트 등록</title>
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

    #content { height: auto; display: flex; color: black; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 10%; float: left; }
    #content_2_2 { height: 90%; float: left;  padding-bottom: 100px;}

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }
    
    #eventModifyArea{ 
        width: 100%;
        border: 1px solid gray;
        border-radius: 30px;
        margin: auto;

    }
    #eventModifyForm th {
        text-align: left;
    }


    #eventModifyForm td>*  {
        /* width : 690px; */
        box-sizing: border-box;
        border-radius:5px
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
                    <p>
                        이벤트 작성하기
                    </p>    
                </div>
                <div id="content_2_2">
                        <div id="eventModifyArea">
                            <form action="insert.ev" method="post" enctype="multipart/form-data">
                                <div style="padding: 20px;">
                                    <table class="table" id="eventModifyForm" width="100%" align="center">
                                        <tr>
                                            <th>제목</th>
                                            <td colspan="3">
                                                <input class="form-control" type="text" name="evtTitle" placeholder="제목 입력">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>시작일</th>
                                            <td>
                                                <input class="form-control" name="evtStart" style="width:250px" type="date" required>
                                            </td>
                                            <th>마감일</th>
                                            <td>
                                                <input class="form-control" name="evtDew" style="width:250px" type="date" required>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>첨부파일</th>
                                            <td colspan="100%">
                                            	<input type="file" id="upfile" name="upfile" class="form-control">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td colspan="100%">
                                                <textarea class="form-control" name="evtContent" id="evtContent" cols="40" rows="20" style="resize:none;" placeholder="내용 입력"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                

                            <div align="center" style="padding-bottom: 30px;">
                                <button class="btn btn-primary btn-lg" type="submit">등록</button> &nbsp;
                                <button class="btn btn-light btn-lg" type="reset">취소</button>
                            </div>

                       
                        
                        </form>
                    </div>


                </div>

            </div>

            <div id="content_3"></div>
        </div>


        <jsp:include page="../common/footer.jsp" />

        
    </div>
    
</body>
</html>