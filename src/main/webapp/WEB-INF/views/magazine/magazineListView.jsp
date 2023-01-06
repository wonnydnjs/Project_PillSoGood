<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- hashtag 소스 다운 -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<!-- hashtag 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />    
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>매거진</title>
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

	/* 매거진 썸네일/제목/해시태그 영역 */
	.thumbnailAll{
		margin-top: 20px;
		display: flex;
		justify-content: space-between;
		flex-wrap: wrap;
		align-items: center;
	}

	.thumbnail {
		width: 32%;
		margin-bottom: 30px; 
		text-align: center;
	}

	.thumbnail:hover { cursor : pointer; opacity : 0.7; }

	.thumbnail>div { margin: auto; }
	.thumbnail>img { margin: auto; object-fit: cover; }
	
	.likeArea {
		padding-bottom: 100px;
		position: relative;
		right: 35%;
	}

	#thumImg { /* 게시글 썸네일 사진 div의 배경사진으로 넣음(img 태그X) */
		width: 300px;
		height: 200px;
		background-size: cover;
		border-radius: 15px;
		z-index: 1;
	}

	#magazineTitle { /* 게시글 제목 */
		font-size: 18px; 
		font-weight: bold; 
		margin: 30px 0px 0px 0px;
		height: 50px;
	}

	.hashtagArea { width: 300px; }

	/* 카테고리 영역 */
	.cont-select { position: relative; width: 140px; }

	.btn-select {
		width: 100%;
		padding: 13px 30px 13px 14px;
		font-size: 14px;
		line-height: 14px;
		background-color: #fff;
		border: 1px solid #C4C4C4;
		box-sizing: border-box;
		border-radius: 10px;
		cursor: pointer;
		text-align: center;
		/* 말줄임 */
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}

	.list-member {
		display: none;
		position: absolute;
		width: 100%;
		border: 1px solid #C4C4C4;
		box-sizing: border-box;
		box-shadow: 4px 4px 14px rgba(0, 0, 0, 0.15);
		border-radius: 10px;
		background-color: white;
		padding-left: 0px;
		z-index: 3;
	}

	.btn-select.on+.list-member { display: block; }

	.list-member li {
		height: 44px;
		padding: 5px 8px;
		box-sizing: border-box;
		list-style:none;
		font-size:15px;
	}

	.list-member li button {
		width: 100%;
		padding: 7px 10px;
		border: none;
		background-color: white;
 		border-radius: 8px;
		cursor: pointer;
		text-align: center;
		/* 말줄임 */
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}

	.list-member li button:hover, .list-member li button:focus {
		background-color: #F3969A;
		opacity:1;
		/* margin-right:100px;*/
	}
	
	.list-member ul { padding-left: 1rem; }

	/* 하단 페이징 바 */
	#pagingArea { margin-top: 80px; }

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
					<p>매거진</p>
				</div>

                <!-- 실제 작업할 영역 -->
                <div id="content_2_2">
                
                	<!-- 관리자로 로그인 했을 때 보이는 등록 버튼 -->
					<c:if test="${ loginUser.memberId eq 'admin' }" >
						<div style="margin-bottom: 10px;">
							<button class="btn btn-primary" style="float:right; margin-right: 25px;" id="enrollFormBtn" onclick="location.href='enrollForm.mag'">등록</button>
							<br clear="both">
						</div>
					</c:if>
                
                	<!-- 카테고리 영역 -->
					<div class="magazineSelect" style="margin-left: 25px;">
						<article class="cont-select">
							<button class="btn btn-outline-secondary btn-select">
								<c:choose>
									<c:when test="${ not empty life }">라이프</c:when>
									<c:when test="${ not empty season }">시즌</c:when>
									<c:when test="${ not empty issue }">이슈</c:when>
									<c:otherwise>전체</c:otherwise>
								</c:choose>
							</button>
								<ul class="list-member">
									<li><button type="button" onclick="location.href='list.mag';">전체</button></li>
									<li><button type="button" onclick="location.href='list.mag?life=1';">라이프</button></li>
									<li><button type="button" onclick="location.href='list.mag?season=2';">시즌</button></li>
									<li><button type="button" onclick="location.href='list.mag?issue=3';">이슈</button></li>
								</ul>
						</article>
					</div>
					<br>

                    <!-- 매거진 썸네일/제목/해시태그 영역 -->
                    <div>
                        <div class="thumbnailAll">
                          	<c:forEach var="mag" items="${ list }" varStatus="i">
								<c:choose>
									<c:when test="${ !empty list }">   		
									<div class="thumbnail" align="center">
										<input type="hidden" name="magazineNo" class="magazineNo" value="${ mag.magazineNo }">
										<input type="hidden" name="magazineCount" class="magazineCount" value="${ mag.magazineCount }"> 

										<div id="thumImg" style="background-image: url('${ mag.magazineImgName }')">
											<!-- <img src="${ mag.magazineImgName }" style="width: 250px; height: 200px;"> -->
											<span class="badge bg-primary" id="categoryBadge${ i.index }" style="margin-top:160px; font-weight: 400;">${ mag.categoryNo }</span>
										</div>

										<p id="magazineTitle">${ mag.magazineTitle }</p>

										<div class="hashtagArea"><span class="badge bg-light">${mag.magazineHashtag}</span></div>
									</div>
									</c:when>

									<c:otherwise>
										<h3>등록된 게시글이 없습니다.</h3>
									</c:otherwise>

								</c:choose>
                           	</c:forEach>
                        </div>
                    </div>

					<!-- 페이지 -->
					<div id="pagingArea">
						<ul class="pagination justify-content-center">
							<c:choose>
								<c:when test="${ pi.currentPage eq 1 }">
										<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
								</c:when>
								<c:otherwise>
								
									<c:choose>
										<c:when test="${ not empty life }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage - 1 }&life=1">&laquo;</a></li>
										</c:when>
										<c:when test="${ not empty season }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage - 1 }&season=2">&laquo;</a></li>
										</c:when>
										<c:when test="${ not empty issue }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage - 1 }&issue=3">&laquo;</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage - 1 }">&laquo;</a></li>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${ not empty life }">
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:choose>
											<c:when test="${ pi.currentPage eq p }">
												<li class="page-item disabled"><a class="page-link" href="list.mag?cpage=${ p }&life=1">${ p }</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="list.mag?cpage=${ p }&life=1">${ p }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:when test="${ not empty season }">
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:choose>
											<c:when test="${ pi.currentPage eq p }">
												<li class="page-item disabled"><a class="page-link" href="list.mag?cpage=${ p }&season=2">${ p }</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="list.mag?cpage=${ p }&season=2">${ p }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:when test="${ not empty issue }">
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">			                    	
										<c:choose>
											<c:when test="${ pi.currentPage eq p }">
												<li class="page-item disabled"><a class="page-link" href="list.mag?cpage=${ p }&issue=3">${ p }</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="list.mag?cpage=${ p }&issue=3">${ p }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:choose>
											<c:when test="${ pi.currentPage eq p }">
												<li class="page-item disabled"><a class="page-link" href="list.mag?cpage=${ p }">${ p }</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link" href="list.mag?cpage=${ p }">${ p }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${ pi.currentPage eq pi.maxPage }">
									<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${ not empty life }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage + 1 }&life=1">&raquo;</a></li>
										</c:when>
										<c:when test="${ not empty season }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage + 1 }&season=2">&raquo;</a></li>
										</c:when>
										<c:when test="${ not empty issue }">
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage + 1 }&issue=3">&raquo;</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="list.mag?cpage=${ pi.currentPage + 1 }">&raquo;</a></li>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
     			</div>
     			<div id="content_2_3"></div>                  
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
	    $(function() {
	        $(".thumbnail").click(function() {      
	        	
	        	var magazinNo = $(this).children().eq(0).val();
	        	
	            location.href = "detail.mag?magazineNo=" + magazinNo;
	        });
	    });
	</script>

	<script>
		const btn = document.querySelector('.btn-select');
		const list = document.querySelector('.list-member');
		
		btn.addEventListener('click', () => {
		    
			btn.classList.toggle('on');
		
		});
		
		list.addEventListener('click', (event) => {
		   
			if (event.target.nodeName === "BUTTON") {
				
		        btn.innerText = event.target.innerText;
		        btn.classList.remove('on');
		    }
		});
	</script>
	
</body>
</html>