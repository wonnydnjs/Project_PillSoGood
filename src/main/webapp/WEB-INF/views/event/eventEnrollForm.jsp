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
    
    /* ---------------------- */
    
    #enrollForm {
		width: 95%;
		margin: auto;
		border: 2px solid black;
		border-radius: 15px;
		padding: 50px;
	}
	
	.table th {
		color: black;
		vertical-align: middle;
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
                    <p>이벤트 등록</p>    
                </div>
                <div id="content_2_2">
                   <form id="enrollForm" action="insert.ev" method="post" enctype="multipart/form-data">
                        <table class="table" align="center">
                            <tr>
                                <th width="10%">제목</th>
                                <td colspan="3">
                                    <input class="form-control" type="text" name="evtTitle" placeholder="제목을 입력해주세요 (30자 이내)" maxlength="30" required>
                                </td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td>
                                    <input class="form-control" name="evtStart" style="width:250px" type="date" required>
                                </td>
                                <th width="10%">마감일</th>
                                <td>
                                    <input class="form-control" name="evtDew" style="width:250px" type="date" required>
                                </td>
                            </tr>
                            <tr>
                                <th>첨부파일</th>
                                <td colspan="3">
                                	<input type="file" id="upfile" name="upfile" class="form-control" onchange="checkFile();">
                                </td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td colspan="3">
                                    <textarea class="form-control" name="evtContent" id="evtContent" rows="20" style="resize:none;" placeholder="내용을 입력해주세요 (1000자 이내)" maxlength="1000"></textarea>
                                </td>
                            </tr>
                        </table>
                        
                        <script>
					    	function checkFile() {
					    		
					    		var file = $("input[type=file]");
					    		
					    		if(file.val() != "") {
					    			
						    		var maxSize = 10 * 1024 * 1024;
						    		var fileSize = file[0].files[0].size;
						    		
						    		if(fileSize > maxSize) {
						    			alert('10MB 이하의 파일만 등록할 수 있습니다.');
						    			file.val("");
						    			return;
						    		}
						    		
						    		var ext = file.val().substring(file.val().lastIndexOf(".")).toLowerCase();
						    		
						    		if($.inArray(ext, ['.jpg', '.jpeg', '.gif', '.png']) == -1) {
						    			alert('jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.');
						    			file.val("");
						    			return;
						    		}
					    		}
					    	}
					    </script>
						
						<br><br>
                       <div align="center"> 
                           <button class="btn btn-primary" type="submit">등록</button>
                           <button class="btn btn-secondary" type="button" onclick="history.back();">취소</button>
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