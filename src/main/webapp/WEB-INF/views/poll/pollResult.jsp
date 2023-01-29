<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>건강설문 결과</title>
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

    /* ---------------------- */

    #content_2_1 { height: 230px; float: left; }
    #content_2_2 { height: auto; float: left; }

    #content_2_1>div { width: 100%; height: 100%; background-color: rgba(120, 194, 173, 0.25);}

    #content_2_1_1>div { width: 100%; height: 100%; }

    #content_2_1_1>div>p {
        width: 100%;
        height: 100%;
        color: black;
        font-size: 30px;
        padding-top: 40px;
        padding-left: 80px;
    }

    #content_2_2>div { width: 100%; }
    #icons { height: 200px; }
    #icons>div {  height: 100%; float: left; min-width: 500px;  }

    #icon_1>div { width: 100%; }
    #iconn { height: 40%; }
    #picto { height: 60%; }

    #iconn>div { height: 100%; float: left; }
    .btnn { width: 100px; }
    .textt { width: 200px; }

    .btnn>div { margin-left: 30px; margin-top: 25px; }

    .btnn>div>button:hover { cursor: default; background-color: white; color: #FFCE67; }

    .textt>p {
        color: #FFCE67;
        font-size: 20px;
        font-weight: bold;
        margin-top: 30px;
    }

    #picto>div { height: 100%; width: 100%; }

    #circle { 
        width: 60px; 
        height: 60px; 
        border-radius: 50%; 
        background-color: #FFCE67;
        margin-left: 0px;
        margin-top: 20px;
    }

    #icon2_circle { 
        width: 60px; 
        height: 60px; 
        border-radius: 50%; 
        background-color: #FF7852;
        margin-left: 0px;
        margin-top: 20px;
    }
    
    #pictoT { width: 60px; height: 35px;}
    #icon2_pictoT { width: 60px; height: 35px;}

    #circle>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
        padding: 8px;
    }
    #icon2_circle>img {
        height: 100%;
        width: 100%;
        object-fit: contain;
        margin: auto;
        padding: 8px;
    }

    #pictoT>p {
        color: black;
        font-size: 15px;
        font-weight: bold;
        margin-top: 10px;
        text-align: center;
        width: 100%;
        height: 100%;
    }

    #icon2_pictoT>p {
        color: black;
        font-size: 15px;
        font-weight: bold;
        margin-top: 10px;
        text-align: center;
        width: 100%;
        height: 100%;
    }

    #content_2_2>div>table { width: 60%; }
    #content_2_2>div table { color: black; }

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
                    <div id="content_2_1_1">
                        <div>
                            <p>
                            	<c:set var="today" value="<%= new Date() %>"/>
                            	<c:set var="todayYear"><fmt:formatDate value="${ today }" pattern="yyyy"/></c:set>
                            	<c:set var="sysYear" value="${fn:substring(todayYear,0,4)}"/>
                            	<c:set var="userYear"><fmt:formatDate value="${ loginUser.memberBirthYear }" pattern="yyyy"/></c:set>
                            	<c:set var="userBirth" value="${fn:substring(userYear,0,4) }"/>
                                <b>${ loginUser.memberName }님의<br>건강설문 결과 </b><br>
                                <span style="font-size: 15px;"> 
                               		<fmt:formatNumber type="number" value="${ (sysYear - userBirth + 1) - ((sysYear - userBirth + 1) % 10)}"/>대&ensp;
                               		<c:choose>
                               			<c:when test="${ loginUser.gender eq 'F' }">여</c:when><c:otherwise>남</c:otherwise></c:choose>성&ensp;${ loginUser.height }cm&ensp;${ loginUser.weight }kg&emsp;|&emsp;BMI <fmt:formatNumber value="${ loginUser.weight / ((loginUser.height / 100) * (loginUser.height / 100)) }" pattern=".00" /> </span> 
                            </p>
                        </div>
                    </div>
                </div>
                <div id="content_2_2">
                    <div id="icons">
                        <div id="icon_1">
                            <div id="iconn">
                                <div class="btnn"><div><button type="button" class="btn btn-outline-warning">추천</button></div></div>
                                <div class="textt"><p>관리가 필요해요.</p></div>
                            </div>
                            <div id="picto">
                                <div>
                                    <div class="container-fluid">
                                    	<div class="d-flex"> <!-- 반복 돌렸을 때 옆으로 배치되게 바꾸기 -->
                                    	<c:set var="count" value="1"/>
                                    	<c:forEach var="i" begin="0" end="${ prlist.size() - 1 }">
                                    		
                                    		
                                    		<c:if test="${ prlist[i].pollLevel eq 1 }">
                                  							<c:set var="count" value="${ count + 1 }"/>	      
				                                            <div style="margin-right : 10px;">
				                                                <div id="circle"><img src="${ prlist[i].productEffectPath }"></div>
				                                                <div id="pictoT"><p>${ prlist[i].productEffect }</p></div>
				                                            </div>
				                                       		
                                    		</c:if>
                                    	</c:forEach>
                                    	</div> 
                                  
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${ count ne 10 }">
	                       	<div id="icon_2" >
	                            <div id="iconn">
	                                <div id="icon2_btn" class="btnn"><div><button type="button" class="btn btn-outline-danger">권장</button></div></div>
	                                <div id="icon2_text" class="textt" ><p style="color : #FF7852;">관심을 가져주세요.</p></div>
	                            </div>
	
	                            <div id="picto">
	                                <div>
	                                    <div class="container-fluid">
	                                        <div class="d-flex"> <!-- 반복 돌렸을 때 옆으로 배치되게 바꾸기 -->
	                                        	<c:forEach var="i" begin="0" end="${ prlist.size() -1 }">
	                                        		
	                                        		<c:if test="${ prlist[i].pollLevel eq 2 }">
	                                        			<div style="margin-right : 10px;">
			                                                <div id="icon2_circle"><img src="${ prlist[i].productEffectPath }"></div>
			                                                <div id="icon2_pictoT"><p>${ prlist[i].productEffect }</p></div>
			                                            </div>	
	                                        		</c:if>
	                                        	</c:forEach>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                        </c:if>
                        
                    </div>
                    
                    <div style="height: 100px;"></div>
                    
                    <br clear="both">
                    <div align="center">
                        <div id="tuijian" style="border: 2px solid #78C2AD; width: 70%; border-radius: 10px;">
                        	<form action="insertCart.po" method="post">
	                            <table>
	                                <thead>
	                                    <tr height="80px" style="font-size: 30px;">
	                                        <td colspan="4" align="center">${ loginUser.memberName }님만을 위한 추천 영양제입니다.</td>
	                                    </tr>
	                                    <tr>
	                                        <td colspan="4" align="center">
	                                            	나에게 꼭 필요한 영양성분을 장바구니에 담아 정기구독 혜택을 확인해보세요.
	                                        </td>
	                                    </tr>
	                                    <tr height="20px"/>
	                                    <tr style="border-bottom: solid lightgray;" height="50px">
	                                        <th width="25px" align="center"><input class="form-check-input" type="checkbox" onclick="selectAll(this);"></th>
	                                        <td colspan="3"><b>전체선택</b></td>
	                                    </tr>
	                                </thead>
	                                <tbody> <!-- 반복문 돌려서 값 뽑기 -->
	                                
                             			<c:forEach var="i" begin="0" end="${ prlist.size() -1 }">
	                                		<tr>
		                                        <td rowspan="2" align="center"><input class="form-check-input" name="productCheck" type="checkbox" value="${ prlist[i].productNo }"></td>
		                                        <td rowspan="2" align="center" width="100px"><div style="width: 80px; height: 80px;"><img src="${ prlist[i].productImgPath }" style="width:100%; height: 100%; margin: auto; object-fit: contain;"></div></td>
		                                        <td height="30px">${ prlist[i].productExplain }엔</td>
		                                    </tr>
		                                    <tr style="border-bottom: 1px solid lightgray;">
		                                        <td style="font-size: 20px;"><b>${ prlist[i].productName }</b></td>
		                                    </tr>
	                                	</c:forEach>	
	                                		
	                                </tbody>
	                                <tfoot>
	                                	<tr height="20px"/>
	                                    <tr height="100px">
	                                        <td align="center" colspan="4">
	                                            <button type="submit" class="btn btn-primary" style="width: 170.5px;">장바구니</button>
	                                        </td>
	                                    </tr>
	                                </tfoot>
	                            </table>
                            </form>
                        </div>
                    </div>
                </div>
                <br clear="both">
                <div id="content_2_3"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
    <script>
    	function selectAll(selectAll)  {
    	  const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    	  
    	  checkboxes.forEach((checkbox) => {
    	    checkbox.checked = selectAll.checked
    	  });
    	}
    	
    
    </script>
    

</body>
</html>