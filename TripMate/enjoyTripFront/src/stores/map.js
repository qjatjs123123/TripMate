/* eslint-disable no-undef */
import {
  defineStore
} from "pinia";
import {
  ref
} from "vue";
import {
  getMapList
} from "@/api/map.js";
import {
  useApiStore
} from "@/stores/api";
import {
  useUserStore
} from "@/stores/user";

import {
  SIDO
} from '@/assets/Constants.js';
export const useMapStore = defineStore("mapStore", () => {
  const contentTypeId = ref(0);
  const areaCode = ref(0);
  const keyword = ref("");
  const areaList = ref(SIDO);
  let mapList = ref([])
  const apiStore = useApiStore();
  const {
    apiStateFunc
  } = apiStore;
  const pageNo = ref(0);
  const userStore = useUserStore();
  const {
    userId
  } = userStore;
  let mapRef = [];
  let ClusterRef = {};
  const INIT_POS = [37.500613, 127.036431];
  const serviceKey =
    "9SEPyEkOfP0YKne2WEq0qqlIKK7OQY0vtIyLSQQiteKbQlMYau%2FG6GP8akZC4wjxbl%2BRcd96Dw3%2FHAJExs%2F%2FHg%3D%3D";
  const areaUrl = `https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=
    ${serviceKey}
    &numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json`;
  const markers = [];
  const isdetailModal = ref(false);
  const detailData = ref({});

  const getAreaUrl = (callback) => {
    fetch(areaUrl, {
        method: "GET"
      })
      .then((response) => response.json())
      .then((data) => callback(data));
  };

  const changeStateByContentId = (content_id, state) => {
    mapList.value = mapList.value.map(item =>
      item.content_id === content_id ? { ...item, isExist: state } : item
    );
  };

  const findItemByContentId = (content_id) => {
    return mapRef.filter(item => item.content_id === content_id);
  };

  const hideMarkers = () => {
    markers.forEach((marker) => marker.setMap(null));
  }

  const displayMarker = () => {
    ClusterRef.clear();

    const markers = mapList.value.map((position) => {
      var imageSrc = "/map/museum.png";
      if (position.content_type_id === 12) imageSrc = "/map/tourarea.png";
      else if (position.content_type_id === 14) imageSrc = "/map/museum.png";
      else if (position.content_type_id === 15) imageSrc = "/map/stage.png";
      else if (position.content_type_id === 25) imageSrc = "/map/course.png";
      else if (position.content_type_id === 28) imageSrc = "/map/lezure.png";
      else if (position.content_type_id === 32) imageSrc = "/map/house.png";
      else if (position.content_type_id === 38) imageSrc = "/map/shopping.png";
      else imageSrc = "/map/food.png";
      var imageSize = new kakao.maps.Size(25, 25);
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
      var moveLatLon = new kakao.maps.LatLng(position.mapy, position.mapx);
      var spanContent = `<div class ="label"><span class="left"></span><span class="center" style="font-size: 14px">${position.title}</span><span class="right"></span></div>`;
      var iwContent = 
        '<div class="info" style="border: 1px solid black; width: 300px; height: 150px;">' +
            '<div style="width: 100%; height: 40px; background-color: #eee; line-height: 2.5em; font-size: 17px; font-weight: bold;">' +
                '<span style="margin-left: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; display: block;">' + 
                    position.title + 
                '</span>' +
            '</div>' +
            '<div style="display: flex; flex-direction: row; width: 300px;">' +
                '<div style="padding: 10px;">' +
                    '<img src="' + position.first_image + '" width="90px" height="90px"/>' +
                '</div>' +
                '<div style="padding: 5px; width: calc(100% - 120px);">' +
                    '<div style="width: 100%; height: 50px; font-weight: bold; word-break: break-all;">' +
                        position.addr2 + ' (' + position.addr1 + ')' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>',
        iwPosition = new kakao.maps.LatLng(33.450701, 126.570667),
        iwRemoveable = false;
      // var marker = {
      //   position: moveLatLon,
      //   image: markerImage,
      //     text: '텍스트를 표시할 수 있어요!' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
      // };
      var customOverlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(position.mapy-0.00005, position.mapx),
        content: spanContent 
    });
          // 지도의 확대/축소 이벤트 리스너 등록
      kakao.maps.event.addListener(mapRef, 'zoom_changed', function() {
        // 현재 지도의 레벨 가져오기
        var currentLevel = mapRef.getLevel();
        
        // 레벨이 10보다 크면 CustomOverlay 숨기기
        if (currentLevel > 6) {
            customOverlay.setMap(null);
        } else { // 그 외의 경우에는 다시 보이기
            customOverlay.setMap(mapRef);
        }
      });
    customOverlay.setMap(mapRef);
      var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(position.mapy, position.mapx),
        title: position.title,
        image: markerImage,
        text: "123123"
      });
      var infowindow = new kakao.maps.InfoWindow({
        map: mapRef, // 인포윈도우가 표시될 지도
        position: moveLatLon,
        content : iwContent,
        removable : iwRemoveable
    });
      infowindow.close();
      kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(mapRef, marker, infowindow));
      kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
      kakao.maps.event.addListener(marker, 'click', makeClickListener(mapRef, marker, infowindow, position));
      return marker;
    });

    if (markers.length > 0) mapRef.setCenter(new kakao.maps.LatLng(mapList.value[0].mapy, mapList.value[0].mapx));
    ClusterRef.addMarkers(markers);
  };

  const makeClickListener = (map, marker, infowindow, position) => () => {
    detailData.value = position;
    isdetailModal.value = true;
  };

  const makeOverListener = (map, marker, infowindow) => () => {
    infowindow.open(map, marker);
  };

  const makeOutListener = (infowindow) => () => {
    infowindow.close();
  };
  const mapMaker = () => {
    const mapContainer = document.getElementById("map");
    const mapOption = {
      center: new kakao.maps.LatLng(INIT_POS[0], INIT_POS[1]),
      level: 5,
    };

    const map = new kakao.maps.Map(mapContainer, mapOption);

    const clusterer = new kakao.maps.MarkerClusterer({
      map: map,
      averageCenter: true,
      minLevel: 2,
    });

    const mapTypeControl = new kakao.maps.MapTypeControl();
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    mapRef = map;
    ClusterRef = clusterer;
  };


  const getMapListByParam = async (isSearch, isScroll) => {
    // if (isSearch) apiStateFunc('검색', '요청중...');
    if (!isScroll) pageNo.value = 0;
    const param = {
      contentTypeId: contentTypeId.value,
      areaCode: areaCode.value,
      keyword: keyword.value,
      pageNo: pageNo.value,
      userId
    };

    await getMapList(param, (response) => {
      if (!isScroll) mapList.value = [];
      mapList.value = mapList.value.concat([...response.data]);
      if (isSearch) {
        apiStateFunc('검색', '완료...');
        hideMarkers();
      }
      displayMarker([...response.data]);
    }, (err) => {
      console.log(err);
      if (isSearch) apiStateFunc('검색', '실패...');
    });
  }

  return {
    getMapListByParam,
    getAreaUrl,
    displayMarker,
    mapMaker,
    changeStateByContentId,
    areaList,
    mapList,
    contentTypeId,
    areaCode,
    keyword,
    pageNo,
    mapRef,
    isdetailModal,
    detailData
  };
});