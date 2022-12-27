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
        .footerContent td {
            font-family: 'Noto Sans KR', sans-serif !important;
            font-size: 13px;
        }
        .innerFooter {
            /* display: block; */
            display:flex;
            margin: 0 auto;
            left: 20%;
        }
        .footerContent { 
            margin: auto; 
            
        }
        /*
        .innerFooter {
            padding-bottom: 50px;
            padding-top: 20px;
        }
        */
        .footer {
            /* position: relative; */
            height : auto;
            
        }
        /* img {
            border: 1px solid;
            width: 150px;
            height: 40px;
            position: relative;
        } */
        /* 전체를 감싸는 wrap */
        .footerwrap {
            width: 100%;
            height: auto;
            padding-top: 10px;
            padding-bottom:20px;
            background-color: rgba(234, 235, 237, 0.961);
        }

        .logoArea {
            padding-left: 30%;
            padding-top: 9px;
            padding-bottom : 20px;
        }
    </style>
</head>
<body>
    <div class="footerwrap">
    <div class="footer">
        <div class="innerFooter">
            <table class="footerContent" style="width: 100%;">
                <tr>
                    <td colspan="4">
                        <div class="logoArea">
                            <jsp:include page="/WEB-INF/views/common/logo.jsp" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="30%" rowspan="4">
                       
                    </td>
                </tr>
                <tr>
                    <td colspan="2" width="25%" style="padding-bottom:20px;">
                        <h6 style="vertical-align:top;">나만을 위한 맞춤 영양제 구독 서비스</h6>
                    </td>
                    <td width="45%" style="padding-bottom:20px;">
                        <h6 >
                            <a href="list.no" style="text-decoration: none; color:#5a5a5a; vertical-align:top;">공지사항 &ensp;|&ensp; </a>
                            <a href="list.qu" style="text-decoration: none; color:#5a5a5a; vertical-align:top;">1:1 문의 &ensp;|&ensp;</a>
                            <a href="faq.pill" style="text-decoration: none; color:#5a5a5a; vertical-align:top;">FAQ </a>
                        </h6>
                    </td>
                </tr>
                <tr>
                    <td>   (주)PillSoGood <br>
                        서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F <br>
                        사업자등록번호 123-45-67890 <br>
                        통신판매업신고번호 : 2018-1234-5678 <br>
                        건강기능식품판매업 신고번호 : 제 2015-12345678 <br>
                    </td>
                    
                    <td colspan="2" style="vertical-align:top;">
                        <h6 style="padding-bottom:10px;">
                            고객센터 >
                        </h6>
                        
                        평일 오전 10:00 ~ 오후 17:00 내에 빠른 답변이 가능합니다. <br>
                        (점심시간 12:00~14:00)
                    </td>
                </tr>
                <tr></tr>
                <tr>
                    <td colspan="4" style="padding-top: 30px; padding-bottom: 20px; padding-left: 30%; font-size:12px;">
                        Copyright 2022 PillSoGood Allright reserved.
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
</body>
</html>