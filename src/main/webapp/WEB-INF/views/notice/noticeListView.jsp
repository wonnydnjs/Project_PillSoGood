<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>공지사항</title>
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
	
	#noticeTable>tbody *:hover { cursor : pointer; }
	
    #noticeTable>tbody * {
        height: 70px;
        vertical-align: middle;
    }

    #noticePagination { margin-top: 80px; }
    #noticeTable td { padding-left: 30px; }

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
                    <p>공지사항
                    	<c:choose>
                    		<c:when test="${ loginUser.memberId eq 'admin' }">
                    			<button style="float:right; margin-right: 20px;" onclick="location.href='enrollForm.no'" class="btn btn-primary btn-primary btn-lg">등록</button>	
                    		</c:when>
                    	</c:choose>
                    </p>
                </div>
                <div id="content_2_2">

                    <table class="table table-hover" id="noticeTable" style="color: black;">
                        <tbody>
                        	<c:forEach var="n" items="${ list }">
                        		<tr align="center" width="100%">
                        			<td width="10%">${ n.noticeNo }</td>
                        			<td width="70%">${ n.noticeTitle }</td>
                        			<td width="20%">${ n.noticeDate }</td>
                        		</tr>
                        	</c:forEach>
                           
                        </tbody>
                    </table>
                    
           			<script>
						$(function() {
							
							$("#noticeTable>tbody>tr").click(function() {
								
								location.href='detail.no?nno='+ $(this).children().eq(0).text();
								
							});
							
						});
					</script>

                    <!-- 페이지네이션 -->
                    <div id="noticePagination">
                        <nav aria-label="Page navigation">
                            <ul class="pagination  justify-content-center">
                            
                            	<c:choose>
			                		<c:when test="${ pi.currentPage eq 1 }">
			                			<li class="page-item disabled" ><a class="page-link">&lt;</a></li>
			                		</c:when>
			                		<c:otherwise>
			                			<li class="page-item"><a class="page-link" href="list.no?cpage=${ pi.currentPage - 1 }">&lt;</a></li>	
			                		</c:otherwise>
			                	</c:choose>
			                	
            	                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    				
                    				<c:choose>
                    					<c:when test="${ p eq pi.currentPage }">
                    						<li class="page-item disabled"><a class="page-link"  href="list.no?cpage=${ p }">${ p }</a></li>
                    					</c:when>
                    				
	                    				<c:otherwise>
	                    					<li class="page-item"><a class="page-link" href="list.no?cpage=${ p }">${ p }</a></li>
	                    				</c:otherwise>
                   					</c:choose>
			                    	
			                    </c:forEach>
			                    
			                    <c:choose>
			                		<c:when test="${ (pi.currentPage eq pi.maxPage) or (pi.maxPage eq 0) }">
			                			<li class="page-item disabled" ><a class="page-link">&gt;</a></li>
			                		</c:when>
			                		<c:otherwise>
			                			<li class="page-item"><a class="page-link" href="list.no?cpage=${ pi.currentPage + 1 }">&gt;</a></li>	
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

</body>
</html>