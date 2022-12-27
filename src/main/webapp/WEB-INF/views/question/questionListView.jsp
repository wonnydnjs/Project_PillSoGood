<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>1:1 문의내역</title>
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
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* 영섭 작업 영역 시작 */
    #insertInquiry {
        text-align: center;
        height: 100px;
    }

    #insertInquiry>button {
        height: 45px;
        width: 300px;
        margin-bottom: 30px;
    }

    /* 영섭 작업 영역 끝 */

    /* 부트스트랩 페이징 */
    .pagination { justify-content: center; }

    #question_list {
        width: 100%;
    }
    #question_list th, #question_list td {
        text-align: center;
        color: black;
        padding: 15px;
    }
    #question_list>tbody td:hover { cursor: pointer; }
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

                    
					<c:choose>
						<c:when test="${ not empty loginUser }">
							<!-- 영섭 작업 영역 시작 -->
		                    <!-- 문의사항 등록 버튼 -->
		                    <div id="insertInquiry">
		                        <button type="button" class="btn btn-primary" onclick="location.href='enrollForm.qu'">문의사항 등록하기</button>
		                    </div>
		
		                    <!-- 문의 전체 조회 for문 부분 -->
		                    <div>
		                        <table id="question_list" class="table table-hover">
		                            <thead>
		                                <tr>
		                                    <th width="10%;"></th>
		                                    <th width="70%;">제목</th>
		                                    <th width="20%;">등록일</th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                            	<c:choose>
		                            		<c:when test="${ empty list }">
		                            			<tr><th colspan="3">등록하신 문의 내역이 없습니다.</th></tr>
		                            		</c:when>
		                            		<c:otherwise>
		                            			<c:forEach var="q" items="${ list }">
				                            		<tr>
				                            			<input type="hidden" value="${ q.questionNo }">
				                            			<td>
				                            				<c:choose>
					                            				<c:when test="${ empty q.answer }">
					                            					<button type="button" class="btn btn-dark btn-sm disabled">답변대기</button>
					                            				</c:when>
					                            				<c:otherwise>
					                            					<button type="button" class="btn btn-primary btn-sm disabled">답변완료</button>
					                            				</c:otherwise>
				                            				</c:choose>
				                            			</td>
				                            			<td>${ q.questionTitle }</td>
		                                    			<td>${ q.questionDate }</td>
				                            		</tr>
				                            	</c:forEach>
		                            		</c:otherwise>
		                            	</c:choose>
		                            </tbody>
		                        </table>
		                    </div>
		                    <br><br>
		                    
		                    <c:if test="${ not empty list }">
			                    <script>
					            	$(() => {
					            		$("#question_list>tbody>tr").click(function() {
					            			location.href = "detail.qu?qno=" + $(this).children().eq(0).val();
					            		});
					            	});
					            </script>
				            </c:if>
		
		                    <!-- 페이징 -->
		                    <div style="margin-top: 50px;">
		                        <ul class="pagination">
		                        	<c:if test="${ not empty list }">
			                        	<c:choose>
					                		<c:when test="${ pi.currentPage eq 1 }">
					                			<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
					                		</c:when>
					                		<c:otherwise>
					                			<li class="page-item"><a class="page-link" href="list.qu?cpage=${ pi.currentPage - 1 }">&laquo;</a></li>
					                		</c:otherwise>
					                	</c:choose>
					                	
					                	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				                    		<c:choose>
                                    		<c:when test="${ pi.currentPage eq p }">
                                    			<li class="page-item disabled"><a class="page-link" href="list.qu?cpage=${ p }">${ p }</a></li>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<li class="page-item"><a class="page-link" href="list.qu?cpage=${ p }">${ p }</a></li>
                                    		</c:otherwise>
                                    	</c:choose>
					                    </c:forEach>
			                        
			                            <c:choose>
					                		<c:when test="${ pi.currentPage eq pi.maxPage }">
					                			<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
					                		</c:when>
					                		<c:otherwise>
					                			<li class="page-item"><a class="page-link" href="list.qu?cpage=${ pi.currentPage + 1 }">&raquo;</a></li>
					                		</c:otherwise>
					                	</c:choose>
		                            </c:if>
		                        </ul>
		                    </div>
		                    <!-- 영섭 작업 영역 끝 -->
	                	</c:when>
	                	<c:otherwise>
	                		<div align="center" style="margin-bottom:80px;">
		                        
		                        <div style="font-size: large; padding : 50px;">
		                        	<b>1:1 문의 내역은<br>로그인 후 확인하실 수 있습니다.</b>
		                        </div>
		                        
		                        <button type="button" class="btn btn-secondary" style="height: 45px; width: 300px;" onclick="location.href='loginForm.me'">로그인</button>
		                    </div>
	                		
	                	</c:otherwise>
                	</c:choose>
                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

</body>
</html>