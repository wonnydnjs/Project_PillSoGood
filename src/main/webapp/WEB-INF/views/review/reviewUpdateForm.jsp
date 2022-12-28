<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>후기 수정</title>
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
	
	#select { width: 200px; }
	i { cursor: pointer; }
	
	.filebox input[type="file"] {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		border: 0;
	}
	.filebox.bs3-primary .col-sm-10>label {
		color: #fff;
		background-color: #337ab7;
		border-color: #2e6da4;
	}
	.filebox .col-sm-10>label {
		display: inline-block;
		padding: .5em .75em;
		color: #999;
		font-size: inherit;
		font-weight: 600;
		line-height: normal;
		vertical-align: middle;
		background-color: #fdfdfd;
		cursor: pointer;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .25em;
	}
	.filebox .upload-name {
		display: inline-block;
		width: 350px;
		padding: .5em .75em;
		/* label의 패딩값과 일치 */
		font-size: inherit;
		font-family: inherit;
		line-height: normal;
		vertical-align: middle;
		background-color: #f5f5f5;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .25em;
		-webkit-appearance: none;
		/* 네이티브 외형 감추기 */
		-moz-appearance: none;
		appearance: none;
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
              	<p>후기 수정</p>
              </div>

              <div id="content_2_2">
                <div class="innerContent" style="border: 2px solid;">
                  <form id="updateForm" method="post" action="" enctype="multipart/form-data">
                    <fieldset>
                      <table algin="center" class="reviewForm">
							<%-- 
                            <div>
                                <p>${Review.productName}</p>
                            </div>
                            --%>

                            <div>
                                <div><label>제목</label></div>
                                <div><input type="text" class="form-control" name="reviewTitle" value="${ r.reviewTitle }" required></div>
                            </div>
                            
                            <div>
                                <div><label>별점</label></div>
                                <div id="starTd">
                                    <i class="fa-solid fa-star" id="1"></i>
                                    <i class="fa-solid fa-star" id="2"></i>
                                    <i class="fa-solid fa-star" id="3"></i>
                                    <i class="fa-solid fa-star" id="4"></i>
                                    <i class="fa-solid fa-star" id="5"></i>
                                	<input id="reviewGrade" type="hidden" name="reviewGrade">
                                </div>
                                
                                <script>
		
									$(function() {
										
										var reviewGrade1 = Number($("#1").attr('id'));
										var reviewGrade2 = Number($("#2").attr('id'));
										var reviewGrade3 = Number($("#3").attr('id'));
										var reviewGrade4 = Number($("#4").attr('id'));
										var reviewGrade5 = Number($("#5").attr('id'));
										
										$("#starTd>i").click(function() {
											// int reviewGrade 뽑기							
											str = $(this).attr('id'); // id="1", "2", ... -> str
											
											$("#reviewGrade").val(str); // input value 에 str 넣음(String 상태)
											var reviewGrade = Number($("#reviewGrade").val()); // String -> int
											
											// 시각화
											if(reviewGrade == 1) {
												$("#starTd>i").attr('style', 'color:#888888;');
												$("#1").attr('style', 'color:#78C2AD;');
											}
											else if (reviewGrade == 2) {
												$("#starTd>i").attr('style', 'color:#888888;');
												$("#1, #2").attr('style', 'color:#78C2AD;');
											}
											else if (reviewGrade == 3) {
												$("#starTd>i").attr('style', 'color:#888888;');
												$("#1, #2, #3").attr('style', 'color:#78C2AD;');
											}
											else if (reviewGrade == 4) {
												$("#starTd>i").attr('style', 'color:#888888;');
												$("#1, #2, #3, #4").attr('style', 'color:#78C2AD;');
											}
											else if (reviewGrade == 5) {
												$("#starTd>i").attr('style', 'color:#78C2AD;');
											}
										});
									});
								</script>
                            </div>

                            <div>
                                <div><label>내용</label></div>
                                <div><textarea class="form-control" style="resize:none;" name="reviewContent" required>${ r.reviewContent }</textarea></div>
                            </div>

                            <tr>
                                <th><label for="upfile">사진</label></th>
                                <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                            </tr>  
                    </table>  
                    <div align="center" class="btnArea">
                          <button type="submit" class="btn btn-secondary">수정</button>
                          <button type="reset" class="btn btn-light">취소</button>
                    </div>
                  </fieldset>
                </form>
              </div>

         </div>
            </div>
            <div id="content_2_3"></div>
            
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>