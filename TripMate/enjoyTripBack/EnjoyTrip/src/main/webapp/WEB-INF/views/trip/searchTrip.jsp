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
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"
    />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="../assets/js/key.js"></script>
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
    
      </style>
</head>
<body>
   <jsp:include page="../commons/nav.jsp" />
  		<div style="width: 100%; height: 50px;"></div>  
    
  <!-- Page Content-->
  <div class="container">
    <div style="width:100%; height: 20px;"></div>
    <div class="row">
        <div class="col-md-12 mt-5">
            <div class="alert alert-primary mt-3 text-center fw-bold" role="alert">
              전국 관광지 정보
            </div>
            <!-- 관광지 검색 start -->
            <form class="d-flex my-3" onsubmit="return false;" role="search">
              <select id="search-area" class="form-control form-control-lg mr-2">
                <option value="0" selected>검색 할 지역 선택</option>
              </select>
              <select id="search-content-id" class="form-control form-control-lg mr-2">
                <option value="0" selected>관광지 유형</option>
                <option value="12">관광지</option>
                <option value="14">문화시설</option>
                <option value="15">축제공연행사</option>
                <option value="25">여행코스</option>
                <option value="28">레포츠</option>
                <option value="32">숙박</option>
                <option value="38">쇼핑</option>
                <option value="39">음식점</option>
              </select>
              <input
                id="search-keyword"
                class="form-control-lg mr-2 p-2"
                type="search"
                placeholder="검색어"
                aria-label="검색어"
              />
              <!-- <button class="btn btn-primary" type="button" disabled>
                <span class="spinner-grow spinner-grow-sm" aria-hidden="true"></span>
                <span class="visually-hidden" role="status">Loading...</span>
              </button> -->
              <button id="btn-search" class="btn btn-outline-primary btn-block" type="button">
                <i class="fa fa-search"></i>
              </button>
            </form>
            <!-- kakao map start -->
            <div id="map" class="mt-3" style="width: 100%; height: 400px"></div>
            <!-- kakao map end -->
            <div class="row">
              <table class="table table-striped" style="display: none">
                <thead>
                  <tr>
                    <th>대표이미지</th>
                    <th>관광지명</th>
                    <th>주소</th>
                    <th>위도</th>
                    <th>경도</th>
                  </tr>
                </thead>
                <tbody id="trip-list"></tbody>
              </table>
            </div>
            <!-- 관광지 검색 end -->
          </div>
    </div>
  </div>

  <!-- Bootstrap Bundle with Popper -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0421ed8286c13579b81800849de9febf"
    ></script>
    <script>
        // index page 로딩 후 전국의 시도 설정.
        let areaUrl =
          "https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=" +
          serviceKey +
          "&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json";
  
        // fetch(areaUrl, { method: "GET" }).then(function (response) { return response.json() }).then(function (data) { makeOption(data); });
        fetch(areaUrl, { method: "GET" })
          .then((response) => response.json())
          .then((data) => makeOption(data));
        const markerList = [];
        const windowList = [];
        function makeOption(data) {
          let areas = data.response.body.items.item;
          // console.log(areas);
          let sel = document.getElementById("search-area");
          areas.forEach((area) => {
            let opt = document.createElement("option");
            opt.setAttribute("value", area.code);
            opt.appendChild(document.createTextNode(area.name));
  
            sel.appendChild(opt);
          });
        }
  
        // 검색 버튼을 누르면..
        // 지역, 유형, 검색어 얻기.
        // 위 데이터를 가지고 공공데이터에 요청.
        // 받은 데이터를 이용하여 화면 구성.
        document.getElementById("btn-search").addEventListener("click", () => {
            hideMarkers();
          /* let baseUrl = `https://apis.data.go.kr/B551011/KorService1/`;
          // let searchUrl = `https://apis.data.go.kr/B551011/KorService1/searchKeyword1?serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A`;
          // let searchUrl = `https://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A`;
          let queryString = `serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A`;*/
          let baseUrl = "${root}/trip";
          let queryString = ""; 
          let areaCode = document.getElementById("search-area").value;
          let contentTypeId = document.getElementById("search-content-id").value;
          let keyword = document.getElementById("search-keyword").value; 
          
          
          if (areaCode !== '') queryString = queryString + '&areaCode=' + areaCode;
          if (contentTypeId !== '') queryString = queryString + '&contentTypeId=' + contentTypeId;
          if (keyword !== '') queryString = queryString + '&keyword=' + keyword;
          let searchUrl = baseUrl + "?" + queryString;
  		  
          fetch(searchUrl)
            .then((response) => response.json())
            .then((data) => makeList(data));
        });
  
        var positions; // marker 배열.
        function makeList(data) {
          document.querySelector("table").setAttribute("style", "display: ;");
          let trips = data;
          let tripList = ``;
          positions = [];
          
          trips.forEach(function(area) {
        	    tripList += '<tr onclick="moveCenter(' + area.latitude + ', ' + area.longitude + ');">';
        	    tripList += '<td><img src="' + area.first_image + '" width="100px"></td>';
        	    tripList += '<td>' + area.title + '</td>';
        	    tripList += '<td>' + area.addr1 + ' ' + area.addr2 + '</td>';
        	    tripList += '<td>' + area.latitude + '</td>';
        	    tripList += '<td>' + area.longitude + '</td>';
        	    tripList += '</tr>';

        	    var markerInfo = {
        	        title: area.title,
        	        firstimage2: area.first_image,
        	        addr1: area.addr1,
        	        addr2: area.addr2,
        	        latlng: new kakao.maps.LatLng(area.latitude, area.longitude)
        	    };
        	    positions.push(markerInfo);
        	});
          document.getElementById("trip-list").innerHTML = tripList;
          displayMarker();
        }
  
        // 카카오지도
        var mapContainer = document.getElementById("map"), // 지도를 표시할 div
          mapOption = {
            center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
            level: 5, // 지도의 확대 레벨
          };
  
        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);
        // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
        var mapTypeControl = new kakao.maps.MapTypeControl();

        // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
        // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        function displayMarker() {
          // 마커 이미지의 이미지 주소입니다
        //   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
        let contentTypeId = document.getElementById("search-content-id").value;
        var imageSrc = "../assets/img/museum.png";
        if (contentTypeId === "12") imageSrc = "../assets/img/tourarea.png";
        else if (contentTypeId === "14") imageSrc = "../assets/img/museum.png";
        else if (contentTypeId === "15") imageSrc = "../assets/img/stage.png";
        else if (contentTypeId === "25") imageSrc = "../assets/img/course.png";
        else if (contentTypeId === "28") imageSrc = "../assets/img/lezure.png";
        else if (contentTypeId === "32") imageSrc = "../assets/img/house.png";
        else if (contentTypeId === "38") imageSrc = "../assets/img/shopping.png";
        else imageSrc = "../assets/img/food.png";

          for (var i = 0; i < positions.length; i++) {
            // 마커 이미지의 이미지 크기 입니다
            var imageSize = new kakao.maps.Size(35, 35);
  
            // 마커 이미지를 생성합니다
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            var iwContent = '<div class="info" style="border: 1px solid black; width: 300px; height: 150px;">' +
            '<div style="width: 100%; height: 40px; background-color: #eee; line-height: 2.5em; font-size: 17px; font-weight: bold;">' +
            '<span style="margin-left: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; display:block">' + positions[i].title + '</span>' +
            '</div>' +
            '<div style="display: flex; flex-direction: row; width: 300px">' +
            '<div style="padding: 10px;">' +
            '<img src="' + positions[i].firstimage2 + '" width="90px" height="90px"/>' +
            '</div>' +
            '<div style="padding: 5px; width: calc(100% - 120px)">' +
            '<div style="width: 100%; height:50px;font-weight: bold; word-break:break-all;">' +
            positions[i].addr2 + ' (' + positions[i].addr1 + ')' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>',
            iwPosition = new kakao.maps.LatLng(33.450701, 126.570667),
            iwRemoveable = false;

            var infowindow = new kakao.maps.InfoWindow({
                map: map, // 인포윈도우가 표시될 지도
                position: positions[i].latlng, // 마커를 표시할 위치
                content : iwContent,
                removable : iwRemoveable
            });
            infowindow.close();
            //마커를 생성합니다
            var marker = new kakao.maps.Marker({
              map: map, // 마커를 표시할 지도
              position: positions[i].latlng, // 마커를 표시할 위치
              title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
              image: markerImage, // 마커 이미지
            });
            markerList.push(marker);
            windowList.push(infowindow);
            kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
            kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
          }
  
          // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
          map.setCenter(positions[0].latlng);
        }
  
        function moveCenter(lat, lng) {
          map.setCenter(new kakao.maps.LatLng(lat, lng));
        }
        function hideMarkers() {
            const infoElements = document.querySelectorAll('.info');
            windowList.forEach(element => {
                element.close();
            });
            markerList.forEach((marker) => marker.setMap(null)); 
        }
        // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
        const makeOverListener = (map, marker, infowindow) => () => {
            infowindow.open(map, marker);
        };

        const makeOutListener = (infowindow) => () => {
            infowindow.close();
        };

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
