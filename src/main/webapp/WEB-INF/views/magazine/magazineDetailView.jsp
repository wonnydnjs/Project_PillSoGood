<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>매거진 상세</title>
<!-- hashtag 소스 다운 -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<!-- hashtag 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />    
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

    .btnArea {
        margin-left: 88%;
        padding-bottom:20px;
    }

    .thumbnailArea>p {
        font-size: 40px;
        text-align: center;
        margin: 0px;
        padding: 30px 0px;
        border-top: solid lightgray;
        border-bottom: solid lightgray;
    }

    .thumbnailArea>.badge {
        position: absolute;
        margin-top: 12%;
        margin-left: -47%;
    }

    .magazineContentPic {
        width: 1000px;
        height: 500px;
        padding: 20px 0px;
        margin: auto;
    }

    .magazineContentPic>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
    }

    .magazineContent { width: 1000px; margin: auto; }

    .magazineContent>p {
        margin: 0px;
        padding: 20px 0px;
        text-align: center;
        font-size: 18px;
    }

    .likeControl{ width:30px; height:30px; }

    /* 하단 이전글/다음글 영역 */
    .pageContent>table {
        width: 100%;
        height: 100px;
    }

    .pageContentTable td {
        padding: 10px;
    }

    .pageContentTable p {
        padding-left: 10px;
        margin-right: 15px;
        font-size: 13px;
    }

    .pageContentTable a {
        padding-left: 10px;
        font-size: 13px;
        text-decoration: none;
        color: black;
    }

    .pageContentTable {
        border-top: 2px solid black;
        border-bottom: 2px solid black;
    }
    
    .listBtnArea { margin-top: 50px; }
    
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
                <div id="content_2_2">
                    <!-- 삭제 수정 버튼 영역 -->
                    <c:if test="${ loginUser.memberId eq 'admin' }">
                    <div class="btnArea">
                        <button type="submit" class="btn btn-secondary" onclick="magazineFormSubmit(1);">삭제</button>
                        <button type="reset" class="btn btn-light" onclick="magazineFormSubmit(2);">수정</button>
                    </div>
                    </c:if>
                    
                    <form id="magazineForm" method="post">
                        <input type="hidden" name="magazineNo" value="${ mag.magazineNo }">
                        <input type="hidden" name="filePath" value="${ mag.magazineImgName }" >
                    </form>
                    
                    <script>
                        function magazineFormSubmit(num) {

                            if(num == 2) { 
                                
                                $("#magazineForm").attr("action", "updateForm.mag").submit();
                            
                            } else { 
                                
                                $("#magazineForm").attr("action", "delete.mag").submit();
                            }
                        }
                    </script>

                    <!-- 기사 제목 영역 -->
                    <div class="badgeArea" style="padding-bottom:30px; text-align:center;">
                    	<span style="font-size: 16px; height:35px; width:78px;  line-height: 22px;" class="badge bg-primary">${ mag.categoryNo }</span>
                    </div>
                    <div class="thumbnailArea">
                        <p>${ mag.magazineTitle }</p>
                    </div>
                    
                    <div class="magazineContentPic"><img src="${ mag.magazineImgName }"></div>

                    <div class="magazineContent"><p>${fn:replace(mag.magazineContent, newLine, "<br>")}</p></div>

                    <c:if test="${ not empty loginUser }">
                        <div align="right" class="likeArea" style="padding: 20px 0px;">
                            <c:choose>
                                <c:when test="${ loginUser.memberNo eq magL.memberNo  }"> 
                                    <img src="resources/images/Like.png" width="30" class="likeControl" id="magazineLike" style="cursor: pointer;" >
                                    <img src="resources/images/Unlike.png" width="30" style="display:none" class="likeControl" id="magazineUnLike" style="cursor: pointer;">
                                    <span id="magazineLikeCount" name="magazineLikeCount"></span>
                                </c:when>
                                <c:otherwise>
                                    <img src="resources/images/Unlike.png" width="30" alt="" class="likeControl" id="magazineUnLike" style="cursor: pointer;">
                                    <img src="resources/images/Like.png" width="30" class="likeControl" style="display:none" id="magazineLike" style="cursor: pointer;">
                                    <span id="magazineLikeCount" name="magazineLikeCount"></span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <div class="hashtagArea"><span class="badge bg-light">${mag.magazineHashtag}</span></div>
           
                    <div class="pageContent" style="padding: 20px 0px;">
                        <table class="pageContentTable">
                            <tr>
                            <c:choose>
                                <c:when test="${ empty prev }">
                                <td>
                                    <a style="display: inline;">이전글이 없습니다.</a>
                                </td>
                                </c:when>
                                <c:otherwise>
                                <td>
                                    <p class="pageContentPre" style="display: inline;">이전글</p>
                                    <a style="display: inline;" href="detail.mag?magazineNo=${ prev.magazineNo }">${ prev.magazineTitle }</a>
                                </td>
                                </c:otherwise>
                            </c:choose>
                            </tr>
                            <tr>
                            <c:choose>
                                <c:when test="${ empty next }">
                                <td>                                        
                                    <a style="display: inline;">다음글이 없습니다.</a>
                                </td>
                                </c:when>
                                <c:otherwise>
                                <td>
                                    <p class="pageContentPre" style="display: inline;">다음글</p>
                                    <a style="display: inline;" href="detail.mag?magazineNo=${ next.magazineNo }">${ next.magazineTitle }</a>
                                </td>
                                </c:otherwise>
                            </c:choose>
                            </tr>
                        </table>
                    </div>

                    <div align="center" class="listBtnArea"><button class="btn btn-primary" onclick="list()">목록으로</button></div>

                </div>
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        function list() {
            
            location.href = "list.mag";
        }
        
        function selectLikeCount() {
            
            $.ajax({
                url : "likeCount.mag",
                data : {magazineNo : ${mag.magazineNo}},
                success : function(result) { // 좋아요개수
                    
                    $("#magazineLikeCount").text(result);
                },
                error : function() {
                    console.log("실패");
                }
            });
        }
        
        $(function() {
            selectLikeCount();
        })
    </script>

    <!-- 좋아요 -->
    <script>
        $(function() {
            $(".likeArea").on("click", ".likeControl", function() {
                
                if($("#magazineLike").css("display") == "none") {

                $.ajax({
                    url: "insert.magL",
                    data: {magazineNo : ${mag.magazineNo},
                            memberNo : ${loginUser.memberNo}},
                    success : function (result) {

                            console.log(result);
                            
                        $("#magazineLike").show();
                        $("#magazineUnLike").hide();

                        $("#magazineLikeCount").html(result);
                    },
                    error : function() {

                        console.log("ajax 통신 실패!");
                    }
                    
                });
            
                } else {

                    $.ajax({
                    
                    url: "delete.magL",
                    data: {magazineNo : ${mag.magazineNo},
                            memberNo : ${loginUser.memberNo}},
                    success: function(result) {
                        
                        console.log(result);
                            
                        $("#magazineLike").hide();
                        $("#magazineUnLike").show();
                        $("#magazineLikeCount").html(result);
                    },
                    
                    error: function() {

                        console.log("ajax 통신 실패!");
                    }
                    });
                }
            });
        });
    </script>
        
</body>
</html>