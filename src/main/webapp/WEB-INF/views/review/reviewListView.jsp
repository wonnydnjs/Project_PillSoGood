<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>후기</title>
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

	p { margin: 0px; color: black; }

	#best3 { 
		font-size: 25px;
		margin: 0px; 
		padding: 5px 30px; 
	}

	#best3Review {
		/* border: solid black; */
		height: 410px;
	}

	#best3Review>div {
		/* border: solid lightcoral; */
		height: 100%;
		width: 900px;
		margin: auto;
	}

    .bestReview { 
        float: left;
        width: 290px;
		height: 100%;
        border: 1px solid;
        padding: 5px 35px;
        cursor: pointer;
		margin: 0px 3px;
    }

	.bestReview>div {
		width: 220px;
		height: 220px;
		margin: auto;
	}

    .bestReview img { 
		width: 100%; 
		height: 100%; 
		margin: auto;
		object-fit: contain;
	}

	#allR {
		font-size: 20px;
        color: black;
        margin-left: 15px;
        margin-top: 15px;
	}

	table { width: 100%; }

	#allA a { text-decoration: none; color: black; }
	#allA a:hover { color: lightgray; }
    
    #reviewTT { border-bottom: 1px solid lightgray;}
    #reviewTT th, #reviewTT td, table>thead { color: black; padding: 10px 10px; }
    #reviewTT:hover { cursor: pointer; }

    .bestReviewService { font-weight: bold; font-size: 14px; }
    .bestReviewContent, .bestReviewName { font-size: 12px; }

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
                <div id="content_2_1"><p>고객후기</p></div>
                <div id="content_2_2">
					<p id="best3" style="margin-bottom: 20px;">BEST3 후기</p>
                    <div id="best3Review"><!-- 베스트 후기 영역 -->
						<div>
							<c:choose>
	                        	<c:when test="${bestList.size() ne 0}">
									<c:forEach var="b" items="${ bestList }">
										<div class="bestReview">
											<c:choose>
												<c:when test="${b.flist.size()>0}">
													<div style="width:220x; height:220px;"><img src="${ b.flist[0].filePath }${ b.flist[0].changeName }"></div>
												</c:when>
												<c:when test="${b.flist.size()==0}">
													<div style="width:220px; height:220px;"><img src="resources/images/noPictureReview.png"></div>
												</c:when>
											</c:choose>	
											
											<c:forEach begin="1" end="${ b.reviewGrade }">
												<i class="fa-solid fa-star" style="color: #78C2AD;" width="100" height="100" ></i>
											</c:forEach>
											<input type="hidden" value="${ b.reviewNo }">
											<c:choose>
												<c:when test="${b.reviewTitle.length() < 18}">
													<p class="bestReviewService">${ b.reviewTitle }</p>
												</c:when>
												<c:otherwise>
													<p class="bestReviewService">${ fn:substring(b.reviewTitle, 0, 18) }...</p>
												</c:otherwise>												
											</c:choose>
											<c:choose>
												<c:when test="${b.reviewContent.length() < 30}">
													<p class="bestReviewContent">${ b.reviewContent }</p>
												</c:when>
												<c:otherwise>
													<p class="bestReviewContent">${ fn:substring(b.reviewContent, 0, 30) }...</p>
												</c:otherwise>												
											</c:choose>
											<p class="bestReviewName">${ b.memberName }&emsp;${ b.reviewDate }</p>
										</div>
									</c:forEach>
								</c:when>
								<c:when test="${empty bestList}">
									<div align="center">
										<br>
											<p>베스트 리뷰가 없습니다.</p>
										<br>
									</div>
								</c:when>
							</c:choose>
						</div>
					</div>
					<div style="height: 80px;">
						<form method="post" action="enrollForm.re" >
							<div align="right" style="margin-top:18px">
		           				<c:choose>
					            	<c:when test="${ not empty loginUser }">
					            		<input type="hidden" name="memberNo" class="form-control" value="${ loginUser.memberNo }"> 
						            	<button type="submit" class="btn btn-primary">작성하기</button>
						            </c:when>
				            	</c:choose>
							</div>
						</form>
					</div><!-- 베스트 리뷰와 일반 리뷰 사이 간격 --> 
					<div>
						<table id="allA">
							<tr>
								<td width="88%;" id="allR">총 <span style="color: #78C2AD;">${ pi.listCount }</span>건</td>
								<td width="6%;"><a href="list.re?cpage=1&order=new">최신순</a>&ensp;|&ensp;</td>
								<td width="6%;"><a href="list.re?cpage=1&order=hot">조회순</a></td>
							</tr>
						</table>
					</div>	
	            	<div>
	            	
	            		<c:choose>
	                        <c:when test="${list.size() ne 0}">
								<c:forEach var="i" begin="0" end="${ list.size()-1 }"><!-- 일반 리뷰 -->
									<table id="reviewT" align="center">
										<thead height="80px" >
											<tr>
												<input type="hidden" value="${ list[i].reviewNo }">
												<td width="88%" style="font-size: 20px; padding: 10px 10px;"><b>${ list[i].reviewTitle }</b></td>
												<td align="center">
													<c:choose>
														<c:when test="${ not empty loginUser }">
															<c:choose>
																<c:when test="${ loginUser.getMemberId() eq list[i].memberId}">
																	<button class="btn btn-danger btn-delete">삭제</button>
																</c:when>
																<c:when test="${ loginUser.getMemberId() eq 'admin'}">
																	<button class="btn btn-danger btn-delete">삭제</button>
																</c:when>
															</c:choose>
														</c:when>
													</c:choose>
												</td>
											</tr>
										</thead>
										<tbody id="reviewTT" class="reviewT">
											<tr>
												<td>
													<span style="color: #78C2AD;">
														<c:forEach var="j" begin="0" end="${ list[i].reviewGrade -1 }">
															<i class="fa-solid fa-star"></i>
														</c:forEach>
													</span>
												</td>
												<td align="center">${ list[i].reviewDate }</td>
											</tr>
											<tr>
												<c:choose>
													<c:when test="${ list[i].subsStatus eq 'N'}">
														<td>${ list[i].memberName }&emsp;<span style="color: #78C2AD; font-weight: bold;">일시결제</span></td>
													</c:when>
													<c:when test="${ list[i].subsStatus eq 'Y'}">
														<td>${ list[i].memberName }&emsp;<span style="color: #78C2AD; font-weight: bold;">정기결제</span></td>
													</c:when>
													<c:otherwise>
														<td>${ list[i].memberName }&emsp;<span style="color: #78C2AD; font-weight: bold;">정기결제</span></td>
													</c:otherwise>
												</c:choose>
												<td></td>
											</tr>
											<tr height="100px">
												<td>${ list[i].reviewContent }</td>
												<td></td>
											</tr>
											<tr>
												<td>
													<c:forEach var="f" items="${list[i].flist}">
														<img src="${ f.filePath }${ f.changeName }" width="100" height="100" >
													</c:forEach>
												</td>
												<td></td>
											</tr>
											<tr>
												<td><i class="fa-regular fa-comment"></i>&ensp;<span style="color: #78C2AD;">${ list[i].replyCount }</span></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div align="center">
									<br>
										<p>후기가 없습니다.</p>
									<br>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
						
					<!-- 페이지 -->
					<div style="margin-top: 80px;">
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center">
								<c:choose>
									<c:when test="${ pi.currentPage eq 1 }">
										<li class="page-item disabled" ><a class="page-link">&lt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="list.re?cpage=${ pi.currentPage - 1 }&order=${ order }">&lt;</a></li>	
									</c:otherwise>
								</c:choose>
								<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
									<c:choose>
										<c:when test="${ p eq pi.currentPage }">
											<li class="page-item disabled"><a class="page-link"  href="list.re?cpage=${ p }&order=${ order }">${ p }</a></li>
										</c:when>
									
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="list.re?cpage=${ p }&order=${ order }">${ p }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${ (pi.currentPage eq pi.maxPage) or (pi.maxPage eq 0) }">
										<li class="page-item disabled" ><a class="page-link">&gt;</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="list.re?cpage=${ pi.currentPage + 1 }&order=${ order }">&gt;</a></li>	
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</div>
                </div>
                <div id="content_2_3"></div>
			</div>
            <div id="content_3"></div>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>

	<script>
	
		// 베스트 리뷰 상세 조회
		$(function() {
			$(".bestReview").click(function() {
				var rno = $(this).children("input").eq(0).val();
				location.href = "detail.re?rno=" + rno;
			});
		});
		
		// 일반 리뷰 상세 조회
		$(function() {
          	$(".reviewT").click(function() {
				var rno = $(this).parent('table').children('thead').eq(0).children('tr').eq(0).children('input').eq(0).val();
				location.href = "detail.re?rno=" + rno;
          	});
        });
			
		// 리뷰 삭제
    	$(function() {
    		$(".btn-delete").click(function() {
				var rno = $(this).parent('td').parent('tr').children('input').eq(0).val();
    			location.href = "delete.re?rno=" + rno;
    		});
    	});
		
	</script>
</body>
</html>