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
    <title>로그아웃</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

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

        .signout-form {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        }

        /* 버튼 스타일 */
        .btn-primary,
        .btn-secondary {
            flex: 1;
            margin: 0 5px;
            font-size: 1.25rem;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
    </style>
</head>

<body>
<jsp:include page="../commons/nav.jsp" />
     
    <div class="container">
        <div class="signout-form">
            <h4 class="text-center mb-4">로그아웃 완료</h4>
            <p class="text-center mb-4">정상적으로 로그아웃 되었습니다!</p>
            <div class="d-flex justify-content-between">
                <button type="button" class="btn btn-primary btn-lg btn-block">로그인</button>
                <button type="button" class="btn btn-secondary btn-lg">확인</button>
            </div>
        </div>
    </div>
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