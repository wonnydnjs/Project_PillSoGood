<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PillSoGood</title>
  <!-- bootstrap -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  <!-- bootswatch minty -->
  <link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.css">
  <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- ajax jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://kit.fontawesome.com/6cda7ccd12.js" crossorigin="anonymous"></script>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  
  <!-- 소켓용 sockjs -->
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<style>

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    ul { font-family: 'Noto Sans KR', sans-serif !important; }  
    ul>li { font-family: 'Noto Sans KR', sans-serif !important; }

    #navibar{
      width: 98%;
      height: 100px;
      margin-top: 20px;
      /*position: fixed;*/
    }

    #menubar {
      display: flex;
      justify-content: space-between;

    }

    #menubar ul {
      float: left;
      margin-left: 0 auto;
      margin-left: 25%;
    }

    #menubar li {
      float: left;
      font-size: 18px;
      font-weight: 600;
      /* border: 1px solid black; */
      position:relative;
      margin-left: 40px;
      margin-right: 40px;
    }

    #side {
      display: table-cell;
      vertical-align: middle;
      margin-right: 7%;
    }

    #side>a {
      position: relative;

    }

    .dropdown-item {
      text-align: center;
    }

    .dropdown-menu {
      min-width : 120px;
    }

    .logo>a {
      position: relative;
      margin-left:50%;
      padding-left: 100px;
      margin-top: 10%;
    }
    
    #alarmAreaButton {
	    border: none;
	    background-color: white;
     }
     #alarmArea {
         width : 450px;
         height : 500px;
         overflow-y: auto;
         position: absolute;
         background-color: white;
         border : 1px solid rgba(0, 0, 0, 0.175);
         border-radius : 10px;
     }
     #alarmContainer * {
         z-index: 999;
     }
     #alarmArea * {
         position: relative;
     }
     #alarmContainer {
         position : absolute;
         right : 380px;
         top : 35px;
     }
     #alarmTable:hover {
         cursor:pointer;
     }
     
     #socketAlarmArea {
	    position: fixed;
	    bottom: 20px;
	    right: 20px;
	    background-color: transparent;
	    z-index: 11;
	    -webkit-transition: right 0.7s;
	    -moz-transition: right 0.7s;
	    -ms-transition: right 0.7s;
	    -o-transition: right 0.7s;
	    transition: right 0.7s;
	 }
	 #alarmTable * {
	 	text-decoration : none;
	 }
	 
	 #alarmTable *:hover {
	 	text-decoration : none;
	 }

