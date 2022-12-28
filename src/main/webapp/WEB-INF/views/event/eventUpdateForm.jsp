<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>이벤트 수정</title>
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

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
    }
    
    #eventModifyArea{ 
        width: 100%;
        border: 1px solid gray;
        border-radius: 30px;
        margin: auto;

    }
    #eventModifyForm th { text-align: left; }

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
                    <p>이벤트 수정</p>    
                </div>
                <div id="content_2_2">
                        <div id="eventModifyArea">
                            <form action="update.ev" method="post" enctype="multipart/form-data">
                            	<input type="hidden" name="evtNo" value="${ e.evtNo }">
                                <div style="padding: 20px;">
                                    <table class="table" id="eventModifyForm" width="100%" align="center">
                                        <tr>
                                            <th>제목</th>
                                            <td colspan="3">
                                                <input class="form-control" type="text" name="evtTitle" value="${ e.evtTitle }">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>시작일</th>
                                            <td>
                                                <input class="form-control" name="evtStart" style="width:250px" type="date" required value="${ e.evtStart }">
                                            </td>
                                            <th>마감일</th>
                                            <td>
                                                <input class="form-control" name="evtDew" style="width:250px" type="date" required value="${ e.evtDew }">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>첨부파일</th>
                                            <td colspan="100%">
                                            	<!-- 파일 선택하는 버튼 -->
                                            	<input type="file" id="upfile" name="reupfile" class="form-control"> 
                                            	
                                            	<c:if test="${ not empty e.evtImgName }">
                                            		현재 업로드 된 파일 : 
                                            		<p>${ e.evtImgName.substring(24) }</p>
                                            		
                                            		<input type="hidden" name="${ e.evtImgName }">
                               
                                            	</c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td colspan="100%">
                                                <textarea class="form-control" name="evtContent" id="evtContent" cols="40" rows="20" style="resize:none;">${ e.evtContent }</textarea>
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
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>