<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>제품 상세</title>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: 1650px;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }
    #content { height: 1150px; }
    #header { height: 130px; }


    table { width: 100%; color: black; }

    #tgg { width: 350px; height: 350px; }

    #imgg { 
        width: 100%;
        height: 100%;
        background-color: #e0e0e0;
        border-radius: 75px;
    }

    #proImgg { width: 100%; height: 100%; padding: 40px; }


    #proImgg>img, #proImg_1_1>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
    }
    
    #proImg { height: 500px; border-top: solid lightgrey; padding: 20px 0px; }

    #proImg_1_1 { width: 100%; height: 100%; }

    #wish>img {
        height: 35px;
        width: 35px;
        object-fit: contain;
        margin: auto;
    }
  

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 25%; }
    #content_2 { width : 50%; }
    #content_3 { width : 25%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

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
                <form method="post" action="insert.cart">
                    <table>
                        <thead>
                            <tr align="right" height="115px">
                                <td colspan="4">
                                	<c:choose>
                    					<c:when test="${ loginUser.memberId eq 'admin' }">
		                                    <button type="button" class="btn btn-warning" onclick="postFormSubmit(1);">수정</button>
		                                    <button type="button" class="btn btn-danger" onclick="postFormSubmit(2);">삭제</button>
		                                </c:when>
                    				</c:choose>
                                </td>
                            </tr>

                        </thead>
                        <tbody height="350px" width="50%" align="left">
                            <tr height="45px">
                                <td align="center" rowspan="7" width="50%">
                                    <div id="tgg"><div id="imgg"><div id="proImgg"><img src="${ p.productImgPath }"></div></div></div>
                                </td>
                                <th colspan="2" style="font-size: 20px; ">${ p.productExplain }엔</th>
                            </tr>
                            <tr height="65px" style="border-bottom: solid lightgrey;">
                                <th colspan="2" style="font-size: 30px;  padding-bottom: 10px;">${ p.productName }&ensp;<span style="color: rgb(185, 184, 184); font-size:20px;">30일분</span></th>
                            </tr>
                            <tr height="200px">
                                <td colspan="2">
                                    <table width="100%" style="background-color: #f9f4f4;">
                                        <tbody align="left">
                                            <tr height="55px" style="font-size: 20px; border-bottom: 1px solid lightgrey;">
                                                <th width="60%" style="padding-left: 10px;">구매가</th>
                                                <th colspan="2" style="text-align:right; padding-right:10px;"><fmt:formatNumber value="${ p.productPrice }"/>원</th>
                                            </tr>
                                            <tr height="55px" style="font-size: 20px">
                                                <td style="padding-left: 10px;">수량선택</td>
                                                <td style="text-align:center" id="allP">총 1개</td>
                                                <td width="40px" style="padding-right:10px;">
                                                    <table>
                                                        <tr>
                                                            <td><button type="button" class="btn btn-light" style="background-color:white; border: 1px solid #ced4da;" onclick="count('minus');">-</button></td>
                                                            <td style="width: 36px;"><input class="form-control" id="result" value="1" style="width: 36px;" readonly></td>
                                                            <td><button type="button" class="btn btn-light" style="background-color:white; border: 1px solid #ced4da;" onclick="count('plus');">+</button></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr height="55px" style="font-size: 20px;">
                                                <th style="padding-left: 10px;">총 금액</th>
                                                <th colspan="2" style="text-align:right; font-size: 25px; padding-right:10px;" id="proPri"><fmt:formatNumber value="${ p.productPrice }" />원</th>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr height="40px" align="center">
                                <td width="10%">
                                    <div id="wish">
                                    <c:choose>
                                        <c:when test="${ count eq 0 }">
                                            <img src="resources/images/heart.png" class="likeControl" id="eventUnLike" style="cursor: pointer;">
                                            <img src="resources/images/heart2.png" class="likeControl" id="eventLike" style="display:none; cursor: pointer;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="resources/images/heart2.png" class="likeControl" id="eventLike" style="cursor: pointer;">
                                            <img src="resources/images/heart.png" class="likeControl" id="eventUnLike" style="display:none; cursor: pointer;">
                                        </c:otherwise>
                                    </c:choose>
                                    </div>
                                </td>
                                <td width="90%"><button type="button" class="btn btn-primary" id="addCart" style="width: 300px">장바구니</button></td>
                            </tr>
                        </tbody>
                        <tfoot height="530px;">
                            <tr>
                                <td colspan="4" style="padding-top:50px; padding-bottom:50px;">
                                    <div id="proImg">
                                        <div id="proImg_1_1" style="height:530px; padding-top:30px;"><img src="${ p.productDescription }"></div>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </form>
                
                 <form id="postForm" action="" method="post">
                     <input type="hidden" id="productNo" name="pno" value="${ p.productNo }">
                     <input type="hidden" name="upfile" value="${ p.productImgPath }">
                     <input type="hidden" name="upfile" value="${ p.productDescription }">
                 </form>

                 <script>
                     function postFormSubmit(num) {
                         
                         // action 속성값을 부여 후 연이어서 submit 시키기
                         if(num == 1) { // 수정하기 버튼 클릭 시 num == 1 : updateForm.bo
                             
                             $("#postForm").attr("action", "updateForm.pr").submit();
                         } else { // 삭제하기 버튼 클릭 시 num == 2 : delete.bo
                         
                             $("#postForm").attr("action", "delete.pr").submit();
                         }
                     }
                     
                     $("#addCart").click(function() {

						if(${ empty loginUser }) {
							alert("회원만 이용할 수 있는 서비스입니다.");
						} else {
                    	 
	                    	 var productNo = $("#productNo").val();
	                    	 var cartAmount = $("#result").val();
	                    	 
	                    	 var data = {
	                    		productNo : productNo,
	                    		cartAmount : cartAmount
	                		};
	                    	 
	                   		$.ajax({
	                   			url : "insert.cart",
	                   		    type : "post",
	                   		    data : data,
	                   		    success : function(result) {
	                   		    
	                   		    	if(result == 'fail') {
	                   		    	
	                   		     		alert("장바구니에 담기지 않았습니다.");
	
	                   		    	} else {
	                   		    	
	                   		     		if(confirm("장바구니에 성공적으로 담겼습니다.\n장바구니로 이동하시겠습니까?")) {
	                   		     			location.href = 'list.cart';
	                   		     		}
	                   		     			
	                   		    	}
	                   		   },
	                   		   error : function() {
	                   		   		
	                   			   alert("카트 담기 실패");
	                   		   }
	                   		});
						}
                   	});
                 </script>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        function count(type)  {
            // 결과를 표시할 element
            const resultElement = document.getElementById("result");
            
            // 현재 화면에 표시된 값
            let number = $(resultElement).val();
            var num = parseInt(number);

            if(type == "plus") {
                if (num < 9) {
                    num = num + 1;
                }
            } else if(type == "minus")  {
                if (num != 1) {
                    num = num - 1;
                }
            }

            // 결과 출력
            $("#result").val(num);
            $("#allP").html("총 " + num + "개");
            
            // 영섭
			var price = ${ p.productPrice }; // price 라는 int
			// 결과를 표시할 element
 			$("#proPri").html((num * price).toLocaleString('ko-KR') + "원");
        }
        
        $(function() {
        	$("#wish").on("click", ".likeControl", function() {
                
                if("${ loginUser }" == "") {
                    alert("로그인 후 이용 가능한 서비스입니다.");
                } else {

                    if($("#eventLike").css("display") == "none") {

                        $.ajax({
                            url: "like.pr",
                            data: {
                                productNo: "${ p.productNo }",
                                memberNo: "${ loginUser.memberNo }"
                            },
                            success: function(result) {
                                $("#eventLike").show();
                                $("#eventUnLike").hide();
                            },
                            error: function() {
                                console.log("ajax failure");
                            }
                        });

                    } else {

                        $.ajax({
                            url: "deletelike.pr",
                            data: {
                                productNo: "${ p.productNo }",
                                memberNo: "${ loginUser.memberNo }"
                            },
                            success: function(result) {
                                $("#eventLike").hide();
                                $("#eventUnLike").show();
                            },
                            error: function() {
                                console.log("ajax failure");
                            }
                        });
                    }
                }
        	});
        });
    </script>
    
</body>
</html>