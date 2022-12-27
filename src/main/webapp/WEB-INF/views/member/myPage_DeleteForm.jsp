<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>MY PAGE 회원 탈퇴</title>
<style>

    div {
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        /* 전체 길이 개별 커스텀 */
        height: 1400px;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    /* 내용 길이 개별 wrap - 350px */
    #content { height: 1050px; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 115px; }
    #content_2_2 { color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
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

    /* ----- 마이페이지 공통 style ----- */
    /* 영역 구분 */
    #content2_2>div { height: 100%; }
    #mypage_navi { width: 20%; padding: 10px; float: left; }
    #mypage_content { width: 80%; padding: 30px; float: left; }

    /* MYPAGE 사이드메뉴바 */
    #mypage_navi>div {
        border: 2px solid #78C2AD;
        border-radius: 5px;
        padding: 15px;
    }
    /* 사이드바의 각 메뉴들 */
    #mypage_navi a {
        text-decoration: none;
        color: black;
    }
    #mypage_navi a:hover { color: #78C2AD; }

    /* 모든 table 공통 너비 */
    #mypage_content table { width: 100% }
    
    /* mypage_content h4, input. select 태그들 글자색 */
    #mypage_content h4, #mypage_content input, #mypage_content select { color: black; }

    /* 부트스트랩 페이징 */
    .pagination { justify-content: center; }

</style>

</head>
<body>

    <div class="wrap">
            <jsp:include page="../common/menubar.jsp" />
        <div id="navigator2"></div>
        <div id="header"></div>
        <div id="content">
            <div id="content_1"></div>
            <div id="content_2">
                <div id="content_2_1">
                    <p>MY PAGE</p>
                </div>
                <div id="content_2_2" style="padding-top:10px;">
                    
                    <div id="mypage_navi">
                        <div>
                            <p style="font-size: 20px;"><b style="font-size: 25px;">${loginUser.memberName}</b> 님</p>
                            <br>
                            <p><a href="myPage.or">주문 조회</a></p>
                            <p><a href="myPage.subs">정기구독 관리</a></p>
                            <p><a href="myPage.info">내 정보 관리</a></p>
                            <p><a href="myPage.poll">건강설문 관리</a></p>
                            <p><a href="myPage.prod">내 관심 제품</a></p>
                            <p><a href="myPage.re">내 후기 조회</a></p>
                            <p><a href="myPage.ev">찜한 이벤트</a></p>
                        </div>
                    </div>
 					
 				
                   <div id="mypage_content">
                    <form action="delete.me" method="post">
                        <h4>회원 탈퇴</h4>
                        <hr>

                        <div>
                            <b style="font-size: large;">유의사항 안내</b><br>
                            <small>회원 탈퇴 전, 유의사항을 반드시 확인해주세요.</small><br>
                            <hr>
                            회원 탈퇴 시 개인정보 및 서비스 이용기록은 모두 삭제되어 복구가 불가능합니다. <br>
                            단, 주문정보는 교환/반품/환불 및 사후처리 등을 위하여 전자상거래 등에서의 소비자 보호에 관한 법률 및 일반정보 보호정책에 따라 일정한 기간 동안 보관 후 파기됩니다. <br><br>

                            탈퇴 후에도 후기, 문의 등의 게시글은 자동삭제 되지 않고 남아있습니다. 삭제를 원하는 게시글이 있다면 탈퇴 전에 삭제하시기 바랍니다. <br><br>

                            회원 탈퇴 시 정기구독은 즉시 해지됩니다. <br><br>

                            탈퇴 후 재가입하는 경우에도 탈퇴 이전의 정보(회원정보, 주문정보 등)는 이관되지 않으며, 이미 적용된 혜택은 중복으로 제공되지 않습니다. <br><br>
                        </div>
                        <hr>

                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="dropout"><label class="form-check-label" for="dropout">유의사항을 모두 확인하였습니다.</label>
                        </div>

                        <div align="center" style="margin-top: 40px;">
                            <a data-bs-toggle="modal" data-bs-target="#deleteForm"><button type="button" class="btn btn-outline-secondary btn-sm" style="float: right;">탈퇴하기</button></a>
                        </div>
                        <!-- 회원탈퇴 버튼 클릭 시 보여질 Modal -->
                        <div class="modal fade" id="deleteForm">
                            <div class="modal-dialog modal-sm">
                                <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">회원탈퇴</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div align="center">
					                                    정말로 탈퇴 하시겠습니까? <br>
                                </div>
                                <br>
                                    <label for="memberPwd" class="mr-sm-2">Password : </label>
                                    <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="memberPwd" name="memberPwd"> <br>
                                    <input type="hidden" name="memberId" value="${ loginUser.memberId }">
                            </div>
                            <!-- Modal footer -->
			                    <div class="modal-footer" align="center">
			                    	<button type="button" class="btn btn-primary" onclick="javascript:history.go(-1);">취소</button>
			                        <button type="submit" class="btn btn-secondary">탈퇴하기</button>
			                    </div>
			               
			            </div>
			        </div>
			    </div>
                        
					</form>
                        <script>
                            $(function() {
                                
                                $("#mypage_content button").on("click", function() {
                                    
                                    // 유의사항에 동의한 경우만 탈퇴로 넘어가도록
                                    if(!$("#dropout").is(":checked")) {
                                        alert("유의사항에 동의해주세요.");
                                    }
                                });
                            });
                        </script>

                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>
            <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>