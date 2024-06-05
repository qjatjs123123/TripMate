<script setup>
// import { MAINMENU_LIST } from "@/assets/Constants.js";
</script>

<template>
  <div class="container responsive-padding">
    <div>
      <div class="title">Tripmate</div>
      <br/>
      <div>화면너머의 여러분에게 따뜻한 여행메이트이고 싶습니다.</div>
      <div>관광지 검색부터 여행 계획 및 핫플 공유까지</div>
      <div>가장 빛이 나야하는 순간까지 언제나 함께 하겠습니다.</div>
    </div>
  </div>
</template>

<style scoped>
.title {
  font-size: 25px;
}
div {
  text-align: center;
  color: rgb(135, 123, 115)
}
.container {
  width: calc(100vw - var(--container-padding) * 2);
  height: var(--mainImg-inner-height);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 20px;
}

.menu-img {
  width: var(--mainMenu-img-icon-width);
  height: var(--mainMenu-img-icon-height);
}
.item-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  text-align: center;
  overflow-x: scroll;
}
.box-inner {
  display: flex;
  flex-direction: column;
  cursor: pointer;
  width: 50px;
  height: 50px;
  padding: var(--mainMenu-box-padding) var(--mainMenu-box-padding);
}
</style>
