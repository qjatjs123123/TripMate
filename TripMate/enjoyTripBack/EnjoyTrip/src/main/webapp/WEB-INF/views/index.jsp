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
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="./assets/css/style.css">
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

  </style>
</head>
<body>
  <jsp:include page="./commons/nav.jsp" />

  <!-- Page Content-->
  <div class="container">
    <div style="width: 100%; height: 50px;"></div>
    <!-- Heading Row-->
    <div class="row gx-4 gx-lg-5 align-items-center my-5">
      <div class="col-lg-7 mt-5">
        <img class="img-fluid rounded mb-4 mb-lg-0" src="./assets/img/thumbnail.jpg" alt="...">
      </div>
      <div class="col-lg-5">
        <h1 class="font-weight-regular; text-white">Enjoy한 Trip을<br /> 즐기는법✨</h1>
        <p style="color:white">
          <br />Enjoy Your Trip! 여행 정보부터 실시간 지도 서비스, <br /> 그리고 skrr한 여행 친구들이 모이는 게시판까지! <br /> <br /> 여행을 진짜 특별하게 만들어주는 많은 기능들! <br />
          여행의 즐거움을 함께 누리고 싶다면, 지금 바로 가입하세요!
          <br />
        </p>
        <a class="btn btn-primary" href="/trip/searchTrip.jsp">관광지 둘러보기</a>
      </div>
    </div>
    <!-- Call to Action-->
    <div class="card bg-dark my-5 text-left">
      <div class="card-body row">
        <h3 class="text-white m-0 po-5 col-md-2 mx-1 my-1 py-5">
          EnjoyTrip으로<br />여행을<br />더 즐겁게!
        </h3>
        <div class="card-body rounded col-md-3 mx-1 my-1" style="display: flex; flex-direction: column; justify-content: flex-start;">
          <p style="color:white">이번주 BEST 1 #해수욕장</p>
          <img src="./assets/img/beach.jpg" alt="Image" style="width: 100%; height: 70%;">
        </div>
        <div class="card-body rounded col-md-3 mx-1 my-1" style="display: flex; flex-direction: column;justify-content: flex-start;">
          <p style="color:white">이번주 BEST 2 #캠핑</p>
          <img src="./assets/img/camping.jpg" alt="Image" style="width: 100%; height: 70%;">
        </div>
        <div class="card-body rounded col-md-3 mx-1 my-1" style="display: flex; flex-direction: column; justify-content: flex-start;">
          <p style="color:white">이번주 BEST 3 #산</p>
          <img src="./assets/img/mountain.jpg" alt="Image" style="width: 100%; height: 70%;">
        </div>
      </div>
    </div>

    <div class="row gx-4 gx-lg-5">
      <!-- Review Cards will be rendered here -->
    </div>
  </div>
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>