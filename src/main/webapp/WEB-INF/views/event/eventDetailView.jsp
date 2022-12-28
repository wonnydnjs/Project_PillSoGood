<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>이벤트 상세</title>
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

    table { color: black; width: 100%; }

    #reply_reply textarea {
        resize:none; 
        outline:none; 
        border:none; 
        margin-top: 20px;
        margin-bottom: 20px;
        margin-left: 20px;
        margin-right: 20px;
        width: 80%; 
        height: 100px;
        float: right;
    }
    
    #replyTable { width: 100%; }

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
                    <p>이벤트
                    	<c:if test="${ loginUser.memberId.equals('admin') }" >
                        	<button style="float:right; margin-right: 20px;" class="btn btn-primary btn-danger" onclick="location.href='delete.ev?eno=${ e.evtNo }&evtImgName=${ e.evtImgName }'">삭제</button>
                        	<button style="float:right; margin-right: 5px;" class="btn btn-primary btn-warning" onclick="location.href='updateForm.ev?eno=${ e.evtNo }&evtImgName=${ e.evtImgName }'">수정</button>
                    	</c:if>
                    </p>
                </div>
                <div id="content_2_2">
                    
                    <br clear="both"/>
					
					<!-- 이벤트 제목 부분 -->
                    <div>
						<table class="table" style="color:black">
						<tbody>
							<tr>
								<td class="EventTitleArea">${ e.evtTitle }</td>
								<td align="right">
									<span class="eventStart">${ e.evtStart }</span> ~
									<span class="eventDewDate">${ e.evtDew }</span>
								</td>
							</tr>
						</tbody>
						</table>
                    </div>
					
					<!-- 이벤트 좋아요 -->
                    <!-- 로그인한 유저가 좋아요 버튼이 보여야함  -->
                    <c:if test="${ not empty loginUser  }">
                    	<div align="right" id="like_con">
                    	<c:choose>
	                    		<%-- 로그인유저의 memberNo과 이벤트 라이크 객체의 memberNo이 같다면 좋아요 누른 사람 --%>
		                    	<c:when test="${ loginUser.memberNo eq el.memberNo  }"> 

		                    		<%-- 좋아요 버튼이 눌려있다면 눌려있는 표시로 보여줘 --%>
		                    		<img src="resources/images/Like.png" width="25" class="likeControl"  id="eventLike" style="cursor: pointer;" >
			                        
			                        <%-- 좋아요 버튼이 안눌렸으면 안누른 표시로 보여줘 --%>
			                        <img src="resources/images/Unlike.png" width="25" alt="" style="display:none" class="likeControl" id="eventUnLike" style="cursor: pointer;">
			                        <span id="evnetLikeCount">${ e.evtLikeCount }</span>
			                    </c:when>
			                    <c:otherwise>
			                    <%-- 로그인 유저의 memberNo과 이벤트 객체의 memberNo이 같지 않다면 좋아요 안누른 사람임 --%>
			                    	
			                    	<%-- 좋아요 버튼 안누른 상태가 먼저 보이고, 누르면 insert, 거기서 한번더 누르면 delete 해줘 --%>
			                    	<img src="resources/images/Unlike.png" width="25" alt="" class="likeControl" id="eventUnLike" style="cursor: pointer;">
			                        <img src="resources/images/Like.png" width="25" class="likeControl" style="display:none" id="eventLike" style="cursor: pointer;">
			                        <span id="evnetLikeCount">${ e.evtLikeCount }</span>
			                    </c:otherwise>
		                    </c:choose>
                    	</div>
                    </c:if>
           

                    <br clear="both">
                    
					<!-- 첨부파일 -->
                    <div align="center">
						<c:choose>
							<c:when test="${ empty e.evtImgName }">
								첨부파일이 없습니다.
							</c:when>
							<c:otherwise>
								<img src="${ e.evtImgName }" width="500" alt="">
							</c:otherwise>
						</c:choose>
                    </div>
					
					<!-- 글 내용 -->
                    <div align="center" style="width: 100%; height:auto; text-align: left; padding-bottom: 50px; padding-top: 50px;">
                         ${ fn:replace(e.evtContent, newLine, "<br>") }
                    </div>

                    <hr>

					<!-- 댓글 -->
					<c:set var="today" value="<%=new java.util.Date()%>" />
                    <div align="center">
                        <table>
                        	<c:choose>
                        		<%-- 로그인 전 --%>
                        		<c:when test="${ empty loginUser }"> 
                        			<td>
		                                <textarea class="form-control" name="" id="replyContentArea1" style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용해주세요.</textarea>
		                            </td>
		                            <td width="10%" align="center">
		                                <button style="display:inline-block; margin-left: 10px;" class="btn btn-primary align-middle" disabled>작성하기</button>
		                            </td>
                         		</c:when> 
								<%-- 이벤트 종료면 댓글 작성 못함 --%>
								<c:when test="${ today > e.evtDew }">
									<td>
		                                <textarea class="form-control" name="" id="replyContentArea1" style="resize:none; width:100%;" readonly>종료된 이벤트입니다.</textarea>
		                            </td>
		                            <td width="10%" align="center">
		                                <button style="display:inline-block; margin-left: 10px;" class="btn btn-primary align-middle" disabled>작성하기</button>
		                            </td>
								</c:when>

                        		<%-- 로그인 후 --%>
                        		<c:otherwise>
		                            <td>
		                                <textarea class="form-control" name="evtReply" id="replyContentArea" style="resize:none; width:100%;"></textarea>
		                            </td>
		               
                                    <td style="vertical-align: bottom;" width="5%" align="center">
                                    	&ensp;
                                    	<span id="textCount">0</span>/<span id="rcount" style="color: #78C2AD;">100</span>
                                    </td>
		                            <td width="10%" align="center">
		                                <button style="display:inline-block; margin-left: 10px;" class="btn btn-primary align-middle" onclick="addReply();">작성하기</button>
		                            </td>
                            	</c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    
                    <hr>

					<!-- 댓글이 달리는 부분 -->
                    <div id="replyArea" align="center"></div>
                    
                    <div align="center" style="margin-top: 50px;">
                        <button type="button" class="btn btn-outline-secondary" onclick="location.href='list.ev';">목록으로</button>
                    </div> 

                    <script>

                 		var parentNo;
                 		
                        $(function() {
                        	selectReplyList();
                        	
                        	// 대댓글 나오는 스트립트
                            
                            $("#replyArea").on("click", ".comm", function(e){
                            	
                                parentNo=$(e.currentTarget).children().first().val(); //댓글 넘버 
                                /* console.log(parentNo);
                                console.log(e.currentTarget); */
                                
                                $(e.target).parent().siblings('.nested_reply_container').toggle();
                                
                            });
                        });
                        
                        function selectReplyList() { // 해당 게시글의 댓글 리스트 조회용 ajax 
                        	
                        	$.ajax({
                        		url : "rlist.ev",
                        		data : {eno: ${ e.evtNo }},
                        		success : function(result) {
                        			
                        			var resultStr = "";
                      				
                        			if(result.length > 0) {

                        				for(var i = 0; i < result.length; i++) {
                            				
                            				if ( result[i].parentReply == 0 ) { // 부모댓글이 0이면 대댓글 작성 가능 
                            					
    	                        				resultStr += "<table class='comm' id='replyTable'>"
    	                            							+ "<input type='hidden' value="+result[i].replyNo +">"
    		                        							+ "<tr>"
    			                        				              + "<td class='replyWriters' width='80%' style='padding-left: 60px; padding-top:20px; font-weight: bold;'>"
    			                                        			  + result[i].memberName
    			                                        			  +	"</td>"
    			                                        			  + "<td class='replyCreateDates' colspan='2' width='20%' style='padding-top: 20px; padding-left: 30px;' align='center'>"
    			                                        			  + result[i].replyDate
    			                                        		      + "</td>"
    		                                        		  	 + "</tr>"
    		                                        		  	 + "<tr style='border-bottom : 1px solid lightgray;'>"
    		                                        		          + "<td class='replyContents' style='padding: 30px; padding-left: 60px;'><pre style='white-space: pre-line;'>"
    		    	                                    			  + result[i].replyContent
    		    	                                    	          + "</pre></td>";
    		    	                                    	        
    		    	                                    	          if(("${ loginUser.memberName }" == result[i].memberName) || ("${loginUser.memberName}" == '관리자') ) {
    			    	                                    	          
    				    	                                			resultStr += "<td align='center'>"
    				    	                                							+ "<button class='btn btn-danger btn-sm' onclick='deleteReply("+ result[i].replyNo + ")'>삭제</button>"
    				    	                                				  		+ "</td>";
    		    	                                    	          }
    		    	                                				  
													resultStr += "</tr>"
															+ "<tr class='nested_reply_container' style='display:none; background-color: #78c2ad36;'>"                                   
																	+ "<td align='center' id='reply_reply' width='80%'>"
																		+ "<textarea class='form-control' name='nReplyContent' placeholder='대댓글남기기' maxlength='500' id='NestedreplyContents"+ result[i].replyNo  +"'></textarea>"
																	+ "</td>"
																	+ "<td width='20%'>"
																		+ "<input type='button' value='등록' class='btn btn-primary' onclick='addNestedReply("+ result[i].replyNo + ")'; style='float:left; margin-top: 20px; margin-bottom: 20px;'>"
																	+ "</td>"
															+ "</tr>"
														+ "</table>";
													
														} else { // 부모댓글이 0이 아니면 대댓글 작성 불가능 
														resultStr += "<table class='comm' id='replyTable'>"
															+ "<input type='hidden' value="+ result[i].replyNo +">"
															+ "<tr>"
																	+ "<td width='30' style='padding-left:100px;'>ㄴ</td>"
																	+ "<td class='replyWriters' width='80%' style='padding-left: 30px; padding-top:20px; font-weight: bold;'>"
																	+ result[i].memberName
																	+	"</td>"
																	+ "<td class='replyCreateDates' colspan='2' width='20%' style='padding-top: 20px; padding-left: 15px;'>"
																	+ result[i].replyDate
																	+ "</td>"
																+ "</tr>"
																+ "<tr style='border-bottom : 1px solid lightgray;'>"
																	+ "<td colspan='3' class='replyContents'style='padding: 30px; padding-left: 100px;'><pre style='white-space: pre-line;'>"
																	+ result[i].replyContent
																	+ "</pre></td>";
																	
																	
																	if(("${ loginUser.memberName }" == result[i].memberName) || ("${loginUser.memberName}" == '관리자')) {
																		
																	resultStr += "<td>"
																					+"<button onclick='NestedDeleteReply("+ result[i].replyNo +");' style='margin-left: 15px;' class='btn btn-danger btn-sm'>삭제</button>"
																				+ "</td>";
																	}
    		    	                                    	          
    		    	                                  resultStr +=  "</tr>"
    		    	                            			  	
    		    	                                        + "</table>" 
        	                                          } 
                        					}
                        					
                        				$("#replyArea").html(resultStr);
                        			
                        			} else {
                        				$("#replyArea").html("<h4 style='padding-top: 50px; color: lightgrey;'>작성된 댓글이 없습니다.</h4>");
                        				
                        			}
                        		},
                        		error : function() {
                        			console.log("댓글리스트 조회용 ajax 통신 실패!");
                        		}
                        	});
                        }
                        
	                     // 댓글 작성 글자수 체크
	  	          	      $("#replyContentArea").keyup(function (e) {
	  	          	      	var textAreaContent = $(this).val();
	  	          	          
	  	          	      	// console.log(textAreaContent);
	  	          	          // 글자수 세기
	  	          	          $("#textCount").text(textAreaContent.length);
	  	          	         
	  	          	          // 글자수 제한
	  	          	          if (textAreaContent.length > 100) {
	  	          	          	// 100자 부터는 타이핑 되지 않도록
	  	          	              $(this).val($(this).val().substring(0, 100));
	  	          	          	  $('#textCount').html("100").css('color', '#78C2AD');
	  	          	              $('#rcount').html("100");
	  	          	          	  
	  	          	          };
	  	          	      });
                        
                        
                        function addReply() { // 댓글 작성 요청용 ajax
                    		
                    		if($("#replyContentArea").val().trim().length != 0) {
                    			
                    			$.ajax({
                    				url : "rinsert.ev",
                    				data : { 
                    					evtNo: ${ e.evtNo },
                    					memberNo: "${ loginUser.memberNo }",
                    					replyContent:$("#replyContentArea").val()
                    				},
                    				success : function(result) {
                    					
                    					if(result == "success") {
                    						
                    						// 댓글 작성 성공 시 새로이 댓글 리스트를 불러올것
                    						selectReplyList();
                    			
                    						// 댓글 작성 창 초기화효과
                    						$("#replyContentArea").val("");
                    						$("#textCount").html(0);
                    					}
                    				},
                    				error : function() {
                    					console.log("댓글 작성 실패");
                    				}
                    			});
                    		} else {
                    			alertify.alert("댓글 작성 실패", "댓글 작성 후 등록을 요청해주세요.");
                    		}
                    	}
                        
                        
                        function addNestedReply(replyNo) { // 대댓글 작성 
                     		
                        	if($("#NestedreplyContents"+replyNo).val().trim().length != 0) {
                        		
                        		$.ajax ({
                            		url : "nrinsert.ev",
                            		data : { 
                            			evtNo: ${e.evtNo},
                            			memberNo: "${loginUser.memberNo}",
                            			parentReply: replyNo,
                            			replyContent: $("#NestedreplyContents"+replyNo).val()
                            		},
                            		success : function(result) {  
                            			
                            			if(result == "success") {
                            				
                            				selectReplyList();
                            				
                            				$("#nReplyContentArea").val("");
                            			}
                            		},
                            		error : function() {
                            			console.log("댓글 작성 실패");
                            		}
                            	});
                        	} else {
                        		console.log("댓글 작성 실패");
                        	} 
                        }
                        
                        
                        
                        function NestedDeleteReply(replyNo) { // 대댓글 삭제
                        	
                        	if (window.confirm("정말 삭제하시겠습니까?")) {
                        		
                        		$.ajax({
                        			url : "nrdelete.ev",
                        			data : {
                        				replyNo : replyNo
                        			},
                        			success : function (result) {
                        				
                        				if(result == "success") {
                        					
                        					selectReplyList();
                        				}
                        			},
                        			error : function () {
                        				console.log("댓글 삭제 실패");
                        			}
                        		});
                        	}
                        }
                        
                        
                        function deleteReply(replyNo) { // 댓글 삭제 요청용 ajax
                        	
                        	if(window.confirm("정말 삭제하시겠습니까?")) {
                        		
	                        	$.ajax({
	                        		url : "rdelete.ev",
	                        		data : {
	                        			replyNo : replyNo
	                        		},
	                        		success : function(result) {
	                        			
	                        			if(result == "success") {
	                        				
	                        				selectReplyList();
	                        			}
	                        		},
	                        		error : function() {
	                        			
	                        			console.log("댓글 삭제 실패");
	                        		}
	                        	});
                        	}
                        }
                        
                        
                        // 좋아요 추가, 삭제 
                        $(function() {
                            $("#like_con").on("click", ".likeControl", function() {
								if($("#eventLike").css("display") == "none") {
									
									$.ajax ({ // 좋아요 추가 
										
										url : "insert.el",
										data : { evtNo : ${e.evtNo},
											     memberNo : ${loginUser.memberNo}
										},
										success : function (result) {
											console.log("좋아요 성공");
											
											$("#eventLike").show();
											$("#eventUnLike").hide();
											
											
											console.log(result);
											$("#evnetLikeCount").html(result);
											
											

										},
										error : function () {
											console.log("좋아요 실패");
										}
										
									});
									
								} else { // 좋아요 삭제 
									$.ajax ({
										
										url : "delete.el",
										data : { evtNo : ${e.evtNo},
											     memberNo : ${loginUser.memberNo}},
										success : function (result) {
											console.log("좋아요 삭제 성공");
											
											$("#eventLike").hide();
											$("#eventUnLike").show();
											console.log(result);
											$("#evnetLikeCount").html(result);
										},
										error : function() {
											console.log("좋아요 삭제 실패");
										}
									});
								}
                            });
                        });
                    </script>

                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
		<jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>