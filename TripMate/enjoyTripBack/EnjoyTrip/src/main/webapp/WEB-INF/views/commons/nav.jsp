<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="jakarta.tags.core" %>
 <%
String email = (String)session.getAttribute("email");
%>
 <c:set var="root" value="${pageContext.request.contextPath}" />
  <header>
    <!-- 상단 navbar start -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow fixed-top">
    <div class="container">
        <a class="navbar-brand text-primary fw-bold" href="${root}/index.jsp">
            <img src="${root}/assets/img/ssafy_logo.png" alt="" width="60" />
            EnjoyTrip
        </a>
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mb-2 me-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="${root}/trip/searchTrip.jsp">지역별여행지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="${root}/meet/meetTrip.jsp">약속장소정하기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="${root}/article?action=list">핫플자랑하기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="#">여행정보공유</a>
                </li>
            </ul>
            
            <!-- 로그인 전 -->
            <c:if test="${ empty email}">
			  <form id="login-form" class="d-flex" action="${root}/login" method="post">
	                <input type="hidden" name="action" value="mvSignIn">
	                <button class="btn btn-link nav-link" aria-current="page" type="submit">로그인</button>
	            </form>
	            <form id="signup-form" class="d-flex" action="${root}/user" method="post">
	                <input type="hidden" name="action" value="mvSignUp">
	                <button class="btn btn-primary" type="submit">회원가입</button>
	            </form>
			</c:if>
            
            <c:if test="${not empty email}">
			  <form id="mypage-form" class="d-flex" action="${root}/user" method="post">
                <input type="hidden" name="action" value="myPage">
                	<button class="btn btn-link nav-link" aria-current="page" type="submit">마이페이지</button>
	            </form>
	            <button class="btn btn-link nav-link" aria-current="page" onclick="logout()">로그아웃</button>
			</c:if>
              
        </div>
    </div>
</nav>

  </header>
  <script>
  
  function logout() {
	  location.href = "${root}/login?action=signOut";
  }
  </script>