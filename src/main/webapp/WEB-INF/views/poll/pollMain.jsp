<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>건강설문</title>
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
    #content_2_2 { height: auto; color: black; }

    /* ---------------------- */

    #content_2_1>div {
    	width: 80%;
    	height: 20px;
    	margin: auto;
    }
    #content_2_2>div {
    	width: 100%;
    	margin: auto;
    }
    
    .text>p {
        font-size: 30px;
        font-weight: bold;
        color: black;
        text-align: center;
        margin: 40px 0px 0px 0px;
    }
    
    .textForm>table { 
        margin-top: 40px; 
        border-collapse: separate;
	    border-spacing: 0 20px;
        color: black;
    }
    
    .surveyBtn { margin-top: 40px; }

	input[type="date"]::-webkit-inner-spin-button,
	input[type="date"]::-webkit-calendar-picker-indicator {
	    display: none;
	    -webkit-appearance: none;
	}
	
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}

    /* 비디오 컨트롤러 숨기기 */
      /* 전체화면 버튼 */
      video::-webkit-media-controls-fullscreen-button {
        display: none !important;
      }

      /* 일시정지, 재생 버튼 */
      video::-webkit-media-controls-play-button {
        display: none !important;
      }

      /* 재생 슬라이드..? */
      video::-webkit-media-controls-timeline {
        display: none !important;
      }

      /* 현재 진행 시간 */
      video::-webkit-media-controls-current-time-display {
        display: none !important;
      }

      /* 전체 시간 */
      video::-webkit-media-controls-time-remaining-display {
        display: none !important;
      }

      /* 음소거 버튼 */
      video::-webkit-media-controls-mute-button {
        display: none !important;
      }

      /* 볼륨 조절 슬라이드 */
      video::-webkit-media-controls-volume-slider {
        display: none !important;
      }

      video::-webkit-media-controls-fullscreen-button {
        display: none !important;
      }

      video::-webkit-media-controls {
        display: none;
      }

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
	                <div class="progress">
	                    <div class="progress-bar progress-bar-striped progress-bar-animated" id="surveyProgressBar" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width : 10%;"></div>
	                </div>
                </div>
                <div id="content_2_2">

                    <!-- 1번 -->
                    <div id="survey1" align="center">
                        <video style="width: 70%; object-fit: cover;" autoplay muted controls>
                            <source type="video/mp4" src="resources/images/pillsoGood.mp4">
                        </video>

                        <div class="text"><p>PillSoGood 과 함께 건강 설문 시작하기</p></div>
                        <div class="surveyBtn">
                            <div align="center">
                            	<c:choose>
                            		<c:when test="${ loginUser eq null }">
                            			<button type="button" class="btn btn-secondary btn-lg" onclick="login();" style="width: 200px">설문 시작</button>	
                            		</c:when>
                            		<c:otherwise>
                            			<button type="button" class="btn btn-secondary btn-lg" onclick="nextSurvey(2); insertPoll();" style="width: 200px">설문 시작</button>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                        </div>
                    </div>
                
                	<script>
                		function login() {
                			alert("로그인이 필요한 서비스 입니다.");
                			location.href = 'loginForm.me';
                		}
                	</script>

                    <!-- 2번 -->
                    <div id="survey2" style="display:none;">
                        <div class="text"><p>기본 정보 입력<br><span style="font-size: 15px;">설문자의 기본 인적사항을 입력해주세요.</span></p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <th width="80">생년월일</th>
                                    <td  width="100"><input type="date" class="form-control" style="width: 10;" id="memberBirthYear"  name="memberBirthYear" required max='9999-12-31'></td>
                                </tr>
                                <tr>
                                    <th>키</th>
                                    <td width="100"><input type="number" class="form-control" max="999" oninput="maxLengthCheck(this)" id="height" name="height" required maxlength="3"></td>
                                    <td width="40">&nbsp;cm</td>
                                </tr>
                                <tr>
                                    <th>몸무게</th>
                                    <td><input type="number" class="form-control" id="weight" max="999" name="weight" oninput="maxLengthCheck(this)" required maxlength="3"></td>
                                    <td>&nbsp;kg</td>
                                </tr>
                                <tr>
                                    <th>성별</th>
                                    <td>
                                        <input class="form-check-input" type="radio" id="female" name="gender" value="F" required>
                                        <label class="form-check-label" for="female">여</label>&emsp;&emsp;
                                        <input class="form-check-input" type="radio" name="gender" id="male" value="M" required>
                                        <label class="form-check-label" for="male">남</label>
                                    </td>
                                </tr>
                            </table>
                            <div class="surveyBtn">
                                <div align="center">
                                    <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(3); updateMember(); insertResultType1(19);">다음</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- 3번 -->
                    <div id="survey3" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">눈건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey3Answer" id="answer3_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer3_1">휴대폰이나 컴퓨터를 보는 시간이 하루에 총 5시간 이상이다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey3Answer" value="2" id="answer3_2"></td>
                                    <td><label class="form-check-label" for="answer3_2">예전에 비해 시력이 좋지 않아 보이던 글씨가 잘 안보이는 경우가 많다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey3Answer" value="3" id="answer3_3"></td>
                                    <td><label class="form-check-label" for="answer3_3">눈이 자주 뻑뻑한 느낌이 있어 인공 눈물을 넣을 때가 많다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey3Answer" value="4" id="answer3_4"></td>
                                    <td><label class="form-check-label" for="answer3_4">평소 피곤하다고 생각될 경우 눈이 쉽게 충혈된다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey3Answer" value="5" id="answer3_5"></td>
                                    <td><label class="form-check-label" for="answer3_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(4,$('input[name=survey3Answer]:checked').val(),1);">다음</button>
                            </div>
                        </div>
                    </div>



                    <!-- 4번 -->
                    <div id="survey4" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">간건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey4Answer" id="answer4_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer4_1">술을 일주일에 3회(2일에 1회) 이상 마신다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey4Answer" value="2" id="answer4_2"></td>
                                    <td><label class="form-check-label" for="answer4_2">술을 마실 경우, 보통 5잔이상 마시는게 기본이다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey4Answer" value="3" id="answer4_3"></td>
                                    <td><label class="form-check-label" for="answer4_3">예전에 비해 술을 먹고 나면 더 힘들고 술이 잘 깨지 않는다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey4Answer" value="4" id="answer4_4"></td>
                                    <td><label class="form-check-label" for="answer4_4">최근 더 피곤하고 나른하며 피로 회복이 잘 되지 않는다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey4Answer" value="5" id="answer4_5"></td>
                                    <td><label class="form-check-label" for="answer4_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(5,$('input[name=survey4Answer]:checked').val(),4);">다음</button>
                            </div>
                        </div>
                    </div>



                    <!-- 5번 -->
                    <div id="survey5" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">장건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey5Answer" id="answer5_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer5_1">배변을 할 때 시간이 오래 걸리고 방귀 냄새가 심하다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey5Answer" value="2" id="answer5_2"></td>
                                    <td><label class="form-check-label" for="answer5_2">채소나 과일 등 식이섬유가 함유된 음식을 거의 먹지 않는다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey5Answer" value="3" id="answer5_3"></td>
                                    <td><label class="form-check-label" for="answer5_3">종종 뱃속이 불편하고 설사나 변비를 자주 겪는 편이다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey5Answer" value="4" id="answer5_4"></td>
                                    <td><label class="form-check-label" for="answer5_4">치주 질환이 없는데, 최근 들어 입 냄새가 심해졌다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey5Answer" value="5" id="answer5_5"></td>
                                    <td><label class="form-check-label" for="answer5_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(6,$('input[name=survey5Answer]:checked').val(),13);">다음</button>
                            </div>
                        </div>
                    </div>



                    <!-- 6번 -->
                    <div id="survey6" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">식습관</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey6Answer" id="answer6_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer6_1">빵, 떡, 면종류 등 탄수화물이 많은 음식을 자주 먹는다. (하루에 2회 이상)</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey6Answer" value="2" id="answer6_2"></td>
                                    <td><label class="form-check-label" for="answer6_2">폭식과 과식이 잦고, 스트레스를 주로 음식으로 해소하는 편이다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey6Answer" value="3" id="answer6_3"></td>
                                    <td><label class="form-check-label" for="answer6_3">평소 섭취하는 음식량을 줄여도 체중을 감량하기 힘들다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey6Answer" value="4" id="answer6_4"></td>
                                    <td><label class="form-check-label" for="answer6_4">꾸준한 운동을 하고 있으나, 눈에 띄는 체중의 변화가 없다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey6Answer" value="5" id="answer6_5"></td>
                                    <td><label class="form-check-label" for="answer6_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(7,$('input[name=survey6Answer]:checked').val(),8);">다음</button>
                            </div>
                        </div>
                    </div>


                    <!-- 7번 -->
                    <div id="survey7" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">혈압건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey7Answer" id="answer7_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer7_1">오래 전 부터 혹은 최근 몇 년 동안 계속 비만인 상태였으며, 지금도 살이 빠지지 않고 있다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey7Answer" value="2" id="answer7_2"></td>
                                    <td><label class="form-check-label" for="answer7_2">움직이는 활동을 별로 좋아하지 않아 평소에 하는 운동이 하루에 20분 이하거나 거의 없다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey7Answer" value="3" id="answer7_3"></td>
                                    <td><label class="form-check-label" for="answer7_3">음주(주 1회 이상) 또는 흡연을 오랫동안 해왔거나 지금도 하고 있다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey7Answer" value="4" id="answer7_4"></td>
                                    <td><label class="form-check-label" for="answer7_4">평소 국물이 있는 음식을 먹을 때 남기지 않고 먹거나, 소금이나 간장으로 추가 간을 하는 경우가 많다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey7Answer" value="5" id="answer7_5"></td>
                                    <td><label class="form-check-label" for="answer7_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(8,$('input[name=survey7Answer]:checked').val(),16);">다음</button>
                            </div>
                        </div>
                    </div>

                    <!-- 8번 -->
                    <div id="survey8" style="display:none;">
                        <div class="text"><p><span style="color: #F3969A">혈행개선</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                        <div class="textForm">
                            <table align="center">
                                <tr>
                                    <td width="30px"><input class="form-check-input" type="radio" name="survey8Answer" id="answer8_1" value="1"></td>
                                    <td><label class="form-check-label" for="answer8_1">음주(주 1회 이상) 또는 흡연을 오랫동안 해왔거나 지금도 하고 있다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey8Answer" value="2" id="answer8_2"></td>
                                    <td><label class="form-check-label" for="answer8_2">튀김이나 삼겹살 혹은 베이컨 등 기름이 많은 음식과 인스턴트 음식을 자주 먹는다. (하루에 1번 이상)</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey8Answer" value="3" id="answer8_3"></td>
                                    <td><label class="form-check-label" for="answer8_3">음식을 먹을 때 소금이나 간장으로 추가 간을 하는 경우가 많다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey8Answer" value="4" id="answer8_4"></td>
                                    <td><label class="form-check-label" for="answer8_4">요즘들어 뒷목이 뻐근하고 몸에 힘이 없이 나른하고 축 쳐지는 느낌이 든다.</label></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="radio" name="survey8Answer" value="5" id="answer8_5"></td>
                                    <td><label class="form-check-label" for="answer8_5">해당사항없음</label></td>
                                </tr>
                            </table>
                        </div>
                        <div class="surveyBtn">
                            <div align="center">
                                <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(9,$('input[name=survey8Answer]:checked').val(),6);">다음</button>
                            </div>
                        </div>
                    </div>


                   <!-- 9번 -->
                   <div id="survey9" style="display:none;">
                    <div class="text"><p><span style="color: #F3969A">피부건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                    <div class="textForm">
                        <table align="center">
                            <tr>
                                <td width="30px"><input class="form-check-input" type="radio" name="survey9Answer" id="answer9_1" value="1"></td>
                                <td><label class="form-check-label" for="answer9_1">피부가 건조하여 거칠고 각질이 많이 생기는 편이다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey9Answer" value="2" id="answer9_2"></td>
                                <td><label class="form-check-label" for="answer9_2">최근 피부의 윤기와 탄력이 줄어, 주름이 많아졌다는 느낌을 종종 받는다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey9Answer" value="3" id="answer9_3"></td>
                                <td><label class="form-check-label" for="answer9_3">평소 스킨이나 로션을 바를때, 흡수가 잘 되지 않고 잘 발리지 않아 불편하다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey9Answer" value="4" id="answer9_4"></td>
                                <td><label class="form-check-label" for="answer9_4">피부건강을 관리하고 싶으나 무엇을 해야 할 지 잘 모르겠다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey9Answer" value="5" id="answer9_5"></td>
                                <td><label class="form-check-label" for="answer9_5">해당사항없음</label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="surveyBtn">
                        <div align="center">
                            <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(10,$('input[name=survey9Answer]:checked').val(),14);">다음</button>
                        </div>
                    </div>
                </div>

                <!-- 10번 -->
                <div id="survey10" style="display:none;">
                    <div class="text"><p><span style="color: #F3969A">뼈건강</span>에 대해 해당되는 내용을 선택해 주세요.</p></div>
                    <div class="textForm">
                        <table align="center">
                            <tr>
                                <td width="30px"><input class="form-check-input" type="radio" name="survey10Answer" id="answer10_1" value="1"></td>
                                <td><label class="form-check-label" for="answer10_1">최근 들어 뼈가 시리고 아픈 느낌이 있거나, 골절되는 경험이 잦아졌다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey10Answer" value="2" id="answer10_2"></td>
                                <td><label class="form-check-label" for="answer10_2">피임약, 여성호르몬 억제제 등의 약물을 복용한지 3개월이 넘었다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey10Answer" value="3" id="answer10_3"></td>
                                <td><label class="form-check-label" for="answer10_3">예전보다 자세가 구부정하고 실제 키보다 작아 보인다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey10Answer" value="4" id="answer10_4"></td>
                                <td><label class="form-check-label" for="answer10_4">다이어트를 할 경우 음식을 제한하는 무리한 다이어트를 시도하는 경우가 많다.</label></td>
                            </tr>
                            <tr>
                                <td><input class="form-check-input" type="radio" name="survey10Answer" value="5" id="answer10_5"></td>
                                <td><label class="form-check-label" for="answer10_5">해당사항없음</label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="surveyBtn">
                        <div align="center">
                            <button type="button" class="btn btn-info btn-lg" style="width: 200px" onclick="nextSurvey(11,$('input[name=survey10Answer]:checked').val(),5); fowardResult();">다음</button>
                        </div>
                    </div>
                </div>



                <!-- 11번 스피너 -->
                <div id="survey11" style="display:none;">
                   
                    <div align="center" style="font-size : 30px; margin-top : 100px;">

                        PillSoGood이 당신만을 위한 영양제를 추천 중입니다. <br>
                     	잠시만 기다려주세요!
                    </div>

                    <div id="survey2" align="center">
                        <img src="resources/images/Pendulum.gif" width="90" alt="">
                    </div>
                    
                </div>

                <!--content_2_2영역 끝-->
                </div>
                
                <div id="content_2_3"></div>
                
                </div>

                <div id="content_3"></div>
            </div>
        	<jsp:include page="../common/footer.jsp" />
        	    
        </div>
        
    


    <script>
        
        $(function() {

            
        });
        
        function maxLengthCheck(object){
            if (object.value.length > object.maxLength){
                object.value = object.value.slice(0, object.maxLength);
            }    
        }
        

        var progressValue = 20;

        function nextSurvey(num, surveyAnswer, productNo) {
        	
			if(num == 3 && $("#memberHeight").val()==0) {
                
                alert("키를 입력해주세요");
                return false;

            } else if(num == 3 && $("#memberWeight").val()==0) {
                
                alert("몸무게를 입력해주세요");
                return false;

            } else if(num == 3 && $('input[name=gender]:checked').val()==undefined) {
                
                alert("성별을 선택해주세요");
                return false;

            } else if( num == 4 && $('input[name=survey3Answer]:checked').val()==undefined) {
                
                alert("답안을 선택해주세요");
                return false;

            } else if( num == 5 && $('input[name=survey4Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;

            } else if( num == 6 && $('input[name=survey5Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;

            } else if( num == 7 && $('input[name=survey6Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;
            } else if( num == 8 && $('input[name=survey7Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;
            }else if( num == 9 && $('input[name=survey8Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;
            }else if( num == 10 && $('input[name=survey8Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;
            }else if( num == 11 && $('input[name=survey8Answer]:checked').val()==undefined) {

                alert("답안을 선택해주세요");
                return false;
            }
			
			if((num > 3) && (surveyAnswer == 1 || surveyAnswer == 2)) {
				
				insertResultType1(productNo);
			} else if ((num > 3) && (surveyAnswer == 3 || surveyAnswer == 4)) {
				
				insertResultType2(productNo);
			}

                progress = progressValue + '%';

                progressValue=progressValue+10;

            $("#survey"+(num -1)).css("display","none");
            $("#survey"+num).css("display","block");
            $("#surveyProgressBar").css("width",progress);

        };
        
        var pollNo = 0;
        function insertPoll() {
        	
        	if(${loginUser.memberId != null}){
	        	$.ajax({
	        		url : "insertPoll.po",
	        		data : {
	        			
	     	  			memberNo : ${ loginUser.memberNo }
	        			
	        		},
	        		success : function(result) {
	        			
	        			pollNo = result.pollNo;
	        			
	        		},
	        		error : function() {
	        			console.log("pollMain insertPoll ajax failure");
	        		}
	        		
	        	});
        	} else {
        		alert("로그인이 필요한 서비스 입니다.");
        		return false;
        	}
        }
        
        function updateMember() {
        	
        	$.ajax({
        		url : "updateMem.po",
        		data : {
        			memberNo : ${ loginUser.memberNo},
        			memberBirthYear : $("#memberBirthYear").val(),
        			height : $("#height").val(),
        			weight : $("#weight").val(),
        			gender : $("input[name=gender]:checked").val()
        		},
        		success : function(result) {
        			
        		},
        		error : function() {
        			console.log("pollMain updateMember ajax failure");
        		}
        		
        	});
        	
        }
        
        function insertResultType1(productNo) {
        	
        	$.ajax({
        		url : "insertResultType.po",
        		data : {
        			pollLevel : 1,
        			pollNo : pollNo,
        			productNo : productNo
       			},
        		success : function(result) {
        			
        		},
        		error : function() {
        			
        			console.log("pollMain insertResultType1 ajax failure");
        		}
        		
        		
        	});
        	
        }
        
        function insertResultType2(productNo) {
        	
        	$.ajax({
        		url : "insertResultType.po",
        		data : {
        			pollLevel : 2,
        			pollNo : pollNo,
        			productNo : productNo
       			},
        		success : function(result) {
        			
        		},
        		error : function() {
        			
        			console.log("pollMain insertResultType2 ajax failure");
        		}
        		
        		
        	});
        	
        }

        function fowardResult() {
            setTimeout(function() {
                location.href='surveyResult.po';
            }, 5000);

        }

    </script>

</body>
</html>