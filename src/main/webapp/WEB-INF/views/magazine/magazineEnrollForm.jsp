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
<title>매거진 등록</title>
<!-- hashtag 소스 다운 -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<script src='https://unpkg.com/@yaireo/dragsort'></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />    
<link rel='stylesheet' href='https://unpkg.com/@yaireo/tagify/dist/tagify.css'>
<link rel='stylesheet' href='https://unpkg.com/@yaireo/dragsort/dist/dragsort.css'>
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
	
	.tagify {
		width: 100%;
		max-width: 880px;
	}
	.tagify__tag-text .tagify__tag>div {
		white-space: nowrap;
		background-color: #E5E5E5!important;
	}
	
	.tagify--hasMaxTags>.tagify__input { display:none }
	
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
					<p>매거진 등록</p>
				</div>
              <div id="content_2_2">
                  <form id="enrollForm" method="post" action="enroll.mag" enctype="multipart/form-data">
                      <table class="table" align="center">
                        <tr>
                            <th width="10%"><label for="magazineTitle">제목</label></th>
                            <td width="90%"><input type="text" id="magazineTitle" class="form-control" name="magazineTitle" placeholder="제목을 입력해주세요 (30자 이내)" required maxlength="30"></td>
                        </tr>
                        <tr>
                          <th>카테고리</th>
                          	<td>
                              <select class="form-select" id="magazineSelectOpt" name="categoryNo">
                                   <option value="1" data-sub="라이프">라이프</option>
                                   <option value="2" data-sub="시즌">시즌</option>
                                   <option value="3" data-sub="이슈">이슈</option>
                              </select>
                          </td>
                        </tr>
                        <tr>
                          <th><label for="magazineContent">내용</label></th>
                          <td><textarea id="magazineContent" class="form-control h-25" rows="19" style="resize:none;" placeholder="내용을 입력해주세요 (1000자 이내)" name="magazineContent" required maxlength="1000"></textarea></td>
                        </tr>
                        <tr>
                          <th><label for="upfile">사진</label></th>
                          <td><input multiple="multiple" type="file" id="upfile" class="form-control" name="upfile" onchange="checkFile();"></td>
                        </tr>  
                        <tr>
                          <th><label for="hashtag">해시태그</label></th>
                          <td>
	                        <input type="text" id="hashtag" placeholder="#해시태그 (10자 이내, 최대 3개)" class="form-control" name="magazineHashtag" pattern='^#.{1,9}$'>
              			  </td>
                        </tr>
                    </table>
                    
                    <script>
	                    $(function () {
	            	        $("#magazineSelectOpt").on("change", function () {
	            	            var value = $(this).val();
	            	            var subValue = $(this).find("option:selected").data("sub");
	            	        });
	            	    });
                    	
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
				    
				    <script>
				    	var input = document.querySelector('input[name=magazineHashtag]');
				    	
				    	var tagify = new Tagify(input, {
	                    	pattern: /^#.{1,9}$/,
	                    	maxTags: 3
	                    })
	                    
	                    var dragsort = new DragSort(tagify.DOM.scope, {
	                    	selector: '.' + tagify.settings.classNames.tag,
	                    	callbacks: {
	                    		dragEnd : onDragEnd
	                    	}
	                    })
	                    
	                    function onDragEnd() {
	                    	tagify.updateValueByDOMTags()
	                    }
				    	
				    	tagify.on('remove', function(e) {
	                    	document.getElementsByClassName('tagify__input')[0].focus();
	                    });
                	</script>
                     
                    <br><br> 
                    <div align="center">
                      <button type="submit" class="btn btn-primary">등록</button>
                      <button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
                    </div>
                </form>
	         </div>
	         <br clear="both">
	         <div id="content_2_3"></div>
         </div>
         
         <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>