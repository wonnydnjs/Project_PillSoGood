<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>장바구니</title>
<style>

    div {
        /* border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    #content { height: auto; display: flex; }
    #content_2>div { width: 100%; float: left; }
    #content_2_1 { height: 115px; float: left; }
    #content_2_2 { height: auto; float: left; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 30px;
        font-weight: bold;
    }

    #content_2_2 div>table>thead tr { border-bottom: solid lightgray; }
    #content_2_2 div>table { width: 90%; }

    table { color: black; }

    #content_2_2>div { width: 100%; height: auto; }

    #choice>div { height: 140px; width: 50%; float: left; padding: 15px; }
    #choiceA>div, #choiceB>div { height: 100%; width: 100%; border-radius: 10px; } 

    #textC { height: 40px; }
    #textC_1>p {
        color: black;
        font-weight: bold;
        text-align: left;
        padding-left: 20px;
        padding-top: 8px;
    }

    #textC_2>p {
        color: black;
        font-weight: bold;
        text-align:right;
        padding-right: 20px;
        padding-top: 8px;
    }

    #textC>div { width: 50%; float: left; }

    #textCV>p {
        color: black;
        text-align: left;
        padding-left: 20px;
        padding-top: 5px;
        font-size: 15px;
    }

    #btnss>div { width: 50%; float: left; }


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
                <div id="content_2_1">
                    <p>장바구니</p>
                </div>
                <div id="content_2_2" align="center">
                    <div>
                        <table>
                            <thead>
                                <tr height="50px">
                                    <th width="25px" align="center" style="padding-left: 5px"><input class="form-check-input" type="checkbox" name="allCheck"></th>
                                    <th colspan="3" align="left">전체선택</th>
                                    <th width="110px" style="text-align:right"><button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteValue();">선택삭제</button></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${ list }">
                                    
                                <tr>
                                    <td rowspan="2" align="center"><input class="form-check-input" type="checkbox" name="RowCheck" value="${ c.productNo }"></td>
                                    <td rowspan="2" align="center" width="150px"><div style="width: 80px; height: 80px;"><img src="${ c.productImgPath }" style="width:100%; height: 100%; margin: auto; object-fit: contain;"></div></td>
                                    <td height="30px">${ c.productExplain }엔</td>
                                    <td rowspan="2" width="150px">
                                        <table align="center">
                                            <tr>
                                                <td><button type="button" class="btn btn-light minus" style="background-color:white; border: 1px solid #ced4da;">-</button></td>
                                                <td style="width: 36px;"><input class="form-control result" value="${ c.cartAmount }" style="width: 44px; text-align: center;" readonly></td>
                                                <td><button type="button" class="btn btn-light plus" style="background-color:white; border: 1px solid #ced4da;">+</button></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td rowspan="2" align="right" style="font-size: 23px;" class="pricePri">
                                        <p style="margin:0px; font-weight: bold;" class="totalP"><fmt:formatNumber value="${ c.cartAmount * c.productPrice }" pattern="#,###.##"/>원</p>
                                        <input type="hidden" class="priceP" value="${ c.productPrice }">
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid lightgray;">
                                    <td style="font-size: 20px;"><b>${ c.productName }</b></td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div id="btns" style="margin-top: 10px;">
                        <button type="button" class="btn btn-outline-primary btn-lg" onclick="location.href='list.pr'">+ 제품 추가</button>
                    </div>
                    <div style="height: 200px;"></div>
                    <div>
                        <table>
                            <tr height="40px">
                                <td colspan="2">결제 예상 금액</td>
                            </tr>
                            <tr style="border-top: solid lightgray;" height="50px">
                                <td style="font-size: 20px;" width="700px"><b>총 제품 금액</b></td>
                                <td style="font-size: 20px;" align="right"><p style="margin:0px; font-weight: bold;" id="totalPri"></p></td>
                            </tr>
                        </table>
                    </div>
                    <div id="choice">
                        <div id="choiceA">
                            <div style="border: 1px solid #78C2AD;">
                                <div id="textC">
                                    <div id="textC_1"><p>정기구독시</p></div>
                                    <div id="textC_2"><p id="buySub"></p></div>
                                </div>
                                <div id="textCV">
                                    <p>
                                        + 정기구독 10% 할인 <br>
                                        + 배송비 무료
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div id="choiceB">
                            <div style="border: 1px solid #F3969A;">
                                <div id="textC">
                                    <div id="textC_1"><p>단품구매시</p></div>
                                    <div id="textC_2"><p id="buyOne"></p></div>
                                </div>
                                <div id="textCV">
                                    <p>
                                        + 배송비 3000원 <br>
                                        + 50,000원 이상 구매시 무료배송
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="btnss">
                        <div><button type="button" class="btn btn-primary btn-lg" onclick="postPaySubmit(1)">정기구독</button></div>
                        <div><button type="button" class="btn btn-secondary btn-lg" onclick="postPaySubmit(2);">단품결제</button></div>
                    </div>
                    
                    <form id="postForm" action="pay.or" method="post">
                    	<input type='hidden' name='num' value=''>
                    </form>
                    
                    <c:choose>
                    	<c:when test="${ empty list }">
                    		<script>
	                    		function postPaySubmit(num) {
	                    			alert("장바구니에 담긴 상품이 없습니다.");
	                            };
                    		</script>
                    	</c:when>
                    	<c:otherwise>
                    		<script>
                    			function postPaySubmit(num) {
                    				$("#postForm>input").val(num);
                    	        	$("#postForm").submit();
                    			}
                    		</script>
                    	</c:otherwise>
                    </c:choose>
                </div>
                <div style="height: 150px;"></div>
            </div>
            
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        $(function() {
            var chkObj = document.getElementsByName("RowCheck");
            var rowCnt = chkObj.length;

            $("input[name='allCheck']").click(function() {
                var chk_listArr = $("input[name='RowCheck']");
                for (var i = 0; i < chk_listArr.length; i++) {
                    chk_listArr[i].checked = this.checked;
                }
            });
            $("input[name='RowCheck']").click(function() { 
                if($("input[name='RowCheck']:checked").length == rowCnt) {
                    $("input[name='allCheck']")[0].checked = true;
                }
                else {
                    $("input[name='allCheck']")[0].checked = false;
                }
            });
        });

        function deleteValue() {
            var valueArr = new Array();
            var list = $("input[name='RowCheck']");
            for(var i = 0; i < list.length; i++) {
                if(list[i].checked) {
                    valueArr.push(list[i].value);
                }
            }
            if(valueArr.length == 0) {
                alert("선택된 상품이 없습니다.");
            }
            else {
                if(confirm("상품을 삭제하시겠습니까?")) {
                	$.ajax({
                        url : "remove.cart",
                        type : "post",
                        traditional : true,
                        data : {
                            valueArr : valueArr,
                            memberNo : "${ loginUser.memberNo }"
                        },
                        success: function(jdata) {
                            if(jdata = 1) {
                                alert("상품을 삭제했습니다.");
                                location.replace("list.cart");
                            }
                            else {
                                alert("상품 삭제 실패");
                            }
                        }
                    });
                }
            }
        }
        
        $(function() {

            var totalP = $(".totalP").text().split("원");
            var result2 = 0;
            var buyOne = 0;

            for(var i = 0; i < totalP.length - 1; i++) {
                result2 += parseInt(totalP[i].replace(',', ''));
            }

            if(result2 > 0 && result2 < 50000) {
                buyOne = result2 + 3000;
            }
            else {
                buyOne = result2;
            }

            var discount = result2 * 0.1;

            $("#totalPri").text(result2.toLocaleString('ko-KR') + '원');
            $("#buyOne").text(buyOne.toLocaleString('ko-KR') + '원');
            $("#buySub").text((result2 - discount).toLocaleString('ko-KR') + ' 원');
        });
        
        $(".plus").on("click", function() {

            var result = $(this).parent().siblings().children(".result");
            var quantity = result.val();
            $(result).val(++quantity);

            var price = $(this).parents("table").parent().siblings().children(".priceP").val();
            var total =  price * quantity;

            $(this).parents("table").parent().siblings(".pricePri").children('p').text(total.toLocaleString('ko-KR') + '원');

            var productNo = $(this).parents("table").parent().siblings().children(".form-check-input").val();

            var totalP = $('.totalP').text().split('원');
            var total2 = 0;

            for(var i = 0; i < totalP.length - 1; i++) {
                total2 += parseInt(totalP[i].replace(',', ''));
            }
            if(total2 > 0 && total2 < 50000) {
                buyOne = total2 + 3000;
            }
            else {
                buyOne = total2;
            }

            var discount = total2 * 0.1;

            $("#totalPri").text(total2.toLocaleString('ko-KR') + '원');
            $("#buyOne").text(buyOne.toLocaleString('ko-KR') + '원');
            $("#buySub").text((total2 - discount).toLocaleString('ko-KR') + ' 원');

            $.ajax({
                url: "update.cart",
                data: {
                    cartAmount: quantity,
                    productNo: productNo,
                    memberNo: "${ loginUser.memberNo }"
                },
                error: function() {
                    console.log("puls ajax error")
                }
            });
        });

        $(".minus").on("click", function() {

            var result = $(this).parent().siblings().children(".result");
            var quantity = result.val();
            if(quantity > 1) {
                $(result).val(--quantity);
            }

            var price = $(this).parents("table").parent().siblings().children(".priceP").val();
            var total =  price * quantity;

            $(this).parents("table").parent().siblings(".pricePri").children('p').text(total.toLocaleString('ko-KR') + '원');

            var productNo = $(this).parents("table").parent().siblings().children(".form-check-input").val();

            var totalP = $('.totalP').text().split('원');
            var total2 = 0;

            for(var i = 0; i < totalP.length - 1; i++) {
                total2 += parseInt(totalP[i].replace(',', ''));
            }
            if(total2 > 0 && total2 < 50000) {
                buyOne = total2 + 3000;
            }
            else {
                buyOne = total2;
            }

            var discount = total2 * 0.1;

            $("#totalPri").text(total2.toLocaleString('ko-KR') + '원');
            $("#buyOne").text(buyOne.toLocaleString('ko-KR') + '원');
            $("#buySub").text((total2 - discount).toLocaleString('ko-KR') + ' 원');

            $.ajax({
                url: "update.cart",
                data: {
                    cartAmount: quantity,
                    productNo: productNo,
                    memberNo: "${ loginUser.memberNo }"
                },
                error: function() {
                    console.log("minus ajax error")
                }
            });
        });
    </script>
    
</body>
</html>