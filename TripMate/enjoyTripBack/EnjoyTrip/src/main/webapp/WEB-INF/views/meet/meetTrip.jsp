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
              약속장소 정하기
            </div>
            <!-- 관광지 검색 start -->
            <!-- kakao map start -->
            <div id="map" class="mt-3" style="width: 100%; height: 600px"></div>
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
    	// 원 반경 변수
		var drawingFlag = false; // 원이 그려지고 있는 상태를 가지고 있을 변수입니다
    	var centerPosition; // 원의 중심좌표 입니다
    	var drawingCircle; // 그려지고 있는 원을 표시할 원 객체입니다
    	var drawingLine; // 그려지고 있는 원의 반지름을 표시할 선 객체입니다
    	var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이 입니다
    	var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이 입니다

    	var circles = []; // 클릭으로 그려진 원과 반경 정보를 표시하는 선과 커스텀오버레이를 가지고 있을 배열입니다

    
    
    
    	const markerList = [];
        const windowList = [];
    
    
    
        // index page 로딩 후 전국의 시도 설정.
        let areaUrl =
          "https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=" +
          serviceKey +
          "&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json";
  		let middleMarker = null;
  		let isDrag = false;
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
        
	    // 지도를 클릭했을때 클릭한 위치에 마커를 추가하도록 지도에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	        // 클릭한 위치에 마커를 표시합니다 
	        addMarker(mouseEvent.latLng);   
	        
	    });
	
	    // 지도에 표시된 마커 객체를 가지고 있을 배열입니다
	    var markers = [];
	
	
	    // 마커를 생성하고 지도위에 표시하는 함수입니다
	    function addMarker(position) {
	    	if (drawingFlag) return;
	        // 마커를 생성합니다
	        var marker = new kakao.maps.Marker({
	            position: position
	        });
	
	        // 마커가 지도 위에 표시되도록 설정합니다
	        marker.setMap(map);
	        marker.setDraggable(true); 
	        // 생성된 마커를 배열에 추가합니다
	        markers.push(marker);
	        isDrag = true;
	        getMiddleMarkers();
	        isDrag = false;
	        kakao.maps.event.addListener(marker, 'click', function() {
	            hideMarkers(marker);
	        });
	        kakao.maps.event.addListener(marker, 'dragstart', function() {
	        	isDrag = true;
	        });
	        kakao.maps.event.addListener(marker, 'dragend', function() {
	        	isDrag = false;
	        });
	    }
	    
	    function hideMarkers(marker) {
	        marker.setMap(null);  
			markers = markers.filter((item) => {
				if (marker !== item) return item;
			});
			isDrag = true;
	        getMiddleMarkers();
	        isDrag = false;
	    }
	    
	   
	    
	    
	    function getMiddleMarkers() {
			if (!isDrag) return;		
	    	const targetLa = markers.reduce((accumulator, currentValue) => {
	    		  return accumulator + currentValue.getPosition().La;
	    	}, 0) / markers.length;
	    	const targetMa = markers.reduce((accumulator, currentValue) => {
	    		  return accumulator + currentValue.getPosition().Ma;
	    	}, 0) / markers.length;
	    	
	    	 // 타켓 마커 이미지 init
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png'; // 마커이미지의 주소입니다    
		    var imageSize = new kakao.maps.Size(24, 35); // 마커이미지의 크기입니다
		    //imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		    // 반경
		    var radius = 0;
		    
	    	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
	        markerPosition = new kakao.maps.LatLng(targetMa, targetLa); // 마커가 표시될 위치입니다
	        
	        //기존미들 마커 삭제
	        if (middleMarker !== null) middleMarker.setMap(null); 
	        
	    	// 마커 만들기
	    	var markertmp = new kakao.maps.Marker({
	    	    position: markerPosition, 
	    	    image: markerImage // 마커이미지 설정 
	    	});
	    	middleMarker = markertmp;
	    
	    	// 지도에 클릭 이벤트를 등록합니다
	    	kakao.maps.event.addListener(middleMarker, 'click', function(mouseEvent) {
	    		removeCircles();
	    	    // 클릭 이벤트가 발생했을 때 원을 그리고 있는 상태가 아니면 중심좌표를 클릭한 지점으로 설정합니다
	    	    if (!drawingFlag) {    
	    	        
	    	        // 상태를 그리고있는 상태로 변경합니다
	    	        drawingFlag = true; 

	    	        // 원이 그려질 중심좌표를 클릭한 위치로 설정합니다 
	    	        centerPosition = middleMarker.getPosition();
					
	    	        console.log(centerPosition);
	    	        // 그려지고 있는 원의 반경을 표시할 선 객체를 생성합니다
	    	        if (!drawingLine) {
	    	            drawingLine = new kakao.maps.Polyline({
	    	                strokeWeight: 3, // 선의 두께입니다
	    	                strokeColor: '#00a0e9', // 선의 색깔입니다
	    	                strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    	                strokeStyle: 'solid' // 선의 스타일입니다
	    	            });    
	    	        }
	    	        
	    	        // 그려지고 있는 원을 표시할 원 객체를 생성합니다
	    	        if (!drawingCircle) {                    
	    	            drawingCircle = new kakao.maps.Circle({ 
	    	                strokeWeight: 1, // 선의 두께입니다
	    	                strokeColor: '#00a0e9', // 선의 색깔입니다
	    	                strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    	                strokeStyle: 'solid', // 선의 스타일입니다
	    	                fillColor: '#00a0e9', // 채우기 색깔입니다
	    	                fillOpacity: 0.2 // 채우기 불투명도입니다 
	    	            });     
	    	        }
	    	        
	    	        // 그려지고 있는 원의 반경 정보를 표시할 커스텀오버레이를 생성합니다
	    	        if (!drawingOverlay) {
	    	            drawingOverlay = new kakao.maps.CustomOverlay({
	    	                xAnchor: 0,
	    	                yAnchor: 0,
	    	                zIndex: 1
	    	            });              
	    	        }
	    	    }
	    	    });
	    	// 지도에 마우스무브 이벤트를 등록합니다
	    	// 원을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 원의 위치와 반경정보를 동적으로 보여주도록 합니다
	    	kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
	    	        
	    	    // 마우스무브 이벤트가 발생했을 때 원을 그리고있는 상태이면
	    	    if (drawingFlag) {

	    	        // 마우스 커서의 현재 위치를 얻어옵니다 
	    	        var mousePosition = mouseEvent.latLng; 
	    	        
	    	        // 그려지고 있는 선을 표시할 좌표 배열입니다. 클릭한 중심좌표와 마우스커서의 위치로 설정합니다
	    	        var linePath = [centerPosition, mousePosition];     
	    	        
	    	        // 그려지고 있는 선을 표시할 선 객체에 좌표 배열을 설정합니다
	    	        drawingLine.setPath(linePath);
	    	        
	    	        // 원의 반지름을 선 객체를 이용해서 얻어옵니다 
	    	        var length = drawingLine.getLength();
	    	        
	    	        if(length > 0) {
	    	            
	    	            // 그려지고 있는 원의 중심좌표와 반지름입니다
	    	            var circleOptions = { 
	    	                center : centerPosition, 
	    	            radius: length,                 
	    	            };
	    	            
	    	            // 그려지고 있는 원의 옵션을 설정합니다
	    	            drawingCircle.setOptions(circleOptions); 
	    	                
	    	            // 반경 정보를 표시할 커스텀오버레이의 내용입니다
	    	            var radius = Math.round(drawingCircle.getRadius()),   
	    	            content = '<div class="info">반경 <span class="number">' + radius + '</span>m</div>';
	    	            
	    	            // 반경 정보를 표시할 커스텀 오버레이의 좌표를 마우스커서 위치로 설정합니다
	    	            drawingOverlay.setPosition(mousePosition);
	    	            
	    	            // 반경 정보를 표시할 커스텀 오버레이의 표시할 내용을 설정합니다
	    	            drawingOverlay.setContent(content);
	    	            
	    	            // 그려지고 있는 원을 지도에 표시합니다
	    	            drawingCircle.setMap(map); 
	    	            
	    	            // 그려지고 있는 선을 지도에 표시합니다
	    	            drawingLine.setMap(map);  
	    	            
	    	            // 그려지고 있는 원의 반경정보 커스텀 오버레이를 지도에 표시합니다
	    	            drawingOverlay.setMap(map);
	    	            
	    	        } else { 
	    	            
	    	            drawingCircle.setMap(null);
	    	            drawingLine.setMap(null);    
	    	            drawingOverlay.setMap(null);
	    	            
	    	        }
	    	    }     
	    	});     

	    	// 지도에 마우스 오른쪽 클릭이벤트를 등록합니다
	    	// 원을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면
	    	// 마우스 오른쪽 클릭한 위치를 기준으로 원과 원의 반경정보를 표시하는 선과 커스텀 오버레이를 표시하고 그리기를 종료합니다
	    	kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

	    	    if (drawingFlag) {

	    	        // 마우스로 오른쪽 클릭한 위치입니다 
	    	        var rClickPosition = mouseEvent.latLng; 

	    	        // 원의 반경을 표시할 선 객체를 생성합니다
	    	        var polyline = new kakao.maps.Polyline({
	    	            path: [centerPosition, rClickPosition], // 선을 구성하는 좌표 배열입니다. 원의 중심좌표와 클릭한 위치로 설정합니다
	    	            strokeWeight: 3, // 선의 두께 입니다
	    	            strokeColor: '#00a0e9', // 선의 색깔입니다
	    	            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    	            strokeStyle: 'solid' // 선의 스타일입니다
	    	        });
	    	        
	    	        // 원 객체를 생성합니다
	    	        var circle = new kakao.maps.Circle({ 
	    	            center : centerPosition, // 원의 중심좌표입니다
	    	            radius: polyline.getLength(), // 원의 반지름입니다 m 단위 이며 선 객체를 이용해서 얻어옵니다
	    	            strokeWeight: 1, // 선의 두께입니다
	    	            strokeColor: '#00a0e9', // 선의 색깔입니다
	    	            strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    	            strokeStyle: 'solid', // 선의 스타일입니다
	    	            fillColor: '#00a0e9', // 채우기 색깔입니다
	    	            fillOpacity: 0.2  // 채우기 불투명도입니다 
	    	        });
	    	        
	    	        radius = Math.round(circle.getRadius()), // 원의 반경 정보를 얻어옵니다
	    	            content = getTimeHTML(radius); // 커스텀 오버레이에 표시할 반경 정보입니다

	    	        
	    	        // 반경정보를 표시할 커스텀 오버레이를 생성합니다
	    	        var radiusOverlay = new kakao.maps.CustomOverlay({
	    	            content: content, // 표시할 내용입니다
	    	            position: rClickPosition, // 표시할 위치입니다. 클릭한 위치로 설정합니다
	    	            xAnchor: 0,
	    	            yAnchor: 0,
	    	            zIndex: 1 
	    	        });  

	    	        // 원을 지도에 표시합니다
	    	        circle.setMap(map); 
	    	        
	    	        // 선을 지도에 표시합니다
	    	        polyline.setMap(map);
	    	        
	    	        // 반경 정보 커스텀 오버레이를 지도에 표시합니다
	    	        radiusOverlay.setMap(map);
	    	        
	    	        // 배열에 담을 객체입니다. 원, 선, 커스텀오버레이 객체를 가지고 있습니다
	    	        var radiusObj = {
	    	            'polyline' : polyline,
	    	            'circle' : circle,
	    	            'overlay' : radiusOverlay
	    	        };
	    	        
	    	        // 배열에 추가합니다
	    	        // 이 배열을 이용해서 "모두 지우기" 버튼을 클릭했을 때 지도에 그려진 원, 선, 커스텀오버레이들을 지웁니다
	    	        circles.push(radiusObj);   
	    	    
	    	        // 그리기 상태를 그리고 있지 않는 상태로 바꿉니다
	    	        drawingFlag = false;
	    	        
	    	        // 중심 좌표를 초기화 합니다  
	    	        centerPosition = null;
	    	        
	    	        // 그려지고 있는 원, 선, 커스텀오버레이를 지도에서 제거합니다
	    	        drawingCircle.setMap(null);
	    	        drawingLine.setMap(null);   
	    	        drawingOverlay.setMap(null);
	    	        
	    	        let baseUrl = "${root}/meet?action=meet";
    	          	let queryString = ""; 
    	          	let lat = middleMarker.getPosition().La;
    	          	let lon = middleMarker.getPosition().Ma;
    	          	let area = radius;
	    	          
	    	          
	    	          if (lat !== '') queryString = queryString + '&lat=' + lat;
	    	          if (lon !== '') queryString = queryString + '&lon=' + lon;
	    	          if (area !== '') queryString = queryString + '&area=' + area;
	    	          let searchUrl = baseUrl + queryString;
	    	  		  console.log(searchUrl);
	    	          fetch(searchUrl)
	    	            .then((response) => response.json())
	    	            .then((data) => makeList(data));
	    	    }
	    	});    
	    	    

	    	// 마우스 우클릭 하여 원 그리기가 종료됐을 때 호출하여 
	    	// 그려진 원의 반경 정보와 반경에 대한 도보, 자전거 시간을 계산하여
	    	// HTML Content를 만들어 리턴하는 함수입니다
	    	function getTimeHTML(distance) {

	    	    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
	    	    var walkkTime = distance / 67 | 0;
	    	    var walkHour = '', walkMin = '';

	    	    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
	    	    if (walkkTime > 60) {
	    	        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
	    	    }
	    	    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

	    	    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
	    	    var bycicleTime = distance / 227 | 0;
	    	    var bycicleHour = '', bycicleMin = '';

	    	    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
	    	    if (bycicleTime > 60) {
	    	        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
	    	    }
	    	    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

	    	    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
	    	    var content = '<ul class="info">';
	    	    content += '    <li>';
	    	    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
	    	    content += '    </li>';
	    	    content += '    <li>';
	    	    content += '        <span class="label">도보</span>' + walkHour + walkMin;
	    	    content += '    </li>';
	    	    content += '    <li>';
	    	    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
	    	    content += '    </li>';
	    	    content += '</ul>'

	    	    return content;
	    	}
	    	markertmp.setMap(map); 
	    	
	    	
	    }
	    
    	// 지도에 표시되어 있는 모든 원과 반경정보를 표시하는 선, 커스텀 오버레이를 지도에서 제거합니다
    	function removeCircles() {         
    	    for (var i = 0; i < circles.length; i++) {
    	        circles[i].circle.setMap(null);    
    	        circles[i].polyline.setMap(null);
    	        circles[i].overlay.setMap(null);
    	    }         
    	    circles = [];
    	}
    	var positions; // marker 배열.
    	function makeList(data) {
            let trips = data;
            positions = [];
            
            trips.forEach(function(area) {

          	    var markerInfo = {
          	        title: area.title,
          	        firstimage2: area.first_image,
          	        addr1: area.addr1,
          	        addr2: area.addr2,
          	        latlng: new kakao.maps.LatLng(area.latitude, area.longitude)
          	    };
          	    positions.push(markerInfo);
          	});
            displayMarker();
          }
    	
    	function displayMarker() {
            // 마커 이미지의 이미지 주소입니다
          //   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
          var imageSrc = "../assets/img/tourarea.png";


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
              const mar = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도
                position: positions[i].latlng, // 마커를 표시할 위치
                title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image: markerImage, // 마커 이미지
              });
              markerList.push(mar);
              windowList.push(infowindow);
              kakao.maps.event.addListener(mar, 'mouseover', makeOverListener(map, mar, infowindow));
              kakao.maps.event.addListener(mar, 'mouseout', makeOutListener(infowindow));
            }
    
            // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
            map.setCenter(positions[0].latlng);
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
          function moveCenter(lat, lng) {
            map.setCenter(new kakao.maps.LatLng(lat, lng));
          }
	    // 
	    setInterval(getMiddleMarkers, 60);
      </script>

    
</body>
</html>
