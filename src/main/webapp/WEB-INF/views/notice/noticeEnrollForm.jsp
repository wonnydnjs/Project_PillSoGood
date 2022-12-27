<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>공지사항 작성</title>

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

    #content { height: 1150px; }
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
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }
	

    #noticeEnrollArea{ 

        border: 1px solid gray;
        border-radius: 10px;
        width: 800px;
        margin : auto;
        margin-top : 50px;

    }
    #noticeEnrollForm th {
        text-align: center;
    }

    #noticeEnrollForm {
        margin : 20px;

        
    }

    #noticeEnrollForm td>*  {
        width : 690px;
        box-sizing: border-box;
        border-radius:5px
    }
    
    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
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
                     <img src="resources/images/Logo.PNG" width="200px" alt=""> 공지사항
                 </p>    
             </div>
             <div id="content_2_2">
                 
                 <form action="insert.no" method="post">

                     <div id="noticeEnrollArea">
                         <table class="table" style="width : 760px;" align="center" id="noticeEnrollForm">
                             <tr>
                                 <th>제목</th>
                                 <td><input type="text" name="noticeTitle" class="form-control" placeholder="제목을 입력하세요"></td>
                             </tr>
                             <tr>
                                 <th>내용</th>
                                 <td><textarea name="noticeContent" id="" class="form-control" cols="40" rows="20" style="resize:none;" placeholder="내용을 입력하세요"></textarea></td>
                             </tr>
                         </table>

                         <br><br>

                         <div align="center" style="margin-bottom : 50px;">
                             <button class="btn btn-primary" type="submit">등록</button>
                             <button class="btn btn-light" type="reset">취소</button>
                         </div>

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