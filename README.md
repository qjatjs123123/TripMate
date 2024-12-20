<div align="center">
<img src="https://github.com/user-attachments/assets/a1f0ae84-605a-4949-aab8-b0947b2edb90" width="600"/>
  <br/>
<img src="https://github.com/user-attachments/assets/32708208-8281-44d7-8119-7d9bf46ea71d" width="100" height="100"/>
  
### 국내 여행지 플래너 서비스 🖍️

[<img src="https://img.shields.io/badge/release-v0.0.0-ㅎㄱㄷ두?style=flat&logo=google-chrome&logoColor=white" />]() 
<br/> [<img src="https://img.shields.io/badge/프로젝트 기간-2024.05.14~2024.05.31-fab2ac?style=flat&logo=&logoColor=white" />]() <br/>

</div> 


## 📝 목차
- [1. 프로젝트 개요](#1-프로젝트-개요)
- [2. 담당 역할](#2-담당-역할)
- [3. 프로젝트 화면 구성](#3-프로젝트-화면-구성)
- [4. 내가 사용한 기술 스택](#4-사용한-기술-스택)
- [5. 기술적 이슈와 해결 과정](#5-기술적-이슈와-해결-과정)
- [6. 팀원](#6-팀원)

다음과 같은 목차로 구성되어 있습니다.

<br />

## 🚀 프로젝트 개요
💡 **여행지 검색**
- Kakao Map API를 활용해 지도 기반으로 여행지 검색

💡 **여행지 찜**
- 관심 있는 여행지를 찜하여 저장

💡 **여행 계획 플래너**
- 찜한 여행지를 기반으로 날짜별 여행 계획 수립
- 여행지별 메모 작성 기능
- 선택한 여행지 간 최단 경로 제공

💡 **핫플 여행지 공유 커뮤니티**
- 다녀온 여행지를 공유하고 소통할 수 있는 커뮤니티

💡 **챗봇**
- 궁금한 사항을 해결해주는 문의 챗봇
  
<br />

## 👨‍💻 담당 역할
💡 **여행지 검색**
- 국내 여행지 공공 데이터를 활용하여 Kakao Map 지도 위치 검색
- Kakao Map API를 활용하여 클러스터, 마커, 선 등 구현
- 여행지 검색 무한스크롤

💡 **여행지 찜**
- 관심있는 여행지를 찜하는 기능
  
💡 **여행 계획 플래너**
- draggable, datePicker, slick 라이브러리 등 접목하여 UX향상
- 날짜별 여행계획 수립
- 여행지별 메모 작성
- TSP 알고리즘으로 최단 경로 시각화

💡 **반응형 디자인**
- Media 태그를 활용한 반응형 디자인


<br />

## 🖥️ 화면 구성
|메인 화면|
|:---:|
|<img src="https://github.com/user-attachments/assets/19f605ca-c1ef-4912-9587-98cc9646a5fd" width="450"/>|
|Slick 라이브러리를 사용하여 UX 향상|


|여행지 검색|
|:---:|
|<img src="https://github.com/user-attachments/assets/ca4b1d2e-eb6d-44a6-b2c8-b09a70b5fb31" width="450"/>|
|무한스크롤 여행지 검색| 

|여행지 찜|
|:---:|
|<img src="https://github.com/user-attachments/assets/494f39b3-6b83-4bee-9f74-db63c86a8a7e" width="450"/>|
|여행지 찜|

|여행 계획 플래너|
|:---:|
|<img src="https://github.com/user-attachments/assets/d5d4317c-b913-4c96-9e9a-39fbcc648fbc" width="450"/>|
|draggable, datepicker 라이브러리 활용하여 UX 향상|

|최단 경로 시각화|
|:---:|
|<img src="https://github.com/user-attachments/assets/82217d39-76cb-447a-96ce-1f9cbb7aadcf" width="450"/>|
|TSP 알고리즘 적용|

|반응형|
|:---:|
|<img src="https://github.com/user-attachments/assets/4a19669f-dec4-4116-9a2e-df387072cce2" width="450"/>|
|모든 디바이스에서 사용 가능|
<br />

## ⚙ 내가 사용한 기술 스택
### Backend
<div>
  <img src="https://img.shields.io/badge/Spring%20Boot-%236DB33F.svg?style=for-the-badge&logo=springboot&logoColor=white">
  <img src="https://img.shields.io/badge/MySQL-%234479A1.svg?style=for-the-badge&logo=mysql&logoColor=white"> 
  <img src="https://img.shields.io/badge/Tomcat-%23F8DC75.svg?style=for-the-badge&logo=apachetomcat&logoColor=white">
</div>


### Frontend

<div>
  <img src="https://img.shields.io/badge/Vue.js-%234FC08D.svg?style=for-the-badge&logo=vue.js&logoColor=white">
  <img src="https://img.shields.io/badge/Pinia-%233B8F67.svg?style=for-the-badge&logo=pinia&logoColor=white">
  <img src="https://img.shields.io/badge/JavaScript-%23F7DF1E.svg?style=for-the-badge&logo=javascript&logoColor=black">


</div>

### Tools
<div>
<img src="https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/Git-%23F05032.svg?style=for-the-badge&logo=git&logoColor=white">
</div>

<br />

## 🤔 기술적 이슈와 해결 과정
> ### 최단 경로 시각화
> - `Brute Force`방법으로 할 경우 `n!`이라는 시간복잡도 소요 → `DP` 방법을 적용한 `TSP`알고리즘으로 `n^2 * 2^n`으로 향상 [코드 바로보기](https://github.com/qjatjs123123/TripMate/blob/main/TripMate/enjoyTripBack/EnjoyTrip/src/main/java/com/ssafy/cart/controller/CartController.java#L108-L199)
<br />



> ### 레거시 코드 개선
> - `props drilling`문제로 유지보수가 어렵고, 불필요한 렌더링 발생. → `Context API`를 사용하여 코드의 가독성 및 렌더링 효율성 개선 [코드 바로보기](https://github.com/qjatjs123123/withMe/blob/master/frontend/src/app/(afterLogin)/_components/WorkspaceInfoProvider.tsx#L1-L27)
> - `모달창`이 닫힐 때 생기는 로직 중복 →  `모달창`이 닫힐 때 필요한 로직을 커스텀 훅으로 분리하여 재사용성 높임. [코드 바로보기](https://github.com/qjatjs123123/withMe/blob/master/frontend/src/app/(afterLogin)/workspace/business/useModalClose.ts#L1-L36)
> - `이미지 업로드` 로직 중복 →  `이미지 업로드` 로직을 커스텀 훅으로 분리하여 재사용성 높임. [코드 바로보기](https://github.com/qjatjs123123/withMe/blob/master/frontend/src/app/(afterLogin)/workspace/business/useModalClose.ts#L1-L76)
> - `API 호출 결과 메시지 핸들러` 로직의 중복 문제 → 이를 커스텀 훅으로 분리하여 재사용성을 높임. [코드 바로보기](https://github.com/qjatjs123123/withMe/blob/master/frontend/src/app/(afterLogin)/workspace/business/useErrorHandler.ts#L1-L40)
> - 공통 컴포넌트를 분리하고, props를 통해 함수를 전달함으로써 재사용성을 높임. [코드 바로보기](https://github.com/qjatjs123123/withMe/blob/master/frontend/src/app/_components/CloseBtn.tsx#L5-L21)
<br />


## 💁‍♂️ 프로젝트 팀원
| **FullStack** | **FullStack** |
|:---:|:---:|
| <img src="https://github.com/qjatjs123123.png" width="150">  | <img src="https://github.com/wonchul98.png" width="150"> |
| [홍범선](https://github.com/qjatjs123123) | [신원철](https://github.com/wonchul98) |



## 📲 링크
| :: 영상                                                            |
| :------------------------------------------------------------------------------------- |
| :: [youtube Link](https://youtu.be/kf4evPpzqDw) | 



