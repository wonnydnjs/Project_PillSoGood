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
<!-- hashtag 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
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

	.innerContent { 
		display: flex;
		float: left;
		left: 1000px;
		position:relative;
		top: 5%;
		left: 5%;
		margin-top: 10px;
		margin-bottom: 10px;
	}

	.innerContent {
		padding: 40px;
		padding-top: 60px;
		border-radius: 15px;
		border-color: rgba(128, 126, 126, 0.541);
	}

	#magazineTitle {
		width: 900px;
		box-sizing: border-box;
		margin-top: 10px;
		margin-bottom: 10px;
		height:45px;
	}

	#content {
		margin-top: 10px;
		margin-bottom: 10px;
	}

	th { 
		padding-left: 10px;
		padding-right: 20px;
	}

	#select { width: 200px; }

	.btnArea {
		padding-top: 80px;
		padding-bottom: 40px;
	}
      
	.tagify {
		--tag--max-width: 250px;
		width: 100%;
		max-width: 600px;
	}

	.tagify .tagify__tag-text {
		white-space: nowrap;
	}

	.tagify {    
		max-width: 900px;
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
            	<div id="content_2_1">
            		<p>매거진</p>
            	</div>
              <div id="content_2_2">
                <div class="innerContent" style="border: 2px solid;">
                  <form id="enrollForm" method="post" action="enroll.mag" enctype="multipart/form-data">
                    <fieldset>
                      <table align="center">
                        
                        <tr>
                            <th><label for="magazineTitle">제목</label></th>
                            <td><input type="text" id="magazineTitle" class="form-control" name="magazineTitle" placeholder="내용을 입력해주세요" required maxlength="100"></td>
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
                          <th><label for="content">내용</label></th>
                          <td><textarea id="magazineContent" class="form-control h-25" rows="20" style="resize:none;" name="magazineContent" required maxlength="3000"></textarea></td>
                        </tr>

                        <tr>
                          <th><label for="upfile">사진</label></th>
                          <td><input multiple="multiple" type="file" id="upfile" class="form-control-file border" name="upfile" maxlength="1000"></td>
                        </tr>  

                        <tr>
                          <th><label for="hashtag">해시태그</label></th>
	                          <td>
                        <input type="text" placeholder="type tags" id="magazineHashtag" class="form-control" name="magazineHashtag" value="${mag.magazineHashtag}" maxlength="20">
                        
                        <script src='https://unpkg.com/@yaireo/tagify'></script>
           				<script src='https://unpkg.com/@yaireo/dragsort'></script>
           				<script>
                    // This demo is using "dragsort" lib (by myself)
                    // https://github.com/yairEO/dragsort
			        

                    // The DOM element you wish to replace with Tagify
                    var input = document.querySelector('input[name=magazineHashtag]');

                    // initialize Tagify on the above input node reference
                    
                    var tagify = new Tagify(input, {
                      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(' ')
                    })

                    // bind "DragSort" to Tagify's main element and tell
                    // it that all the items with the below "selector" are "draggable"
                    var dragsort = new DragSort(tagify.DOM.scope, {
                        selector: '.'+tagify.settings.classNames.tag,
                        callbacks: {
                            dragEnd: onDragEnd
                        }
                    })

                    // must update Tagify's value according to the re-ordered nodes in the DOM
                    function onDragEnd(elm){
                        tagify.updateValueByDOMTags()
                    }

                    // listen to tagify "change" event and print updated value
                    tagify.on('change', e => console.log(e.detail.value))
                	</script>
	                          
	                       </td>
                        </tr>
                    </table>  
                    <div align="center" class="btnArea">
                      <button type="submit" class="btn btn-primary" id="magazineBtn">등록</button>
                      <button type="button" class="btn btn-light" onclick="javascript:history.go(-1);">취소</button>
                    </div>
                  </fieldset>
                </form>
              </div>

         </div>
         <div id="content_2_3"></div>
         </div>
         
         <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
    <script>
    	var input = document.querySelector('input[name=magazineHashtag]')
    
    	new Tagify(input)
    </script>
    
    <script>
	    $(function () {
	        $("#magazineSelectOpt").on("change", function () {
	            var value = $(this).val();
	            var subValue = $(this).find("option:selected").data("sub");
	        });
	    });
	</script>
    
</body>
</html>