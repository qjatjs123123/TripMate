<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EnjoyTrip</title>
</head>
<body>
  
  <script>
  window.onload = () => {
    alert("아이디 또는 비밀번호 확인 후 다시 로그인하세요.");
    location.href = "${root}/index.jsp";
  };

  </script>
</body>
</html>