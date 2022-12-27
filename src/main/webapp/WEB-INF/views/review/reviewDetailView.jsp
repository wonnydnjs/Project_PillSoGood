<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
    <title>후기 상세</title>
<style>

    div { 
        box-sizing : border-box;
        /* border: 1px solid #78C2AD; */ 
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { height : auto; display: flex; }
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
    #content>div { height : auto; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body, pre { font-family: 'Noto Sans KR', sans-serif !important; }

    .btnArea { padding: 15px 0px; }

    .pillCart {
        width: 290px;
        height: 200px;
        float: left;
        margin-right: 10px;
        border-radius: 15px;
    }

    .pillCart p {
        padding-bottom: 0;
        display: inline;
    }

    .pPic {
        margin-left: 65%;
        display: inline;
    }

    .pContent {
        margin-left: 7%;
        position: relative;
        top: 7%;
    }

    .pName {
        margin-left: 7%;
        position: relative;
        bottom: 66px;
    }

    .pCounts {
        margin-left: -108px;
        position: relative;
        bottom: 26px;
        color: rgb(104, 104, 104);
    }
    
    .pAmount {
        margin-left: -38px;
        position: relative;
        bottom: -11px;
    }

    .cartBtn {
        position: relative;
        margin-left: 15%;
        bottom: -20px;
        width: 200px;
        height: 40px;
        background-color: white;
        font-size: 12px;
        border-radius: 10px;
        border-color: white;
    }

    .moreBtn {
        position: relative;
        width: 140px;
        height: 35px;
        background-color: white;
        color: rgba(34, 34, 34, 0.779);
        font-size: 13px;
        border-radius: 10px;
        border-color: rgba(34, 34, 34, 0.208);
        margin-left: 40%;
    }

    .moreBtnArea {
        position: relative;
        bottom: -100px;
    }
    .replyName{
        display: inline;
        color: black;
    }

    #enrollBtn {
        position: relative;
        bottom: -80px;
        left: 1050px;
    }

    .listBtnArea { width: 140px; margin: auto; margin-top: 20px; }
    
    .replyContent {
        color: black;
    }

    #rep, #rep2 {
        font-size: 18px;
        color: black;
        margin-left: 15px;
        margin-top: 15px;
    }

    table { width: 100%; color: black; }

    #memRev, #morePro { width: 50%; float: left; }

    #memRev>p {
        margin: 0px;
        padding: 16px 30px;
        color: black;
    }

    #morePro { padding: 10px 30px; }
    
    /* 샛별 상품 목록 스타일 */
    .product>div {
        width: 33.3%; 
        height: 200px; 
        float: left;
        padding: 15px;
    }

    .product>div { 
        width: 33.3%; 
        height: 200px; 
        float: left;
        padding: 15px;
    }

    .product>div>div { 
        width: 100%;
        height: 100%;
        float: left; 
        border-radius: 15px;
    }

    .product>div>div>div { width: 100%; float: left; }

    #productT { height: 65%; }
    #productP { height: 35%; }

    #productT>div { height: 100%; float: left; }
    #productTT { width: 60%; }
    #productPP { width: 40%; }

    #productPP>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
    }

    #productTT>div { width: 100%; height: 33.3%; float: left; }
    
    #productTT p { margin: 0px; margin-left: 20px; color: black; }
    #productTT_1>p { font-size: 15px; line-height: 55px; }
    #productTT_3>p { font-size: 15px; line-height: 45px; }
    #productTT_2>p { font-size: 20px; line-height: 50px; font-weight: bold; }

    #productP>p {
        font-size: 20px;
        font-weight: bold;
        color: black;
        margin-left: 20px;
        line-height: 40px;
    }

    .prodback0 { background-color: #fef7f8; }
    .prodback1 { background-color: #f9faf0; }
    .prodback2 { background-color: #faf4f1; }
    .prodback3 { background-color: #fef6ec; }
    .prodback4 { background-color: #edf7fd; }
    .prodback5 { background-color: #fef5f4; }
    .prodback6 { background-color: #fbf7fd; }
    .prodback7 { background-color: #e9f7f5; }
    .prodback8 { background-color: #f9f9f9; }
    
	.reviewImg {
        object-fit: contain;
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
                <div id="content_2_1"><p>고객후기</p></div>
                <div id="content_2_2" >
                    <div class="btnArea" align="right">
                        <div>
                        	<c:choose>
								<c:when test="${ not empty loginUser }">
									<c:choose>
										<c:when test="${ loginUser.getMemberId() eq r.memberId}">
											<button type="submit" class="btn btn-danger btn-delete" onclick="location.href='delete.re?rno=${ r.reviewNo }'">삭제</button>
										</c:when>
										<c:when test="${ loginUser.getMemberId() eq 'admin'}">
											<button class="btn btn-danger btn-delete">삭제</button>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
                        </div>
                    </div>

                    <!-- 리뷰 상세 본문 -->
                    <div class="reviewDetailArea">
                        <table class="reviewDetail" style="border-top: 1px solid lightgray;">
                            <tr>
                            	<td><p style="font-size: 25px; margin-top: 10px;"><b>${r.reviewTitle}</b></p></td>
                            </tr>
                            <tr height="50px">
                                <td>
                                    <c:forEach var="p" items="${pList}">
                                        <b>${p.productName}&nbsp;</b>
                                    </c:forEach>
                                </td>
                                <td></td>
                            </tr>
                            <tr height="30px">
                                <td>
                                    <span style="color: #78C2AD;">
                                            <c:forEach var="j" begin="0" end="${ r.reviewGrade -1 }">
                                                <i class="fa-solid fa-star"></i>
                                            </c:forEach>
                                    </span>                                     
                                </td>
                                <td width="10%">${r.reviewDate}</td>
                            </tr>
                            <tr height="50px">
                                <c:choose>
                                    <c:when test="${ r.subsStatus eq 'N'}">
                                        <td>
                                            ${ r.memberName }&ensp;<span style="color: #78C2AD; font-weight: bold;">일시결제</span>&ensp;
                                        </td>
                                    </c:when>
                                    <c:when test="${ r.subsStatus eq 'Y'}">
                                        <td>
                                            ${ r.memberName }&ensp;<span style="color: #78C2AD; font-weight: bold;">정기결제</span>&ensp;
                                        </td>
                                    </c:when>
                                    <c:otherwise>
										<td>${ r.memberName }&emsp;<span style="color: #78C2AD; font-weight: bold;">정기결제</span></td>
									</c:otherwise>
                                </c:choose>
                                <td></td>
                            </tr>
                            <tr height="100px">
                                <td><pre style="white-space: pre-line;">${ r.reviewContent }</pre></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <c:forEach var="f" items="${r.flist}">
                                        <img class="reviewImg" src="${ f.filePath }${ f.changeName }" width="200" height="200" >
                                    </c:forEach>
                                </td>
                                <td></td>
                            </tr>
                            <tr height="50px">
                                <td>조회수&ensp;<span style="color: #78C2AD;">${ r.reviewCount}</span></td>
                                <td></td>
                            </tr>
                        </table>
                    </div>

                    <div style="border-top: 1px solid lightgray;">
                        <div id="memRev"><p><span style="color: #F3969A;">${ r.memberName }</span>님의 후기 상품이에요!</p></div>
                        <div id="morePro" align="right"><button type="button" class="btn btn-outline-primary" onclick="location.href='list.pr';">더 많은 제품 보러가기</button></div>
                    </div>

                    <div class="product">
                   		<c:choose>
	                   		<c:when test="${pList.size() <= 3}">
		                        <c:forEach var="p" begin="0" end="2" items="${pList}">
		                            <div id="product_1">
		                                <div id="product_1_1" class="prod" style="cursor:pointer;">
		                                    <div id="productT">
		                                        <div id="productTT">
		                                            <input type="hidden" value="${ p.productNo }">
		                                            <div id="productTT_1"><p>${ p.productExplain }엔</p></div>
		                                            <div id="productTT_2"><p>${ p.productName }</p></div>
		                                            <div id="productTT_3"><p>30일분</p></div>
		                                        </div>
		                                        <div id="productPP"><img style="height: 100px; width: 100px;" src="${ p.productImgPath }"></div>
		                                    </div>
		                                    <div id="productP">
		                                        <p><fmt:formatNumber value="${ p.productPrice }" pattern="#,###.##"/>원</p>
		                                    </div>
		                                </div>
		                            </div>
		                        </c:forEach>
	                        </c:when>
	                        <c:when test="${pList.size() > 3}">
		                        <c:forEach var="p" begin="0" end="2" items="${pList}">
		                            <div id="product_1">
		                                <div id="product_1_1" class="prod" style="cursor:pointer;">
		                                    <div id="productT">
		                                        <div id="productTT">
		                                            <input type="hidden" value="${ p.productNo }">
		                                            <div id="productTT_1"><p>${ p.productExplain }엔</p></div>
		                                            <div id="productTT_2"><p>${ p.productName }</p></div>
		                                            <div id="productTT_3"><p>30일분</p></div>
		                                        </div>
		                                        <div id="productPP"><img style="height: 100px; width: 100px;" src="${ p.productImgPath }"></div>
		                                    </div>
		                                    <div id="productP">
		                                        <p><fmt:formatNumber value="${ p.productPrice }" pattern="#,###.##"/>원</p>
		                                    </div>
		                                </div>
		                            </div>
		                        </c:forEach>
		                        <c:forEach var="p" begin="3" items="${pList}">
		                            <div id="product_2" class="hiddenProduct" style="display:none;">
		                                <div id="product_1_1" class="prod" style="cursor:pointer;">
		                                    <div id="productT">
		                                        <div id="productTT">
		                                            <input type="hidden" value="${ p.productNo }">
		                                            <div id="productTT_1"><p>${ p.productExplain }엔</p></div>
		                                            <div id="productTT_2"><p>${ p.productName }</p></div>
		                                            <div id="productTT_3"><p>30일분</p></div>
		                                        </div>
		                                        <div id="productPP"><img style="height: 100px; width: 100px;" src="${ p.productImgPath }"></div>
		                                    </div>
		                                    <div id="productP">
		                                        <p><fmt:formatNumber value="${ p.productPrice }" pattern="#,###.##"/>원</p>
		                                    </div>
		                                </div>
		                            </div>
		                        </c:forEach>
		                        <div style="width: 100%; height: 10px;" align="center" ><button id="moreProductBtn" class="btn btn-outline-info">더 보기</button></div>
	                        </c:when>
                        </c:choose>
                    </div>

                    <script>

                        $(function() {
                            $(".prod").click(function() {
                                location.href = "detail.pr?pno=" + $(this).children().eq(0).children().eq(0).children().eq(0).val();
                            });

                            var $prods = $(".prod");

                            $.each($prods, function(index, prod) {
                                let indexNum = index % 9;
                                $(prod).addClass("prodback" + indexNum);
                            });
                        });
                        
                        $(function() {
                        	$("#moreProductBtn").click(function() {
                        		if($(".hiddenProduct").attr("style") == "display:none;") {
                            		$(".hiddenProduct").attr("style", "display:flex;");
                        		} else if($(".hiddenProduct").attr("style") == "display:flex;") {
                            		$(".hiddenProduct").attr("style", "display:none;");
                        		}
                        	});
                        });

                    </script>

                    <!-- 댓글 -->
                    <table id="replyArea" align="center">
                        <thead>
                            <tr height="50px" style="border-bottom: 1px solid black;">
                                <td colspan="2" id="rep">댓글 <span id="rcount" style="color: #78C2AD;">0</span>개</td>
                                <td id="rep2" width="10%" align="center"><span id="textCount">0</span>/<span id="rcount" style="color: #78C2AD;">200</span></td>
                            </tr>
                            <tr height="80px">
                                <c:choose>
                                    <c:when test="${ empty loginUser }">
                                        <!-- 로그인 전 -->
                                        <th colspan="2" style="text-align: center;">
                                            <textarea class="form-control" name="replyContent" id="content" style="resize:none; width:100%;" readonly>로그인한 사용자만 이용가능한 서비스 입니다. 로그인 후 이용바랍니다.</textarea>
                                        </th>
                                        <th style="vertical-align:middle; text-align: center;"><button class="btn btn-primary" disabled>작성하기</button></th>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 로그인 후 -->
                                        <th colspan="2" style="text-align: center;">
                                            <textarea class="form-control" name="replyContent" id="textAreaCount" style="resize:none; width:100%;"></textarea>
                                        </th>
                                        <th style="vertical-align:middle; text-align: center;"><button class="btn btn-primary" onclick="addReply(); toUserSocketMsg();">작성하기</button></th>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                    
                    <div class="listBtnArea">
                        <button type="button" class="btn btn-outline-secondary" id="listBtn" onclick="location.href='list.re';" style="width:140px">목록으로</button>
                    </div>    
                </div>
                <div style="height: 150px"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
                    
        $(function() {
            selectReviewReplyList();
        });
        
        function selectReviewReplyList() { // 해당 게시글에 있는 댓글리스트 조회용 ajax 요청
        
            $.ajax({
                url : "rlist.re",
                data : {rno:${ r.reviewNo }},
                success : function(result) { 
                    
                    var resultStr = "";
                    
                    for(var i = 0; i < result.length; i++) {
                        
                        resultStr += "<tr style='vertical-align:middle;' height='50px'>"
                                    + "<td><p class='replyName'>" + result[i].memberName + "</p></td>"
                                    + "<td class='replyDate' width='13%' align='right'>" + result[i].replyDate + "</td>";
                                
                                if("${loginUser.memberId}" == result[i].memberId || "${loginUser.memberId}" == "admin") {
                                    
                                    resultStr += "<td width='10%' align='center'>" 
                                                + "<button class='btn btn-danger button btn-sm' type='submit' onclick='deleteReply(" + result[i].replyNo + ");'>"
                                                + "삭제" + "</button>" 
                                              + "</td>";
                                }
                                            
                        resultStr += "</tr>"
                                  + "<tr style='border-bottom: 1px solid lightgray;'>"
                                  + "<td colspan='3'><pre style='white-space: pre-line;'>" + result[i].replyContent + "</pre></td>"
                                  + "</tr>";
                    }
                    
                    $("#replyArea>tbody").html(resultStr);
                    // 댓글 개수 출력
                    $("#rcount").text(result.length);
                },
                error : function() {
                    console.log("댓글리스트 조회용 ajax 통신 실패!");
                }
            });
        }
        
        // 댓글 작성 글자수 체크
        $("#textAreaCount").keyup(function (e) {
            var textAreaContent = $(this).val();
            
            // 글자수 세기
            $("#textCount").text(textAreaContent.length);
            
            // 글자수 제한
            if (textAreaContent.length > 200) {
                // 200자 부터는 타이핑 되지 않도록
                $(this).val($(this).val().substring(0, 200));
            };
        });
        
        function addReply() { // 댓글 작성 요청용 ajax
            
            if($("#textAreaCount").val().trim().length != 0) {
                
                $.ajax({
                    url : "rinsert.re",
                    data : { // ajax 요청 또한 커맨드객체 방식 가능 (키값을 필드명이랑 맞춰준다)
                        reviewNo:${r.reviewNo},
                        memberNo:"${loginUser.memberNo}",
                        replyContent:$("#textAreaCount").val()
                    },
                    success : function(result) {
                        
                        // "success" 또는 "fail" 문자열이 들어있음
                        if(result == "success") {
                            
                            // 댓글 작성 성공 시 댓글 리스트를 불러올 것
                            selectReviewReplyList();
                            // 댓글 작성 창 초기화 효과
                            $("#textAreaCount").val("");
                            $("#textCount").html(0);
                        }
                    },
                    error : function() {
                        console.log("댓글 작성용 ajax 통신 실패!");
                    }
                });
            } else {
                alertify.alert("댓글 작성 실패", "댓글 작성 후 등록을 요청해주세요.");
            }
        }
        
        function deleteReply(replyNo) { // 댓글 삭제 요청용 ajax
                
            $.ajax({
                url : "rdelete.re",
                data : {replyNo:replyNo},
                success : function(result) {
                    
                    // "success" 또는 "fail" 문자열이 들어있음
                    if(result == "success") {
                        
                        // 댓글 삭제 성공 시 댓글 리스트를 불러올 것
                        selectReviewReplyList();
                    }
                },
                error : function() {
                    console.log("댓글 삭제용 ajax 통신 실패!");
                }
            });
        }
        
        
        function toUserSocketMsg() {
        	
        	if(socket) {
        		
        		let socketMsg = "reply"+","+"${ loginUser.memberId },"+"${r.memberId}," + "bno," + "${r.reviewTitle}";
    			selectAlarmList();
    			socket.send(socketMsg);
        		
        	}
        	
        	
        	$.ajax({
        		
        		url : "insertReply.alarm",
        		data : {
        			alarmContent : "${loginUser.memberId} 님이 리뷰에 댓글을 작성 하셨습니다.",
        			fromId : "${loginUser.memberId}",
        			toId : "${r.memberId}",
        			alarmUrl : "detail.re?rno=${r.reviewNo}"
        			
        		},
        		success : function(result) {
        			
        			selectAlarmList();
        			
        		},
        		error : function() {
        			
        			console.log("toUserAlarm reviewDetailView.jsp ajax failure");
        		}
        		
        		
        	});
        	
        }
        
        
        
    </script>
</body>
</html>