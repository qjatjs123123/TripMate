import { defineStore } from "pinia";
import { ref, computed, watch } from "vue";
import { useApiStore } from "@/stores/api";

const formattedDate = (message) => {
  const year = message.getFullYear();
  const month = String(message.getMonth() + 1).padStart(2, "0");
  const day = String(message.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
};

export const usePlanStore = defineStore("planStore", () => {
  const apiStore = useApiStore();
  const { apiStateFunc } = apiStore;
  let cartList = ref([]);
  const isbottomGnb = ref(true);
  const isLeftGnb = ref(true);
  const curDate = ref(1);
  const startDate = ref(new Date());
  const startDateString = ref(formattedDate(new Date()));
  const dayList = ref([[]]);
  const tripTitle = ref("제목을 입력하세요");
  const isSettingModal = ref(false);
  const ismemoShowModal = ref(false);
  const ismemoModal = ref(false);
  const memoData = ref({});
  const curContent_id = ref(0);
  const endDateString = ref("");
  let markers = [];
  let mapRef = [];
  let polyline = null;
  let ClusterRef = "";
  let customOverlayList = [];
  let markerNumberList = [];

  const INIT_POS = [37.500613, 127.036431];
  const linePath = ref([
    new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
    new kakao.maps.LatLng(33.452739313807456, 126.5709308145358),
    new kakao.maps.LatLng(33.45178067090639, 126.5726886938753),
  ]);

  const currentDayList = computed(() => {
    return dayList.value[curDate.value - 1] || [];
  });

  const currentMarkers = computed(() => {
    return currentDayList.value.map((location) => {
      return new kakao.maps.LatLng(location.mapy, location.mapx);
    });
  });

  const hideLine = () => {
    if (!polyline) return;
    polyline.setMap(null);
    polyline = "";
  };

  const makeLine = (map) => {
    hideLine();
    if (currentMarkers.value.length !== 0) {
      polyline = new kakao.maps.Polyline({
        path: currentMarkers.value, // 선을 구성하는 좌표배열 입니다
        strokeWeight: 3, // 선의 두께 입니다
        strokeColor: "#ff6b6b", // 선의 색깔입니다
        strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
        strokeStyle: "solid", // 선의 스타일입니다
      });
    }
    // 지도에 표시할 선을 생성합니다
    if (!polyline) return;
    polyline.setMap(map);
  };

  watch(
    dayList,
    () => {
      const result = new Date(startDate.value);
      result.setDate(result.getDate() + dayList.value.length - 1);
      endDateString.value = formattedDate(result);
    },
    {
      deep: true,
      immediate: true,
    }
  );

  const findContentById = (content_id) => {
    for (let i = 0; i < dayList.value.length; i++) {
      for (let j = 0; j < dayList.value[i].length; j++) {
        if (dayList.value[i][j].content_id === content_id) {
          return dayList.value[i][j];
        }
      }
    }
  };

  const hideMarkers = () => {
    markers.forEach((marker) => {
      marker.setMap(null);
    });
  };

  const hideLay = () => {
    customOverlayList.forEach((overlay) => {
      overlay.setMap(null);
    });
  };

  const displayMarker = () => {
    if (ClusterRef === "") return;
    ClusterRef.clear();
    hideMarkers();
    customOverlayList = [];
    markerNumberList = [];
    markers = currentDayList.value.map((position, idx) => {
      var imageSrc = "/map/museum.png";
      if (position.content_type_id === 12) imageSrc = "/map/tourarea.png";
      else if (position.content_type_id === 14) imageSrc = "/map/museum.png";
      else if (position.content_type_id === 15) imageSrc = "/map/stage.png";
      else if (position.content_type_id === 25) imageSrc = "/map/course.png";
      else if (position.content_type_id === 28) imageSrc = "/map/lezure.png";
      else if (position.content_type_id === 32) imageSrc = "/map/house.png";
      else if (position.content_type_id === 38) imageSrc = "/map/shopping.png";
      else imageSrc = "/map/food.png";
      var imageSize = new kakao.maps.Size(15, 15);
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
      var moveLatLon = new kakao.maps.LatLng(position.mapy, position.mapx);
      var spanContent = `<div class ="label"><span class="left"></span><span class="center" style="font-size: 14px">${position.title}</span><span class="right"></span></div>`;
      var iwContent =
          '<div class="info" style="border: 1px solid black; width: 300px; height: 150px;">' +
          '<div style="width: 100%; height: 40px; background-color: #eee; line-height: 2.5em; font-size: 17px; font-weight: bold;">' +
          '<span style="margin-left: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; display: block;">' +
          position.title +
          "</span>" +
          "</div>" +
          '<div style="display: flex; flex-direction: row; width: 300px;">' +
          '<div style="padding: 10px;">' +
          '<img src="' +
          position.first_image +
          '" width="90px" height="90px"/>' +
          "</div>" +
          '<div style="padding: 5px; width: calc(100% - 120px);">' +
          '<div style="width: 100%; height: 50px; font-weight: bold; word-break: break-all;">' +
          position.addr2 +
          " (" +
          position.addr1 +
          ")" +
          "</div>" +
          "</div>" +
          "</div>" +
          "</div>",
        iwPosition = new kakao.maps.LatLng(33.450701, 126.570667),
        iwRemoveable = false;
      // var marker = {
      //   position: moveLatLon,
      //   image: markerImage,
      //     text: '텍스트를 표시할 수 있어요!' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
      // };
      const customOverlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(position.mapy - 0.00005, position.mapx),
        content: spanContent,
      });
      customOverlayList.push(customOverlay);
      // 지도의 확대/축소 이벤트 리스너 등록
      kakao.maps.event.addListener(mapRef, "zoom_changed", function () {
        // 현재 지도의 레벨 가져오기
        var currentLevel = mapRef.getLevel();

        // 레벨이 10보다 크면 CustomOverlay 숨기기
        if (currentLevel > 6) {
          customOverlay.setMap(null);
        } else {
          // 그 외의 경우에는 다시 보이기
          customOverlay.setMap(mapRef);
        }
      });
      customOverlay.setMap(mapRef);
      var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(position.mapy, position.mapx),
        title: position.title,
        image: markerImage,
        text: "123123",
      });

      addMarker(new kakao.maps.LatLng(position.mapy, position.mapx), idx);
      var infowindow = new kakao.maps.InfoWindow({
        map: mapRef, // 인포윈도우가 표시될 지도
        position: moveLatLon,
        content: iwContent,
        removable: iwRemoveable,
      });
      infowindow.close();
      kakao.maps.event.addListener(
        marker,
        "mouseover",
        makeOverListener(mapRef, marker, infowindow)
      );
      kakao.maps.event.addListener(marker, "mouseout", makeOutListener(infowindow));
      return marker;
    });

    if (markers.length > 0) {
      const last = currentDayList.value.length - 1;
      mapRef.setCenter(
        new kakao.maps.LatLng(currentDayList.value[last].mapy, currentDayList.value[last].mapx)
      );
    }

    for (var i = 0; i < markerNumberList.length; i++) {
      markerNumberList[i].setMap(mapRef);
    }

    ClusterRef.addMarkers(markers);
  };

  function addMarker(position, idx) {
    var imageSrc =
        "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
      imageSize = new kakao.maps.Size(46, 47), // 마커 이미지의 크기
      imgOptions = {
        spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
        spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
        offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
      },
      markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
      marker1 = new kakao.maps.Marker({
        position: position, // 마커의 위치
        image: markerImage,
      });

    marker1.setMap(mapRef); // 지도 위에 마커를 표출합니다
    markerNumberList.push(marker1); // 배열에 생성된 마커를 추가합니다
  }
  function removeNumberMarker() {
    for (var i = 0; i < markerNumberList.length; i++) {
      console.log("!@312");
      markerNumberList[i].setMap(null);
    }
    markerNumberList = [];
  }
  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
  function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }
    markers = [];
  }
  watch(
    currentDayList,
    () => {
      removeNumberMarker();
      hideLay();
      displayMarker();
      makeLine(mapRef);
    },
    {
      deep: true,
      immediate: true,
    }
  );
  const makeOverListener = (map, marker, infowindow) => () => {
    infowindow.open(map, marker);
  };

  const makeOutListener = (infowindow) => () => {
    infowindow.close();
  };
  const addDate = () => {
    dayList.value.push([]);
  };

  const changeCurDate = (index) => {
    curDate.value = index;
  };

  const setterContent_id = (id) => {
    curContent_id.value = id;
  };

  function addDays() {
    const result = new Date(startDate.value);
    result.setDate(result.getDate() + dayList.value.length - 1);

    return formattedDate(result);
  }

  const mapMaker = () => {
    const mapContainer = document.getElementById("map");
    const mapOption = {
      center: new kakao.maps.LatLng(INIT_POS[0], INIT_POS[1]),
      level: 12,
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
    // 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
    makeLine(map);

    mapRef = map;
    ClusterRef = clusterer;
  };
  return {
    mapMaker,
    isbottomGnb,
    isLeftGnb,
    currentDayList,
    addDate,
    changeCurDate,
    dayList,
    curDate,
    tripTitle,
    isSettingModal,
    startDate,
    startDateString,
    ismemoModal,
    ismemoShowModal,
    memoData,
    findContentById,
    setterContent_id,
    curContent_id,
    endDateString,
    mapRef,
  };
});
