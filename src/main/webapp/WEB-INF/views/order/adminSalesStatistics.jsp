<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.pill.order.model.vo.Order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<Order> list = (ArrayList)request.getAttribute("list");
	ArrayList<Order> list2 = (ArrayList)request.getAttribute("list2");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>ADMIN PAGE 매출 통계</title>
<style>

    div { box-sizing : border-box; }
    body { font-family: 'Noto Sans KR', sans-serif !important; }

    .wrap {
        width: 100%;
        height: auto;
        margin : auto;
    }
    .wrap>div { width : 100%; }

    #navigator2 { height: 100px; }
	#header { height: 130px; }
	
    #content { height: auto; display:flex; }
    #content>div { height : 100%; float : left; }
    
    #content_1 { width : 20%; }
    #content_2 { width : 60%; padding-bottom: 200px;}
    #content_3 { width : 20%; }
    
    #content_2>div { width: 100%; }
    #content_2_2 { height: auto; color: black; }

    #content_2_1>p {
        font-size: 35px;
        color: black;
        margin-top: 20px;
        margin-left: 15px;
        font-weight: bold;
    }

    /* ----- 마이페이지 공통 style ----- */
    /* 영역 구분 */
    #content_2_2>div { height: 100%; }
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

    /* ----- 매출통계 style ----- */
    .chart_title {
	    height: 55px;
	    line-height: 55px;
	    font-weight: bold;
    }

</style>

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>


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
                            <p>[ 전체 매출 현황 ]</p>
                        </div>
                        
                        <div>
                            <canvas id="month_chart"></canvas>
                            <div class="chart_title" align="center">
                                당해 월별 매출
                            </div>
                        </div>

                        <div style="margin-top: 50px;">
                            <canvas id="year_chart"></canvas>
                            <div class="chart_title" align="center">
                                연도별 매출
                            </div>
                        </div>

                        
                        <script>
                            const ctx1 = document.getElementById('month_chart');
                            
                            let timeList = []; // 당해 월
                            
                            let PriceList = []; // 당해 월별 총액 
                            
                            // 당해 월을 구하는 반복문 
                             <% for(int i = 0; i < list.size(); i++) { %>

		                       	 console.log("<%= i %> : <%= list.get(i) %>");
		                       	 timeList.push( "<%= list.get(i).getOrderDate() %>" ); 
		                       	 
                            <% } %> 
                            
                            // 당해 월별 총액 구하는 반복문 
                            <% for (int i = 0; i < list.size(); i++) { %>
                            
                            	<%-- console.log("<%= i %> : <%= list.get(i) %>"); --%>
                            	PriceList.push("<%= list.get(i).getOrderPrice() %>");
                            
                            <% } %>
                            
                            console.log(PriceList);
                            console.log(timeList);
                            
                			
                            
							new Chart(ctx1, { 
								type : 'line',
							    data: {
							        labels: timeList, 
							        datasets: [{
							            label: '월별 매출',
							            data: PriceList,
							            borderColor: ["#78C2AD"],
							            
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
							
							
                      			

                            const ctx2 = document.getElementById('year_chart');
                            
                            let YearTimeList = []; // 연도값 
                            
                            // 연도를 구하는 반복문 
                            <% for(int i = 0; i < list2.size(); i++) { %>
                            	
                            	console.log(YearTimeList);
                            	YearTimeList.push("<%= list2.get(i).getOrderDate() %>"); 
                            
                            <% } %>
                            
                            
                            let YearPriceList = []; // 연도별 매출값 
                            
                         	// 연도별 매출값 구하는 반복문 
                            <% for(int i = 0; i < list2.size(); i++) { %>
                            	
                            	console.log(YearTimeList);
                            	YearPriceList.push("<%= list2.get(i).getOrderPrice() %>"); 
                            
                            <% } %>
                            
                          
                            new Chart(ctx2, {
                                type: 'line',
                                data: {
                                    labels: YearTimeList,
                                    datasets: [{
                                        label: '연간 매출',
                                        data: YearPriceList,
                                        borderColor: ["#F3969A"],
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