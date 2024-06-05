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
    <title>마이 페이지</title>

    <!-- Bootstrap CSS -->
    <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
 

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${root}/assets/css/style.css">

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
    <header>
    <!-- 상단 navbar start -->
    <jsp:include page="../commons/nav.jsp" />
  		<div style="width: 100%; height: 50px;"></div>
    <div class="container mt-5">
	    <div class="row">
	        <div class="col-md-12">
	            <div class="card">
	                <div class="card-body">
	                    <h2 class="card-title">회원 정보</h2>
	                    <p class="card-text">이름: ${userInfo.name}</p>
	                    <p class="card-text">닉네임: ${userInfo.nickname}</p>
	                    <p class="card-text">이메일: ${userInfo.email}</p>
	                    <p class="card-text">지역: ${userInfo.sido} | ${userInfo.gugun}</p>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="row mt-3">
	        <div class="col-md-6">
	            <button class="btn btn-primary btn-block" data-toggle="modal" data-target="#userInfoFormModal">회원 정보 수정</button>
	        </div>
	        <div class="col-md-6">
	            <button class="btn btn-danger btn-block" data-toggle="modal" data-target="#confirmDeleteModal">회원 정보 삭제</button>
	        </div>
	    </div>
	</div>


    <!-- 회원 정보 수정 모달창 -->
	<div id="userInfoFormModal" class="modal fade" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">회원 정보 수정</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <form id="userInfoForm" action="${root}/user" method="post">
	                    <input type="hidden" name="action" value="modifyPassword">
	                    <input type="hidden" name="email" value="${userInfo.email }">
	                    <div class="form-group">
	                        <label for="password">새로운 비밀번호</label>
	                        <input type="password" class="form-control password-input" name="newPassword" required>
	                    </div>
	                    <button type="button" class="btn btn-primary btn-block" onclick="modifyPassword()">수정 완료</button>
	                </form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>


    <!-- 삭제 전 확인 모달창 -->
	<div id="confirmDeleteModal" class="modal fade" tabindex="-1" role="dialog">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">회원 정보 삭제</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <p>정말로 회원 정보를 삭제하시겠습니까?</p>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger" onclick="withdraw()">삭제</button>
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

    <script src="${root}/assets/js/script.js"></script>
    <script>
        
        function modifyPassword() {
            console.log("modifyPW");
                        
            var newPassword = $(".password-input").val();
            console.log("new password to modify: ", newPassword);
                  
            $.ajax({
                type: "POST",
                url: "${root}/user",
                data: {
                    action: "modifyPassword",
                    email: "${userInfo.email}",
                    newPassword: newPassword
                },
                success: function(response) {
                	var isSuccess = JSON.parse(response);
                	if(isSuccess) alert("비밀번호 수정에 성공했습니다.");
                	else alert("비밀번호 수정에 실패했습니다.");
                	 $('#userInfoFormModal').modal('hide'); // 모달 창 닫기
                },

            });
        }
        function withdraw() {
       		console.log("withdraw");
       		$.ajax({
                type: "POST",
                url: "${root}/user",
                data: {
                    action: "withdraw",
                    email: "${userInfo.email}"
                },
                success: function(response) {
                	var isSuccess = JSON.parse(response);
                	if(isSuccess) alert("회원 삭제에 성공했습니다.");
                	else alert("비밀번호 수정에 실패했습니다.");

                	location.href = "${root}/index.jsp";
                   
                },
                
            });
        }
        </script>
</body>

</html>