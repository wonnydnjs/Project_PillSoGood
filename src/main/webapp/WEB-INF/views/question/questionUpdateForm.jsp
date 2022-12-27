<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>1:1 문의 수정</title>
<style>

    div {
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: inherit;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { display: flex; height: auto; }
    #content_2>div { width: 100%; }
    #content_2_1, #content_2_3 { height: 115px; }
    #content_2_2 { height: auto; color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100vh; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; height: auto!important;}
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* 영섭 작업 영역 시작 */

    /* content_2_2 영역 분배 */
    #content_2_2>div { width: 100%;}        

    #update_btn { text-align: center; }

    /* 요소들 스타일 */
    #update_btn button {
        height: 45px;
        width: 200px;
        margin: auto;
    }

    /* 영섭 작업 영역 끝 */

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
    
    #question_image, #checkbox {
    	margin-left: 40px;
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
                    <p>1:1 문의</p>
                </div>
                <div id="content_2_2">

                    <form action="update.qu" method="post" enctype="multipart/form-data">
                    	<input type="hidden" name="questionNo" value="${ q.questionNo }">
                        <!-- 영섭 작업 영역 시작 -->

                        <!-- 제목 부분 -->
                        <div>
                            <p>제목</p>
                            <input type="text" class="form-control" name="questionTitle" value="${ q.questionTitle }" placeholder="문의 제목을 입력해주세요 (30자 이내)" maxlength="30" required>
                        </div>
                        <br>
                        
                        <!-- 내용 부분 -->
                        <div>
                            <p>내용</p>
                            <textarea name="questionContent" cols="30" rows="15" class="form-control" placeholder="문의 내용을 입력해주세요 (1000자 이내)" maxlength="1000" style="resize: none;" required>${ q.questionContent }</textarea>
                        </div>
                        <br>
                        
                        <!-- 사진첨부 부분 -->
                        <div>
                            <p>사진첨부(선택)</p>
                            <input type="file" class="form-control" name="reupfile" value="${ q.questionImage }" onchange="checkFile();">
                            
                            <c:if test="${ not empty q.questionImage }">
                            	<img id="question_image" src="${ q.questionImage }" width="200px" height="200px">
                            	<input type="hidden" name="questionImage" value="${ q.questionImage }">
                            	<br><br>
                            	<div style="vertical-align: top; width: 200px;" id="checkbox" align="center">
                            		<input type="checkbox" class="form-check-input" name="imageCheck" value="check" class="form-control" id="imageCheck"> <label for="imageCheck" class="form-check-label">기존 사진 삭제</label>
                            	</div>
                            </c:if>
                        </div>
                        <br><br>

                        <!-- 등록 버튼 -->
                        <div id="update_btn">
                            <br><br>
                            <button type="submit" class="btn btn-primary">수정하기</button>
                        </div>

                        <!-- 영섭 작업 영역 끝 -->
                    </form>
                </div>
                
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
                
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

</body>
</html>