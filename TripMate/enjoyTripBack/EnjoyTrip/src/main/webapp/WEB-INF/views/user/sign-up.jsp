<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>

  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link rel="stylesheet" href="../assets/css/style.css">

  <style>
    body {
      font-family: "yeongdeok";
      min-height: 100vh;
      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 680px;
      margin-top: 80px;
      padding: 32px;
      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
</head>

<body>
<jsp:include page="../commons/nav.jsp" />
   

<form id="form-sign-up" action="${root}/user" method="post">
	<input type="hidden" name="action" value="signUp">
  <div class="container mt-5">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        
        	<div class="row">
	            <div class="col-md-6 mb-3">
	              <label for="name">이름</label>
	              <input type="text" class="form-control" id="name" name="name" placeholder="" required>
	              <div class="invalid-feedback">
	                이름을 입력해주세요.
	              </div>
	            </div>
	            <div class="col-md-6 mb-3">
	              <label for="nickname">닉네임</label>
	              <input type="text" class="form-control" id="nickname" name="nickname" placeholder="" required>
	              <div class="invalid-feedback">
	                닉네임을 입력해주세요.
	              </div>
	            </div>
          </div>

          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="ssafy@ssafy.com" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="" required>
            <div class="invalid-feedback">
              비밀번호를 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="confirm_password">비밀번호 확인</label>
            <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="" required>
            <div class="invalid-feedback">
              비밀번호를 확인해주세요.
            </div>
          </div>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="sido">시도</label>
              <select class="custom-select d-block w-100" id="sido" name="sido" onchange="populateGugun()">
                <option value=""></option>
                <option>서울특별시</option>
                <option>부산광역시</option>
                <option>대구광역시</option>
                <option>인천광역시</option>
                <option>광주광역시</option>
                <option>대전광역시</option>
                <option>울산광역시</option>
                <option>세종특별자치시</option>
                <option>경기도</option>
                <option>강원도</option>
                <option>충청북도</option>
                <option>충청남도</option>
                <option>전라북도</option>
                <option>전라남도</option>
                <option>경상북도</option>
                <option>경상남도</option>
                <option>제주특별자치도</option>
              </select>
              <div class="invalid-feedback">
                시도를 선택해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="gugun">구군</label>
              <select class="custom-select d-block w-100" id="gugun" name="gugun">
                <option value=""></option>
              </select>
              <div class="invalid-feedback">
                구군을 선택해주세요.
              </div>
            </div>
          </div>

          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          <div class="mb-4"></div>
          <button type="submit" class="btn btn-primary btn-lg btn-block" style="text-decoration: none; color:white">가입</button>
      </div>
    </div>
  </div>
  </form>
  <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2024 SSAFY</p>
    </footer>
  <script>




    function populateGugun() {
      var sidoSelect = document.getElementById("sido");
      var gugunSelect = document.getElementById("gugun");
      gugunSelect.innerHTML = ""; // 이전 옵션 초기화

      var sido = sidoSelect.value;

      if (sido === "서울특별시") {
        var gugunList = ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"];
      } else if (sido === "부산광역시") {
        var gugunList = ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "강서구", "해운대구", "사하구", "금정구", "연제구", "수영구", "사상구", "기장군"];
      } else if (sido === "대구광역시") {
        var gugunList = ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군"];
      } else if (sido === "인천광역시") {
        var gugunList = ["중구", "동구", "미추홀구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"];
      } else if (sido === "광주광역시") {
        var gugunList = ["동구", "서구", "남구", "북구", "광산구"];
      } else if (sido === "대전광역시") {
        var gugunList = ["동구", "중구", "서구", "유성구", "대덕구"];
      } else if (sido === "울산광역시") {
        var gugunList = ["중구", "남구", "동구", "북구", "울주군"];
      } else {
        var gugunList = ["선택 없음"];
      }

      // 선택지 추가
      for (var i = 0; i < gugunList.length; i++) {
        var option = document.createElement("option");
        option.text = gugunList[i];
        gugunSelect.add(option);
      }
    }
  </script>
  <script>
    function login() {
        localStorage.setItem("login", "true");
    }
    window.onload = () => {
      
      event();
    };
  
    function event() {
      const isLogin = localStorage.getItem("login");
      let litags = document.querySelectorAll(".nav-item");
  
      litags.forEach((tag, idx) => {
        if (isLogin == "true") {
  
          if (idx == 4 || idx == 5) {
            tag.style.display = "none";
          }
          if(idx == 6 || idx == 7) {
            tag.style.display = "block";
          }
        }
        else{
          console.log(isLogin);
          if (idx == 4 || idx == 5) {
            tag.style.display = "block";
          }
          if(idx == 6 || idx == 7) {
            tag.style.display = "none";
          }
        }
        
      })
    }
    function logout() {
      localStorage.setItem("login", "false");
      event();
    }
</script>
</body>

</html>