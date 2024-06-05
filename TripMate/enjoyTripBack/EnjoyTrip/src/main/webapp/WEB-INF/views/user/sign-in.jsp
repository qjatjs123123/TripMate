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
    <title>로그인</title>

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

        .signin-form {
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
    </style>
</head>

<body>
<jsp:include page="../commons/nav.jsp" />
     
  
  <form id="form-sign-in" action="${root}/login" method="post">
	<input type="hidden" name="action" value="signIn">
    <div class="container">
        <div class="signin-form">
            <h4 class="text-center mb-4">로그인</h4>
               <div class="form-group">
                   <label for="email">아이디</label>
                   <input type="email" class="form-control" id="email" name="email" placeholder="아이디를 입력하세요" required>
               </div>
               <div class="form-group">
                   <label for="password">비밀번호</label>
                   <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
               </div>
               <div class="form-group form-check">
                   <input type="checkbox" class="form-check-input" id="remember">
                   <label class="form-check-label" for="remember">아이디 저장</label>
               </div>
               <div class="d-flex justify-content-between">
                   <button type="submit" class="btn btn-primary btn-lg btn-block">로그인</button>
                   <button type="button" class="btn btn-secondary btn-lg" data-toggle="modal" data-target="#findUserPasswordModal">비밀번호 찾기</button>
               </div>
        </div>
    </div>
    </form>

    <!-- 비밀번호 찾기 모달창 -->
	<div id="findUserPasswordModal" class="modal fade" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">비밀번호 찾기</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">	            	
	                <form id="findUserPasswordForm">
	                    <div class="form-group">
						    <label for="email">이메일</label>
						    <input type="email" class="form-control email-input" name="email" required>
						</div>
	                    <button type="button" class="btn btn-primary btn-block" onclick="findUserPassword()">이메일로 비밀번호 찾기</button>
	                </form>
	                <!-- 비밀번호 표시 영역 -->
	                <div id="passwordResult" style="display: none;">
	                    <p id="foundPasswordMessage"></p>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>



    <!-- Bootstrap JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	        crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	        crossorigin="anonymous"></script>


    <script src="../assets/js/script.js"></script>
    <script>

      
        function logout() {
          localStorage.setItem("login", "false");
          event();
        }
        function findUserPassword() {
            console.log("finduserpassword");
            var email = $(".email-input").val();
            console.log("email to find pw: ", email);
            $.post("${root}/login", { action: "findPassword", email: email }, function(foundPassword) {
                $("#findUserPasswordModal").modal("show");
                $("#foundPasswordMessage").text('찾은 비밀번호: ' + foundPassword);
                $("#passwordResult").show();
            });
        }

    </script>
    
</body>

</html>