<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>공지사항 상세</title>
<style>

	div { box-sizing : border-box; }
    body, pre { font-family: 'Noto Sans KR', sans-serif !important; }

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
    
    #noticeContent {
        width : 100%;
        height : 695px;
        resize : none;
        border : none;
    }
    
    #noticePrevNextTable { margin-top: 50px; }
    #noticePrevNextTable:hover { cursor : pointer; }
    #noticeContent:focus { outline : none; }
    
    textarea:focus {
    	outline: none;
    	box-shadow:none;
	}
	
    #content_2 table *, #content_2 pre { color : black; }
    
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
                    <p>공지사항</p>
                </div>
                <div id="content_2_2">
               		<c:if test="${ loginUser.memberId eq 'admin' }">
               			<div style="margin-bottom: 40px;">
	               			<button type="button" class="btn btn-danger" style="float:right;" onclick="postFormSubmit(2);">삭제</button>
	                       	<button type="button" class="btn btn-warning" style="float:right; margin-right: 5px;" onclick="postFormSubmit(1);">수정</button>	
	                       	<br clear="both">
                       	</div>
               		</c:if>
               		
               		<form id="postForm" action="" method="post">
		            	<input type="hidden" name="nno" value="${ n.noticeNo }">
		            </form>
		            
		            <script>
		            	function postFormSubmit(num) {
		            		
		            		if(num == 1) { // 수정하기 버튼 클릭 시 num == 1 : updateForm.bo
		            			
		            			$("#postForm").attr("action", "updateForm.no").submit();
		            		
		            		} else { // 삭제하기 버튼 클릭 시 num == 2 : delete.bo
		            			
		            			$("#postForm").attr("action", "delete.no").submit();
		            			
		            		}
		            	}
		            </script>
                
                    <div>
                       <table class="table">
                          <tbody>
                              <tr align="center">
                                  <td>${ n.noticeNo }</td>
                                  <td width="70%">${ n.noticeTitle }</td>
                                  <td align="right">${ n.noticeDate }</td>
                              </tr>
                          </tbody>
                       </table>
                    </div>
                    <br>

                    <div>
                        <pre style="width:80%; margin: auto;">${ n.noticeContent }</pre>

                        <br>
                        <table class="table table-hover" id="noticePrevNextTable">
                            <tbody>
                            <c:choose>
                            	<c:when test="${ n.nextNo ne 9999 }">
                            		<tr align="center">
	                                    <td>${ n.nextNo }</td>
	                                    <td>${ n.nextTitle }</td>
	                                    <td align="right">${ n.nextDate }</td>
	                                </tr>
                            	</c:when>
                            </c:choose>
                            <c:choose>
                            	<c:when test="${ n.prevNo ne 9999 }">
                            		<tr align="center">
                                    <td>${ n.prevNo }</td>
                                    <td>${ n.prevTitle }</td>
                                    <td align="right">${ n.prevDate }</td>
                                </tr>
                            	</c:when>
                            </c:choose>    
                                
                            </tbody>
                         </table>
                         
                     <script>
                     	const textarea = $("#noticeContent");
                     	const handlesize = ()=> {
                     		textarea.current.style.height = 'auto';
                     		textarea.current.style.height = textarea.current.scrollHeight + 'px';
                     	}
						$(function() {
							
							$("#noticePrevNextTable>tbody>tr").click(function() {
								
								location.href='detail.no?nno='+ $(this).children().eq(0).text();
								
							});
							
						});
					</script>
                    </div>
                    
                    <div align="center" style="margin-top: 50px;">
                        <button type="button" class="btn btn-outline-secondary" onclick="location.href='list.no';" style="width:140px">목록으로</button>
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