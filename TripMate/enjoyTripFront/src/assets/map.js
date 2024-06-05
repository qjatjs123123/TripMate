// const MAP_LEVEL = 5;
// const INIT_POS = [37.500613, 127.036431];
// const serviceKey =
//   "9SEPyEkOfP0YKne2WEq0qqlIKK7OQY0vtIyLSQQiteKbQlMYau%2FG6GP8akZC4wjxbl%2BRcd96Dw3%2FHAJExs%2F%2FHg%3D%3D";

// export const mapMaker = () => {
//   const mapContainer = document.getElementById("map");
//   const mapOption = {
//     center: new kakao.maps.LatLng(INIT_POS[0], INIT_POS[1]), // 지도의 중심좌표
//     level: MAP_LEVEL, // 지도의 확대 레벨
//   };

//   // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
//   const map = new kakao.maps.Map(mapContainer, mapOption);
//   var clusterer = new kakao.maps.MarkerClusterer({
//     map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
//     averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
//     minLevel: 10 // 클러스터 할 최소 지도 레벨 
// });
//   // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
//   const mapTypeControl = new kakao.maps.MapTypeControl();
//   // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
//   // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
//   map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//   // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
//   var zoomControl = new kakao.maps.ZoomControl();
//   map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

//   return map;
// };

export const displayMarker = (positions, map) => {
  // 마커 이미지의 이미지 주소입니다
    // var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
  console.log(positions, map);
  var imageSrc = "/map/museum.png";

  for (var i = 0; i < positions.length; i++) {
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(35, 35);
    // if (positions[i].content_type_id === "12") imageSrc = "/map/tourarea.png";
    // else if (positions[i].content_type_id === "14") imageSrc = "/map/museum.png";
    // else if (positions[i].content_type_id === "15") imageSrc = "/map/stage.png";
    // else if (positions[i].content_type_id === "25") imageSrc = "/map/course.png";
    // else if (positions[i].content_type_id === "28") imageSrc = "/map/lezure.png";
    // else if (positions[i].content_type_id === "32") imageSrc = "/map/house.png";
    // else if (positions[i].content_type_id === "38") imageSrc = "/map/shopping.png";
    // else imageSrc = "/map/food.png";
    // 마커 이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    // var iwContent =
    //   '<div class="info" style="border: 1px solid black; width: 300px; height: 150px;">' +
    //   '<div style="width: 100%; height: 40px; background-color: #eee; line-height: 2.5em; font-size: 17px; font-weight: bold;">' +
    //   '<span style="margin-left: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; display:block">' +
    //   positions[i].title +
    //   "</span>" +
    //   "</div>" +
    //   '<div style="display: flex; flex-direction: row; width: 300px">' +
    //   '<div style="padding: 10px;">' +
    //   '<img src="' +
    //   positions[i].firstimage2 +
    //   '" width="90px" height="90px"/>' +
    //   "</div>" +
    //   '<div style="padding: 5px; width: calc(100% - 120px)">' +
    //   '<div style="width: 100%; height:50px;font-weight: bold; word-break:break-all;">' +
    //   positions[i].addr2 +
    //   " (" +
    //   positions[i].addr1 +
    //   ")" +
    //   "</div>" +
    //   "</div>" +
    //   "</div>" +
    //   "</div>",
    //   iwPosition = new kakao.maps.LatLng(33.450701, 126.570667),
    //   iwRemoveable = false;

    // var infowindow = new kakao.maps.InfoWindow({
    //   map: map, // 인포윈도우가 표시될 지도
    //   position: positions[i].latlng, // 마커를 표시할 위치
    //   content: iwContent,
    //   removable: iwRemoveable,
    // });
    // infowindow.close();
    // //마커를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(positions[i].mapy, positions[i].mapx);
    var marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: moveLatLon, // 마커를 표시할 위치
      title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    // markerList.push(marker);
    // windowList.push(infowindow);
    // kakao.maps.event.addListener(marker, "mouseover", makeOverListener(map, marker, infowindow));
    // kakao.maps.event.addListener(marker, "mouseout", makeOutListener(infowindow));
    marker.setMap(map);

  }
  
  // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
  // map.setCenter(moveLatLon);
};

const areaUrl = `https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=
${serviceKey}
&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json`;

export const getAreaUrl = (callback) => {
  fetch(areaUrl, {
      method: "GET",
    })
    .then((response) => response.json())
    .then((data) => callback(data));
};