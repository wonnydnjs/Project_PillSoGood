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
    <title>후기 등록</title>
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

    #content { height: auto; display: flex; }
    #content_2>div { width: 100%; float: left; }
    #content_2_1 { height: 115px; }
    #content_2_2 { height: auto; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        font-weight: bold;
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

	label {
		font-weight: bold;
        font-size: large;
		color: black;
		padding: 5px 0px;
	}

	#btnDiv { text-align: center; margin-top: 60px;}

	#btnDiv button {
		height: 45px;
        width: 200px;
        margin: auto;
	}

    #title {
        width: 900px;
        box-sizing: border-box;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    #content{
        margin-top: 10px;
        margin-bottom: 10px;
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
        <div id="navigator2">
			<jsp:include page="../common/menubar.jsp" />
		</div>
        <div id="header"></div>
        <div id="content">
            <div id="content_1"></div>
            <div id="content_2">
              	<div id="content_2_1"><p>후기 작성</p></div>
              	<div id="content_2_2">
					<div class="innerContent">
						<form id="enrollForm" method="post" action="insert.re" enctype="multipart/form-data">
							<div algin="center" class="reviewForm">
								<div>
									<div>
										<select id="orderNoChange" class="form-select" name="orderNo">
											<option value="null">후기를 작성할 상품 목록을 선택해주세요.</option>
											<c:forEach var="Review" items="${rOrderList}">
												<option value="${Review.orderNo}">${Review.productName}</option>
											</c:forEach>
										</select>
										<script>
											$(document).ready(function() {
												$("#orderNoChange").change(function() {
													$("#orderNoValue").val($(this).val());
												});
											});
										</script>
									</div>
								</div>
								<div>
									<div id="titlee"><label for="title">제목</label></div>
									<div><input type="text" class="form-control" name="reviewTitle" id="reviewTitle" placeholder="후기 제목을 입력해주세요 (30자 이내)" maxlength="30" required></div>
								</div>
								<br>
								<div>
									<div><label>별점</label></div>
									<div id="starTd">
										<i class="fa-solid fa-star" id="1" style="color: #78C2AD;"></i>
										<i class="fa-solid fa-star" id="2"></i>
										<i class="fa-solid fa-star" id="3"></i>
										<i class="fa-solid fa-star" id="4"></i>
										<i class="fa-solid fa-star" id="5"></i>
										<input id="reviewGrade" type="hidden" name="reviewGrade" value="1">
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
								<br>
								
								<div>
									<div><label for="content">내용</label></div>
									<div><textarea class="form-control" cols="20" rows="15" style="resize:none;" name="reviewContent" placeholder="후기 내용을 입력해주세요 (1000자 이내)" maxlength="1000" required></textarea></div>
								</div>
								<br>

								<div data-name="fileDiv" class="form-group filebox bs3-primary">
									<label for="file_0" class="col-sm-2 control-label">사진</label>
									<div class="col-sm-10">
										<input type="text" class="upload-name" value="썸네일 사진을 등록해주세요." style="color: gray;" readonly />
										<label for="file_0" class="control-label" style="background-color: #6cc3d5; border: none;">찾아보기</label>
										<input type="file" name="upfile" id="file_0" class="upload-hidden" onchange="changeFilename(this)" />
									
										<button type="button" onclick="addFile()" class="btn btn-outline-primary">
											<i class="fa fa-plus" aria-hidden="true"></i>
										</button>
										<button type="button" onclick="removeFile(this)" class="btn btn-outline-secondary">
											<i class="fa fa-minus" aria-hidden="true"></i>
										</button>
									</div>
								</div>
								<br>
								
								<div id="btnDiv" align="center">
									<input type="hidden" name="orderNo" class="form-control" value="1">
									<button type="submit" class="btn btn-primary" onclick="toAdminSocketMsg();">등록하기</button>
									<button type="button" class="btn btn-secondary" onclick="history.back();">뒤로가기</button>
								</div>
								
								<script>
														
									let fileIdx = 0;

									function addFile() {
										
										/*
											파일 개수 제한할 때 필요
											const fileDivs = $('div[data-name="fileDiv"]');
											if (fileDivs.length > 2) {
												alert('파일은 최대 세 개까지 업로드 할 수 있습니다.');
												return false;
											}
										*/

										fileIdx++;
										
										var fileHtml = "";
										fileHtml += "<div data-name='fileDiv' class='form-group filebox bs3-primary'>"
													+ "<label for='file_"+fileIdx+"' class='col-sm-2 control-label'></label>"
													+ "<div class='col-sm-10'>"
														+ "<input type='text' class='upload-name' value='세부 사진을 등록해주세요.' style='color: gray;' readonly />"
														+ "<label for='file_"+fileIdx+"' class='control-label' style='background-color: #6cc3d5; border: none;'>찾아보기</label>"
														+ "<input type='file' name='upfile' id='file_"+fileIdx+"' class='upload-hidden' onchange='changeFilename(this);' />"
														+ "<button type='button' onclick='removeFile(this)' class='btn btn-outline-secondary'>"
														+ "<i class='fa fa-minus' aria-hidden='true'></i>"
														+ "</button>"
													+ "</div>"
												+ "</div>";
										$('#btnDiv').before(fileHtml);
									}

									function removeFile(elem) {

										const prevTag = $(elem).prev().prop('tagName');
										if (prevTag === 'BUTTON') {
											const file = $(elem).prevAll('input[type="file"]');
											const filename = $(elem).prevAll('input[type="text"]');
											file.val('');
											filename.val('파일 찾기');
											return false;
										}

										const target = $(elem).parents('div[data-name="fileDiv"]');
										target.remove();
									}

									function changeFilename(file) {

										file = $(file);
										const filename = file[0].files[0].name; // pill14.png
										
										const target = file.prevAll('input');
										target.val(filename);
									}
									
									var reviewTitle = "";
									function toAdminSocketMsg() {
										
										reviewTitle = $("#reviewTitle").val();
										
										if(socket) {
											
											let socketMsg = "review"+","+"${ loginUser.memberId },"+"admin," + "bno," + reviewTitle;
											selectAlarmList();
											socket.send(socketMsg);
										}
										
										
										
										$.ajax({
											url : "insertReview.alarm",
											data : {
												
												alarmContent : "${loginUser.memberId} 님이 리뷰를 작성하셨습니다.",
												fromId : "${loginUser.memberId}",
												toId : "admin"
												
											},
											success : function(result) {
												
												selectAlarmList();
												
											},
											error : function() {
												console.log("reviewEnroll.jsp ajax failure");
											}
											
											
											
										});
										
									}
									
								</script>
							</div>  
						</form>
					</div>
				</div>
				<div style="height: 150px"></div>
			</div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
</body>
</html>