</style>
</head>
<body>
	
	<c:if test="${ not empty alertMsg }">	
		<script>
			alert("${ alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
	
	<c:if test="${ loginUser ne null }">
		<script>
		
			var socket  = null;
			$(document).ready(function(){
			    // 웹소켓 연결
			    sock = new SockJS("<c:url value="/echo-ws"/>");
			    socket = sock;
				//console.log(socket);
			    // 데이터를 전달 받았을때 
			    //console.log(sock.onmessage);
			    sock.onmessage = onMessage; // toast 생성
		    
			});	

	    </script>
	</c:if>	
	
  <script>
		var toastCount = 0;
		// 전역변수 설정
		
	    function onMessage(evt){
	    	selectAlarmList();
	        var data = evt.data;
	        // toast
	        	toastCount++;
                let toast;
                toast = "<div class='toast toast-" + toastCount + "' data - autohide='false' > ";
                toast += "<div class='toast-header' style='background-color : #9fdfcd'><i class='fas fa-bell mr-2'>&nbsp;</i><strong class='mr-auto'>알림</strong>";
                toast += "<button type='button' class='ml-n2 mb-n1 close' style='margin-left : 250px; border:none; background-color:#9fdfcd;' data-bs-dismiss='toast' aria-label='Close'>";
                toast += "<span aria-hidden='true'>&times;</span></button>";
                toast += "</div><div class='toast-body'>"+"<img src='resources/images/Logo.PNG' width='70px'>     "+data;
                ("</div></div>");
                
                $("#socketAlarmArea").append(toast);
                $(".toast-" + toastCount).toast({ animation: true, delay: 4000 });
                $(".toast-" + toastCount).toast("show");
                $("#socketAlarmArea").addClass("slideon");
                
	    };	
	</script>

  <div id="navibar">
  <nav class="navbar navbar-expand-lg">
    <div class="container-fluid" id="menubar">
      <span class="logo">
        <a class="nav" href="${ pageContext.request.contextPath }" style="text-decoration: none;">
          <jsp:include page="logo.jsp" />
        </a>
     </span>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarColor03">
        <ul class="navbar-nav me-auto" id="menubarUl">

          <li class="nav-item" id="menubarLi">
            <a class="nav-link" href="list.pr">제품</a>
          </li>

          <li class="nav-item" id="menubarLi">
            <a class="nav-link" href="survey.po">건강설문</a>
          </li>
          
          <li class="nav-item" id="menubarLi">
            <a class="nav-link" href="list.re">후기</a>
          </li>
          
          
          <li class="nav-item dropdown" id="menubarLi">
            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">소식</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="list.ev">이벤트</a>
              <a class="dropdown-item" href="list.mag">매거진</a>
            </div>
          </li>
        
        
        
          <li class="nav-item dropdown" id="menubarLi">
            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">고객센터</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="list.no">공지사항</a>
              <a class="dropdown-item" href="faq.pill">FAQ</a>
              <c:choose>
              	<c:when test="${ loginUser.memberId eq 'admin' }">
              		<a class="dropdown-item" href="qlist.ad">1:1 문의</a>
              	</c:when>
              	<c:otherwise>
              		<a class="dropdown-item" href="list.qu">1:1 문의</a>
              	</c:otherwise>
              </c:choose>
            </div>
          </li>
        </ul>

        <div class="text-decoration-none" id="side" style="font-size: 15px;">
            
            <c:choose>
            	<c:when test="${ empty loginUser }">
            	<!-- 로그인 전 -->
	         	    
	            	<a class="text-decoration-none" href="loginForm.me" style="color:rgb(92, 93, 96);">로그인 |</a>
	            	<a class="text-decoration-none" href="enrollForm.me" style="color:rgb(92, 93, 96)">회원가입</a>	
            	</c:when>
            	<c:otherwise>
            	<!-- 로그인 후 -->
            	
           		        <div id="alarmContainer">
				            <button type="button" id="alarmAreaButton" class="btn btn-primary position-relative"><img src="resources/images/alarm.png" width="25px" onclick="alarmAreaControl();" alt="">
				                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="alarmCount">
				                    
				                </span>
				            </button>
				            <div id="alarmArea" style="display:none;">
				                <table class="table table-hover" id="alarmTable">
				                	<thead>
				                		<tr align="center">
				                			<td><button class="btn btn-secondary" onclick="readAllAlarm();">모두 읽음</button><button style="margin-left:20px;" class="btn btn-secondary" onclick="deleteReadAlarm();">읽은 메세지 삭제</button></td>
				                		</tr>
				                	</thead>
				                	<tbody>
				                		
				                	</tbody>
				                </table>
				            </div>
				        </div>
		            <a class="text-decoration-none" href="list.cart" style="color:rgb(92, 93, 96)">장바구니 |</a>    
		            <a class="text-decoration-none" href="logout.me" style="color:rgb(92, 93, 96)">로그아웃 |</a> 
		            <a class="text-decoration-none" style="color:rgb(92, 93, 96); cursor:pointer;" onclick="myPageControl();">마이페이지</a>      	
            	</c:otherwise>
            </c:choose>

        </div>
      </div>
    </div>
  </nav>
  </div>
  
  <script>
  
  	function myPageControl() {
	   	
	   if("${loginUser.memberId}" == "admin") {
	   	 
			 location.href="adminMypage.me";
	     
	   } else {
	   	 
	  	location.href="myPage.or";
	   	 
	   }
	}
  
  	$(function() {
  		selectAlarmList();	
  	});
  	
  	
    function alarmAreaControl() {
        $("#alarmArea").toggle(200);
    }
    
    function selectAlarmList() {
    	if("${ loginUser }" != "") {
	    	$.ajax({
	    		url : "selectList.alarm",
	    		async : false,
	    		data : {
	    			memberNo : "${loginUser.memberNo}"
	    		},
	    		success : function(result) {
	    			
	    			var resultStr= "";
	    			var count =0;
	    			for(var i=0; i<result.length; i++ ) {
	    				if(result[i].alarmRead == 1) {
		    				++count;
	    					resultStr += "<tr>"
		    						 	  +"<td><a style='margin-left : 10px; color:gray;' onclick='alarmReadUpdate("+ result[i].alarmNo +");' href='"+result[i].alarmUrl+"'><strong>" + result[i].alarmContent + "</strong></a><button type='button' style='float:right;' class='btn-close' onclick='deleteAlarm("+result[i].alarmNo+")' /></td>"    				
		    						   + "<tr>";
	    				} else {
	    					
	    					resultStr += "<tr>"
									 	  +"<td><a style='margin-left : 10px; color:gray;' href='"+result[i].alarmUrl+"'>" + result[i].alarmContent + "</a><button type='button' style='float:right;' class='btn-close' onclick='deleteAlarm("+result[i].alarmNo+")' /></td>"    				
									   + "<tr>";
	    					
	    				}
	    			}
	    			
	    			$("#alarmTable>tbody").html(resultStr);
	    			$("#alarmCount").text(count);
	    		},
	    		error : function() {
	    			console.log("selectList.alarm ajax failure");
	    		}
	    	});
    	}
    }
    
    function alarmReadUpdate(alarmNo) {
    	   	
    	$.ajax({
    		
    		url : "alarmReadUpdate.alarm",
    		data : { alarmNo : alarmNo },
    		success : function() {
    			selectAlarmList();
    		},
    		error : function() {
    			console.log("alarmReadUpdate ajax failure");
    		}
    	});
    	
    }
    
    function deleteAlarm(alarmNo) {
    	
    	$.ajax({
    		
    		url : "deleteAlarm.alarm",
    		data : { alarmNo : alarmNo } ,
    		success : function() {
    			
    			selectAlarmList();
    		},
    		error : function() {
    			console.log("deleteAlarm ajax failure");
    		}
    		
    	});
    	
    }
    
    
    function readAllAlarm() {
    	
    	$.ajax({
    		
    		url : "readAllAlarm.alarm",
    		data : { memberNo : "${loginUser.memberNo}" },
    		success : function() {
    			
    			selectAlarmList();
    		},
    		error : function() {
    			
    			console.log("readAllAlarm ajax failure");
    		}
    		
    	});
    	
    }
    
    function deleteReadAlarm() {
    	
    	$.ajax({
    		
    		url : "deleteReadAlarm.alarm",
    		data : { memberNo : "${loginUser.memberNo}" },
    		success : function() {
    			
    			selectAlarmList();
    		},
    		error : function() {
    			console.log("deleteReadAlarm ajax failure");
    		}
    		
    	});
    	
    }

  </script>

	<div id="socketAlarmArea" ></div>

</body>
</html>