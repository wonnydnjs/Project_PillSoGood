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
<title>회원가입</title>
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
    #content_2_1 { height: 115px; }
    #content_2_2 { height: auto; }

    #header { height: 130px; }

    #content_2_1>p {
        font-size: 35px;
        color: rgb(0, 0, 0);
        margin-top: 20px;
        margin-left: 30px;
        text-align : center;
        font-weight: bold;
    }

    /* content 영역 */
    #content>div { height : 100%; float : left; }
    #content_1 { width : 20%; }
    #content_2 { width : 60%; }
    #content_3 { width : 20%; }

    body { font-family: 'Noto Sans KR', sans-serif !important; }

    /* 여기부터는 내가 준 스타일 영역 */
    #memberEnrollFrom {
        box-sizing: border-box;
        height: 700px;
        width: 500px;
        margin-top: 50px;
    }
    
    #memberEnrollForm tr { height: 40px!important; }

</style>

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
                    <p>회원가입</p>
                </div>
                <div id="content_2_2">
                    <form action="insert.me" method="post" id="enrollForm" onsubmit="return enrollForm_check()">
                        <table id="memberEnrollForm" align="center" >
                            <tr>
                                <th align="left" colspan="3">아이디</th>
                            </tr>
                            <tr style="display: inline-block;">
                                <td colspan="3">
                                    <input class="form-control" type="text" placeholder="아이디를 입력해주세요" minlength="5" maxlength="20" style="width: 400px;" required name="memberId" id="memberId">
                                </td>
                                <td>
                                    <button type="button" class="btn btn-primary" style="width:100px" name="idCheck" id="idCheckbtn">중복확인</button>

                                </td>
							<tr style="height: 20px!important;">
								 <td>
                                	<div id="checkResult" style="font-size:0.8em; display:none; padding-left: 6px;"></div>
                                </td>
                                    
							</tr>
                            <tr>
                                <th colspan="3">비밀번호</th>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <input type="password" class="form-control" placeholder="특문,영문,숫자를 포함하여 8~20자 이하로 입력해주세요" minlength="8" maxlength="20" style="width:500px" required name="memberPwd" id="memberPwd">
                                </td>
                            </tr>
                            <tr>
                                <th colspan="3">비밀번호 재확인</th>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <input type="password" class="form-control" placeholder="동일한 비밀번호를 한번 더 입력해주세요" style="width: 500px;" name="checkPwd" id="checkPwd">
                                 	<div id="checkResult2" style="font-size:0.8em; display:none;"></div>	
                                </td>
                            </tr>
                            <tr>
                                <th colspan="3">이름</th>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <input type="text" class="form-control" placeholder="이름을 입력해주세요" style="width: 500px;" required name="memberName" id="memberName">
                                </td>
                            </tr>
                            <tr>
                                <th colspan="3">휴대폰번호</th>
                            </tr>
                            <tr>
                                <td colspan="3"> 
                                    <input type="tel" class="form-control" placeholder="휴대폰번호를 '-' 없이 입력해주세요" maxlength="11" style="width: 500px;" required name="phone" id="phone">
                                </td>
                            </tr>
                            <tr>
                                <th colspan="3">이메일</th>
                            </tr>
                            <tr style="display: inline-block;">
                                <td>
                                    <input type="text" class="form-control" placeholder="이메일을 입력해주세요" style="width: 240px;" required id="email1" maxlength="30">
                                </td>
                                <td><span style="width:10px;" id="middle">&nbsp;&nbsp;@&nbsp;&nbsp;</span></td>

                                <td>
                                    <select class="form-select" style="width: 228px;" id="email2" required>
                                        <option value="naver.com">naver.com</option>
                                        <option value="google.com">google.com</option>
                                        <option value="kakao.com">kakao.com</option>
                                    </select>
                                </td>
                                <input type="hidden" name="email" id="email" value="">
                            </tr>

                            <tr>
                                <th>주소</th>
                            </tr>
                            <tr>
                                <td>
                                    <input type="text" class="form-control" name="addressZip" id="address_zip" placeholder="우편번호" style="display:inline-block; width: 370px;" readonly>
	                                <input type="button" class="btn btn-primary" id="address_btn" onclick="getAddress();" value="우편번호 찾기" style="display:inline-block; vertical-align: top;">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="text" class="form-control" name="address1" id="address1" placeholder="도로명 주소" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="text" class="form-control" name="address2" id="address2" placeholder="상세 주소 (선택)" >
                                </td>
                            </tr>
                        </table>
                        
                        <script>
					        /* 우편번호 검색 API */
					        function getAddress() {
					            new daum.Postcode({
					                oncomplete: function(data) {
					                	
					                	// 지번을 선택해도 도로명으로만 표시
					                	var address = data.roadAddress;
					                	
					                	// 건물명이 있을 경우 추가
					                	if(data.buildingName != '') {
					                		address += ' (' + data.buildingName + ')';
					                	}
					                	
					                	// 우편번호
					                	$("#address_zip").val(data.zonecode).attr("readonly", true);
					                	// 선택한 주소
					                	$("#address1").val(address).attr("readonly", true);
					                	
					                	// 커서 포커스
					                	$("#address2").focus();
					    
					                }
					            }).open();
					        }
					    </script>

                        <div align="center" style="padding: 15px 0px; margin-top: 30px;">
                            <button class="btn btn-secondary" id="enrollbtn" type="submit" style="width: 140px; height: 40px;" disabled onclick="return validate();">가입하기</button>
                        </div>
                    </form>

                </div>
                <div style="height: 150px;"></div>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    
   <script>
   	$(function() {
   		// 아이디를 입력받는 input 요소 객체를 변수에 담아두기 => keyup 이벤트 걸기
   		var $idInput = $("#enrollForm input[name=memberId]");
   		
   		$idInput.keyup(function() {
   			
   			$("#idCheckbtn").on("click", function() {
   			
   			// 우선 최소 5글자 이상으로 아이디값이 입력되어 있을 때만 ajax 요청
   			// => 쿼리문의 갯수가 한정되어있을 수 있기 때문
   			if($idInput.val().length >= 5) {
   				
   				// ajax 를 요청하여 중복체크
   				$.ajax({
   					url : "idCheck.me",
   					data : {checkId : $idInput.val()},
   					success : function(result) {
   						
   						// console.log(result);
   						
   						if(result == "NNNNN") { // 사용 불가능
   							
   							// 빨간색 메세지 출력
   							$("#checkResult").show();
   							$("#checkResult").css("color", "red").text("사용할 수 없는 아이디입니다.");
   							
   							// 버튼 비활성화
   							$("#enrollForm button[type=submit]").attr("disabled", true);
   							
   						} else { // 사용 가능
   							
   							// 초록색 메세지 출력
   							$("#checkResult").show();
   							$("#checkResult").css("color", "green").text("사용하실 수 있는 아이디입니다.");
   							
   							// 버튼 활성화
   							$("#enrollForm button[type=submit]").attr("disabled", false);
   						}
   					},
   					error : function() {
   						console.log("아이디 중복 체크용 ajax 통신 실패!");
   					}
   				});
   			} else { // 5글자 미만일 때 => 버튼 비활성화, 메세지 내용 숨기기
   				
   				$("#checkResult").show();
   				$("#checkResult").css("color", "red").text("5자 이상으로 입력해주세요.");
   				$("#enrollForm button[type=submit]").attr("disabled", true);
			}
   			
   			});
   		});
   	});
   </script>
   
   <script>
      function validate() {
          
          var memberId = document.getElementById("memberId");
          var memberPwd = document.getElementById("memberPwd");
          var checkPwd = document.getElementById("checkPwd");
          var memberName = document.getElementById("memberName");
          var phone = document.getElementById("phone");
          var email = document.getElementById("email1");
          
          var regExp = /^[a-z\d]{5,20}$/i;
          if(!regExp.test(memberId.value)) {
              
        	  alert("영문(소문자), 숫자를  포함하여 5자 이상 20자 이하로만 입력해주세요.");
              memberId.select(); // 재입력 유도
              
              return false;
          }
          
         regExp = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,20}$/;
         if(!regExp.test(memberPwd.value)) {
             
        	  alert("특문(!@#$%^), 영문(대소문자), 숫자 포함하여 8자 이상 20자 이하로 총 12~20자로 입력해주세요.");
             
        	  memberPwd.value = "";
              memberPwd.focus(); // 재입력 유도
              return false;
          }
          
          if($("input[name=memberPwd]").val() != $("input[name=checkPwd]").val()) {
            
        	  alert("비밀번호가 일치하지 않습니다.");
              checkPwd.select(); // 재입력 유도
             
              return false;
          }
          
          regExp = /^[가-힣]{2,6}$/;
          
          if(!regExp.test(memberName.value)) {
              
        	  alert("한글로 된 2~6자리 이름을 입력해주세요.");
              memberName.select(); // 재입력 유도
             
              return false;
          }
          
          var regExp = /^(010)[0-9]{4}[0-9]{4}$/;
          
          if(!regExp.test(phone.value)) {
             
        	  alert("-빼고 유효한 전화번호를 입력해주세요.");
              phone.select(); // 재입력 유도
              
              return false;
          }
          regExp = /^([0-9a-zA-Z_\.-]+)$/i;
          if(!regExp.test(email.value)) {
              alert("숫자 또는 영어만 입력해주세요.");
              email.select(); // 재입력 유도
              return false;
          }
    
      	document.enrollForm.submit();
      }
      
      $(function() {
          $("#enrollbtn").click(function() {
              var email = "" + $("#email1").val() + "@" + $("#email2 option:selected").val();
              $("#email").val(email);
          });
      });
  </script>

</body>
</html>