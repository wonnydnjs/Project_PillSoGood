<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="resources/images/favicon.ico" type="image/x-icon">
<title>제품 등록</title>
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
    
    #proImg { height: 480px; border-top: solid lightgrey; padding: 20px 0px; }

    #proImg_1_1 { width: 100%; height: 100%; }
  

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
                <form method="post" action="insert.pr" enctype="multipart/form-data">
                    <table>
                        <thead>
                            <tr align="right" height="115px">
                                <td colspan="4">
                                    <button class="btn btn-primary" type="submit" id="button-addon2" style="margin-right: 5px;">등록</button>
                                    <button type="reset" class="btn btn-danger">취소</button>
                                </td>
                            </tr>
                        </thead>
                        <tbody height="350px" width="50%">
                            <tr>
                                <td align="center" rowspan="4" width="50%">
                                    <div id="tgg"><div id="imgg"><div id="proImgg"><img id="titleImg"></div></div></div>
                                </td>
                                <th width="7%">효능</th>
                                <td><input class="form-control" name="productExplain"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td><input class="form-control" name="productName"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <th>재고</th>
                                <td><input class="form-control" name="productStock"></td>
                                <td width="10%" style="padding-left: 10px">개</td>
                            </tr>
                            <tr height="175px">
                                <th>가격</th>
                                <td><input class="form-control" name="productPrice"></td>
                                <td style="padding-left: 10px">원</td>
                            </tr>
                        </tbody>
                        <tfoot height="530px">
                            <tr>
                                <td colspan="4">
                                    <div id="proImg">
                                        <div id="proImg_1_1"><img id="contentImg1"></div>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>
                    </table>

                    <div id="file-area">
                        <!-- input[type=file id=file$ name=file$]*4 + Enter -->
                        <input type="file" id="file1" name="upfile" onchange="loadImg(this, 1);" required> <!-- 대표이미지 업로드용 (대표이미지 - 썸네일은 필수) -->
                        <input type="file" id="file2" name="upfile" onchange="loadImg(this, 2);" required> <!-- 상세이미지 업로드용 -->
                    </div>

                </form>
            </div>
            <div id="content_3"></div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>

    

    <script>
        $(function() {

            $("#file-area").hide();

            $("#titleImg").click(function() {
                $("#file1").click();
            });

            $("#contentImg1").click(function() {
                $("#file2").click();
            });

        });

        function loadImg(inputFile, num) {
            // inputFile : 현재 변화가 생긴 input type="file" 요소 객체
            // num : 몇번째 input 요소인지 확인 후 해당 그 영역에 미리보기 하기 위한 변수

            // input type="file" 요소 객체는
            // 내부적으로 files 라는 속성을 가지고있음
            // => 현재 이 input 태그로 선택된 파일들의 정보를 배열 형식으로 가지고있음
            // console.log(inputFile.files.length);
            // 파일 선택 시 1, 파일 선택 취소시 0 이 출력됨
            // => 즉, 파일의 존재 유무를 알 수 있다.

            if(inputFile.files.length == 1) { // 선택된 파일이 있을 경우
                
                // 선택된 파일을 읽어들여서 그 영역에 맞는 곳에 미리보기 기능 추가

                // 파일을 읽어들일 FileReader 객체 생성
                var reader = new FileReader();

                // 파일을 읽어들이는 메소드 속성을 호출
                // => 어느 파일을 읽어들일건지 그 파일의 정보 자체를 매개변수로 제시해야함
                // => inputFile.files 라는 배열의 0 번째 인덱스에 파일 정보가 담겨있음
                reader.readAsDataURL(inputFile.files[0]);
                // => 해당 파일을 읽어들이는 순간
                //    그 파일만의 고유한 URL 주소가 하나 부여됨 (FileReader 객체의 result 속성에)
                // => 이 고유한 URL 주소를 각 img 태그의 src 속성으로 부여

                // 파일 읽기가 완료되었을 때 실행할 함수를 정의
                reader.onload = function(e) {

                    // e : 현재 발생한 이벤트의 정보 (이벤트객체)
                    // e.target : 현재 이벤트가 발생된 요소 (이벤트를 당한 요소객체)

                    // e.target == reader  == this
                    // $("#titleImg").attr("src", e.target.result);

                    // 각 영역에 맞춰서 이미지 미리보기
                    switch(num) {
                        case 1 : $("#titleImg").attr("src", e.target.result); break;
                        case 2 : $("#contentImg1").attr("src", e.target.result); break;
                    }
                };
            } else { // 선택된 파일이 사라졌을 경우

                // 미리보기 이미지를 사라지게 하기 => src 속성에 null 대입
                switch(num) {
                    case 1 : $("#titleImg").attr("src", null); break;
                    case 2 : $("#contentImg1").attr("src", null); break;
                }
            }
        }
    </script>
    
</body>
</html>