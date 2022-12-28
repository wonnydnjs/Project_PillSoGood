<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>footer</title>
<style>

	.footerwrap {
        width: 100%;
        height: auto;
        padding-top: 30px;
        padding-bottom: 30px;
        background-color: rgba(234, 235, 237, 0.961);
    }
    
    .footer { height : auto; }
    
    .innerFooter {
        display:flex;
        margin: 0 auto;
        left: 20%;
    }
    .innerFooter>table { color: #888888; }
    .innerFooter a {
    	text-decoration: none;
    	color: #888888;
    }
    .innerFooter th { height: 45px; }
    .innerFooter td { font-size: 14px; }
    

</style>
</head>
<body>
    <div class="footerwrap">
    <div class="footer">
        <div class="innerFooter">
            <table style="width: 100%; margin: auto;">
            	<tr>
            		<td rowspan="4" width="25%;"></td>
            		<td colspan="2"><jsp:include page="/WEB-INF/views/common/logo.jsp" /></td>
            		<td rowspan="4" width="25%;"></td>
            	</tr>
                <tr>
                    <th width="30%">나만을 위한 맞춤 영양제 구독 서비스</th>
                    <th width="20%">
	                    <a href="list.no">공지사항 &ensp;|&ensp; </a>
	                    <a href="list.qu">1:1 문의 &ensp;|&ensp;</a>
	                    <a href="faq.pill">FAQ </a>
                    </th>
                </tr>
                <tr>
                    <td>
                    	<br>
                    	(주) PillSoGood <br>
                        서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F <br>
                        사업자등록번호 123-45-67890 <br>
                        통신판매업신고번호 : 2018-1234-5678 <br>
                        건강기능식품판매업 신고번호 : 제 2015-12345678 <br>
                    </td>
                    
                    <td>
                        고객센터 >
                        <br><br>
                        평일 오전 10:00 ~ 오후 17:00 내에 빠른 답변이 가능합니다. <br>
                        (점심시간 12:00~14:00)
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    	<br>
                        Copyright 2022 PillSoGood Allright reserved.
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
</body>
</html>