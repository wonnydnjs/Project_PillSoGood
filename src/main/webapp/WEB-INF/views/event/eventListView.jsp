<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>이벤트</title>
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
    
    .eventTable * { border : none; }
    .eventStatus { margin-left : 15px; }
    .eventContent { font-size: 0.9em; }
    .eventDate { font-size : 0.8em; }
    .eventLike { font-size : 0.8em; }
	#eventList { color: black; }
    #eventList td { padding-left: 30px; }

    #thum>img {
        object-fit: cover;
        margin: auto;
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
                    <p>이벤트</p>

                    <!-- 관리자일 경우에만 보여지는 등록 버튼 -->
                    <c:if test="${ loginUser.memberId.equals('admin') }" >
                        <button onclick="location.href='enrollForm.ev'" style="float:right; margin-right: 20px; margin-top: 10px;" class="btn btn-primary btn-primary">
                            등록
                        </button>
                    </c:if>
                </div>
                <div id="content_2_2">

                    <c:set var="today" value="<%=new java.util.Date()%>" />
                    <c:forEach var="e" items="${ list }">
	                    <table class="table eventTable" style="cursor:pointer; margin-top: 30px;" id="eventList" onclick="location.href='detail.ev?eno=${ e.evtNo }'">
	                        <thead></thead>
	                        <tbody>
	                        		<tr style="border-top : 1px solid lightgray;" >
		                                <td class="eventTitle" style="padding-top: 20px;" width="80%">
		                                    ${ e.evtTitle }
                                            <c:choose>
                                                <%-- 이벤트 종료 날짜가 오늘 날짜보다 작거나 같다면 이벤트 진행중 --%>
                                                <c:when test="${ today <= e.evtDew}">
                                                    <span class="btn btn-primary btn-sm eventStatus">진행중</span>
                                                </c:when>
                                                <%-- 그게 아니라면 이벤트 종료 --%>
                                                <c:otherwise>
                                                    <span class="btn btn-dark disabled btn-sm eventStatus">종료</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
		                                </td>
		                                <td id="thum" rowspan="4" style="padding-top: 20px; padding-bottom:20px;" width="20%">
		                                    <img src="${ e.evtImgName }" width="250px;" height="250px;" alt="">
		                                </td>
	                            	</tr>
		                            <tr>
		                                <td class="eventContent">${fn:substring(e.evtContent, 0, 40)}...</td>
		                            </tr>
		                            <tr>
		                                <td class="eventDate">${ e.evtStart } ~ ${ e.evtDew }</td>
                                        <input id="eventDew" type="hidden" value="${ e.evtDew}"> 
		                            </tr>
		                            <tr style="border-bottom : 1px solid lightgray;">
		                                <td class="eventLike" style="padding-bottom: 20px;">
		                                    <img src="resources/images/Like.png" width="15" alt="">
		                                    <span id="countLike">${ e.evtLikeCount }</span>
		                                </td>
		                            </tr>
	                        </tbody>
	                    </table>
                    </c:forEach>
                </div>
                
                <!-- 페이지네이션 -->
                <div id="noticePagination" style="margin-top: 80px;">
                   	<ul class="pagination  justify-content-center">
                    	<c:choose> 
                    		<c:when test="${ pi.currentPage eq 1 }">
                    			<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="page-item"><a class="page-link" href="list.ev?cpage=${ pi.currentPage - 1 }">&lt;</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    	
                    	<c:forEach var="e" begin="${ pi.startPage }" end="${ pi.endPage }">
                    		<li class="page-item"><a class="page-link" href="list.ev?cpage=${ e }">${ e }</a></li>
                    	</c:forEach>
                    	
                    	<c:choose>
                    		<c:when test="${pi.currentPage eq pi.maxPage }">
                    			<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="page-item"><a class="page-link" href="list.ev?cpage=${ pi.currentPage + 1 }">&gt;</a></li>
                    		</c:otherwise>
                    	</c:choose>
                       </ul>
                </div>

				<div id="content_2_3"></div>
            </div>

            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>