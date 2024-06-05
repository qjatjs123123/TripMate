export const NAV_ITEM = Object.freeze([{
  title: "여행",
    name: 'map'
  },
  {
    title: "계획",
    name: 'plan'
  },
  {
    title: "핫플",
    name: 'hotplace'
  },
  {
    title: "내정보",
    name: 'user'
  },
]);

export const CONTENT_MAX_WIDTH = 1200;
export const MODAL_MAX_WIDTH = 800;
export const MODAL_MAX_HEIGHT = 800;

export const MAINIMG_LIST = Object.freeze([
  "/main/banner0.png",
  "/main/banner1.png",
  "/main/banner2.png",
  "/main/banner3.png"
]);

export const MAINMENU_LIST = Object.freeze([{
    img: "/main/icon-all.png",
    name: "전체"
  },
  {
    img: "/main/icon-car.png",
    name: "패키지"
  },
  {
    img: "/main/icon-hotel.png",
    name: "투어"
  },
  {
    img: "/main/icon-package.png",
    name: "티켓"
  },
  {
    img: "/main/icon-ticket.png",
    name: "교통"
  },
  {
    img: "/main/icon-tour.png",
    name: "숙소"
  },
]);

export const TMP_LIST = Object.freeze([{
    img: "/main/banner0.png",
    name: "전체123123123123123123"
  },
  {
    img: "/main/banner1.png",
    name: "패키지132asasasasdd"
  },
  {
    img: "/main/banner2.png",
    name: "투어213123213123123"
  },
  {
    img: "/main/banner3.png",
    name: "티켓asdasdas"
  },
  {
    img: "/main/banner0.png",
    name: "전체123123123123123123"
  },
  {
    img: "/main/banner0.png",
    name: "전체123123123123123123"
  },
]);


export const USERMENU_LIST = Object.freeze([
  "마이페이지",
  "로그아웃"
])

export const MAP_SIDE_MENU = Object.freeze([
  {title:'전체', value:0, url: "/map/all.png"},
  {title:'관광지', value:12, url: "/map/tourarea.png"},
  {title:'문화시설', value:14, url: "/map/museum.png"},
  {title:'축제행사', value:15, url: "/map/stage.png"},
  {title:'여행코스', value:25, url: "/map/course.png"},
  {title:'레포츠', value:28, url: "/map/lezure.png"},
  {title:'숙박', value:32, url: "/map/house.png"},
  {title:'쇼핑', value:38, url: "/map/shopping.png"},
  {title:'음식점', value:39, url: "/map/food.png"},
])

export const getMapContentTitle = (id) => {
  const result = MAP_SIDE_MENU.filter(item => item.value === id);
  return result.length ? result[0].title : '';
} 


export const httpStatusCode = {
  OK: 200,
  CREATE: 201,
  NOCONTENT: 204,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOTFOUND: 404,
};

export const SIDO = [
  { rnum: 0, code: 0, name: '전체' },
  { rnum: 1, code: '1', name: '서울' },
  { rnum: 2, code: '2', name: '인천' },
  { rnum: 3, code: '3', name: '대전' },
  { rnum: 4, code: '4', name: '대구' },
  { rnum: 5, code: '5', name: '광주' },
  { rnum: 6, code: '6', name: '부산' },
  { rnum: 7, code: '7', name: '울산' },
  { rnum: 8, code: '8', name: '세종' },
  { rnum: 9, code: '31', name: '경기' },
  { rnum: 10, code: '32', name: '강원' },
  { rnum: 11, code: '33', name: '충청' },
  { rnum: 12, code: '34', name: '충청' },
  { rnum: 13, code: '35', name: '경상' },
  { rnum: 14, code: '36', name: '경상' },
  { rnum: 15, code: '37', name: '전북' },
  { rnum: 16, code: '38', name: '전라' },
  { rnum: 17, code: '39', name: '제주' }
];