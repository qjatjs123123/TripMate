<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:if test="${article ne null}">
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    <title>SSAFY</title>
  </head>
  <body>
   <jsp:include page="../commons/nav.jsp" />
  <div style="height:100px; width:100%"></div>
    <div class="container" style="background:white">
   
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글보기</mark>
          </h2>
        </div>
        <div class="col-lg-8 col-md-10 col-sm-12">
          <div class="row my-2">
            <h2 class="text-secondary px-5">${article.articleNo}. ${article.subject}</h2>
          </div>
          <div class="row">
            <div class="col-md-8">
              <div class="clearfix align-content-center">
                <img
                  class="avatar me-2 float-md-start bg-light p-2"
                  src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
                />
                <p>
                  <span class="fw-bold">${article.userId}</span> <br />
                  <span class="text-secondary fw-light"> ${article.registerTime} 조회 : ${article.hit} </span>
                </p>
              </div>
            </div>
            <div class="col-md-4 align-self-center text-end">댓글 : 17</div>
            <div class="divider mb-3"></div>
            <div class="text-secondary">
              ${article.content}
            </div>
            <div class="divider mt-3 mb-3"></div>
            <div class="d-flex justify-content-end" style="margin-top:50px">
              <button type="button" id="btn-list" class="btn btn-outline-primary mb-3">
                글목록
              </button>
              <button type="button" id="btn-mv-modify" class="btn btn-outline-success mb-3 ms-1">
                글수정
              </button>
              <button type="button" id="btn-delete" class="btn btn-outline-danger mb-3 ms-1">
                글삭제
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
    <script>
      document.querySelector("#btn-list").addEventListener("click", function () {
        location.href = "${root}/article?action=list";
      });
      document.querySelector("#btn-mv-modify").addEventListener("click", function () {
        location.href = "${root}/article?action=mvmodify" + "&articleNo="+ ${article.articleNo};
      });
      document.querySelector("#btn-delete").addEventListener("click", function () {
        location.href = "${root}/article?action=delete" + "&articleNo="+ ${article.articleNo};
      });
    </script>
  </body>
</html>
</c:if>
<c:if test="${article eq null}">
	<script>
	alert("글이 삭제되었거나 부적절한 URL 접근입니다.");
	location.href = "${root}/article?action=list";
	</script>
</c:if>
