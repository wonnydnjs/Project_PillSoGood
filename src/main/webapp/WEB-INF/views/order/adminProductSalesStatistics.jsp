<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.pill.order.model.vo.Cart" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Cart> list = (ArrayList)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 제품 통계</title>
</head>
<style>

    div {
       /*  border : 1px solid #78C2AD; */
        box-sizing : border-box;
    }

    /* 전체를 감싸는 wrap */
    .wrap {
        width: 100%;
        /* 전체 길이 개별 커스텀 */
        height: auto;
        margin : auto;
    }

    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }

    /* 내용 길이 개별 wrap - 350px */
    #content { height: auto; display:flex; }
    #content_2>div { width: 100%; }
    #content_2_1 { height: 10%; }
    #content_2_2 { height:90%; color: black; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 15px;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; padding-bottom: 200px;}
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

    /* ----- 관리자 공통 style ----- */
    /* 드롭다운 관련 */
    #mypage_navi .nav-link {
        padding: 0px 30px 16px 0px;
    }
    .dropdown-item:hover, .dropdown-item:focus {
        background-color: #78C2AD !important;
        color: white !important;
    }

    /* content 안에 소메뉴 */
    #admin_menu>p {
        font-size: large;
        font-weight: bold;
    }

</style>

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>

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
                    <p>ADMIN PAGE</p>
                </div>
                <div id="content_2_2" style="padding-top:10px;">
                    
                    <div id="mypage_navi">
                        <div>
                            <p style="font-size: 20px;"><b style="font-size: 25px;">관리자</b> 님</p>
                            <br>
                            <ul class="nav nav-pills">
                                <li class="nav-item"><a href="adminMypage.me" class="nav-link">회원 관리</a></li>
                                <li class="nav-item"><a href="ProductList.ad" class="nav-link">제품 관리</a></li>
                                <li class="nav-item"><a href="olist.ad" class="nav-link">주문 관리</a></li>
                                <li class="nav-item"><a href="qlist.ad" class="nav-link">문의 관리</a></li>
                                <li class="nav-item"><a href="" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button">통계 관리</a>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="salesStatistics.ad">매출 통계</a>
                                        <a class="dropdown-item" href="productSalesStatistics.ad">제품 통계</a>
                                        
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div id="mypage_content">
                        <h4>통계 관리</h4>
                        <hr>

                        <div id="admin_menu">
                            <p>[ 제품별 매출 현황 ]</p>
                        </div>
                        
                        <div>
                            <canvas id="product_chart"></canvas>
                        </div>

                        
                        <script>
                            const ctx = document.getElementById('product_chart');
                            
                            let Total = []; // 누적금액 리스트 
                            
                            <% for(int i = 0; i < list.size(); i++) { %>
                            	
                            	
                            	Total.push("<%= list.get(i).getProductPrice() %>");
                            
                            <% } %>
                            
                            let productName = []; // 제품 이름 리스트 
                            
                            <% for(int i = 0; i < list.size(); i++) { %>
                            	
                            	
                            	productName.push("<%= list.get(i).getProductName() %>");
                            	
                            <% } %>
                            
                            // console.log(Total);
                            // console.log(productName);
                            
                          
                            new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: productName,
                                    datasets: [{
                                        label: '제품별 누적 매출',
                                        data: Total,
                                        borderWidth: 1,
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.5)',
                                            'rgba(54, 162, 235, 0.5)',
                                            'rgba(255, 206, 86, 0.5)',
                                            'rgba(75, 192, 192, 0.5)',
                                            'rgba(153, 102, 255, 0.5)'],
                                       borderColor: ['rgb(255, 99, 132,1.5)',
                                                'rgba(54, 162, 235, 1.5)',
                                                'rgba(255, 206, 86, 1.5)',
                                                'rgba(75, 192, 192, 1.5)',
                                                'rgba(153, 102, 255, 1.5)']
                                    }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        </script>

                    </div>

                </div>

            </div>
            <div id="content_3"></div>
        </div>
        
    </div>

    <div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>