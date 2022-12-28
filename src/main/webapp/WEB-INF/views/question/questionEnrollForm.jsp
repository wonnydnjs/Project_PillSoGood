<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>1:1 문의 작성</title>
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

    /* content_2_2 영역 분배 */
    #content_2_2>div { width: 100%;}        

    #insert_btn { text-align: center; }

    /* 요소들 스타일 */
    #insert_btn button {
        height: 45px;
        width: 200px;
        margin: auto;
    }

    .form-control {
        margin-left: 0px;
        width: 95%!important;
        margin: auto;
    }

    #content_2_2 p {
    	margin-left: 30px;
        font-weight: bold;
        font-size: large;
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
                    <p>1:1 문의 작성</p>
                </div>
                <div id="content_2_2">

                    <form action="insert.qu" method="post" enctype="multipart/form-data">
                    	<input type="hidden" name="memberNo" value="${ loginUser.memberNo }">

                        <!-- 제목 부분 -->
                        <div>
                            <p>제목</p>
                            <input type="text" id="questionTitle" class="form-control" name="questionTitle" placeholder="문의 제목을 입력해주세요 (30자 이내)" maxlength="30" required>
                        </div>
                        <br>
                        
                        <!-- 내용 부분 -->
                        <div>
                            <p>내용</p>
                            <textarea name="questionContent" cols="20" rows="15" class="form-control" placeholder="문의 내용을 입력해주세요 (1000자 이내)" maxlength="1000" style="resize: none;" required></textarea>
                        </div>
                        <br>
                        
                        <!-- 사진첨부 부분 -->
                        <div>
                            <p>사진첨부(선택)</p>
                            <input type="file" class="form-control" name="upfile" onchange="checkFile();">
                        </div>
                        <br><br>
                        
                        <!-- 등록 버튼 -->
                        <div id="insert_btn">
                            <br><br>
                            <button type="submit" class="btn btn-primary" onclick="toAdminSocketMsg();">등록하기</button>
                            <button type="button" class="btn btn-secondary" onclick="location.href='list.qu'">뒤로가기</button>
                        </div>

                    </form>
                </div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
    <script>
    	var questionTitle = "";
    	function toAdminSocketMsg() {
    		
    		questionTitle = $("#questionTitle").val();
    		
    		if(socket) {
    			let socketMsg = "question"+","+"${ loginUser.memberId },"+"admin," + "bno," + questionTitle;
    			selectAlarmList();
    			socket.send(socketMsg);
    			//console.log(socket);
       		}
    		
    		
    		$.ajax({
    			url : "insertQuestion.alarm",
    			data : {
    				alarmContent : "${loginUser.memberId} 님이 1대1 문의를 작성하셨습니다.",
    				fromId : "${loginUser.memberId}",
    				toId : "admin"
    				
    			},
    			success : function(result) {
    				selectAlarmList();	
    				console.log(result);
    			},
    			error : function() {
    				console.log("toAdminAlarmInsert ajax failure");
    			}
    			
    		});
    	}
    	
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
	    		
	    		console.log(ext);
	    		
	    		if($.inArray(ext, ['.jpg', '.jpeg', '.gif', '.png']) == -1) {
	    			alert('jpg, jpeg, gif, png 파일만 업로드 할 수 있습니다.');
	    			file.val("");
	    			return;
	    		}
    		}
    	}
    </script>
    

</body>
</html>