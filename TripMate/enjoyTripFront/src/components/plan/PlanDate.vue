<script setup>
import draggable from "vuedraggable";
import { ref, computed } from "vue";
import { storeToRefs } from "pinia";
import { usePlanStore } from "@/stores/plan";
import { useCartStore } from "@/stores/cart";
const cartStore = useCartStore();
const planStore = usePlanStore();
const {
  curDate,
  dayList,
  currentDayList,
  tripTitle,
  isSettingModal,
  ismemoShowModal,
  ismemoModal,
  startDateString,
  endDateString,
} = storeToRefs(planStore);
const { addDate, changeCurDate, setterContent_id } = planStore;
const { cartList } = storeToRefs(cartStore);

function onChangeActive() {
  isSettingModal.value = !isSettingModal.value;
}

const insertMemo = (element) => {
  setterContent_id(element.content_id);
  ismemoModal.value = true;
};

const show = (element) => {
  setterContent_id(element.content_id);
  ismemoShowModal.value = true;
};
</script>

<template>
  <div class="drag-container">
    <div class="input-container">
      <div class="title-container">
        {{ tripTitle }}
        <div class="saveBtn">저장</div>
      </div>

      <div class="setting-container">
        <div>{{ dayList.length }}일 일정 <span class="ddday">({{ startDateString }} ~ {{ endDateString }})</span></div>
        <div>
          <button @click="onChangeActive">
            <i class="fa fa-cog"></i> 설정
          </button>
        </div>
      </div>

      <draggable class="menu-container scroll" :list="dayList" itemKey="name">
        <template #item="{ element, index }">
          <div
            :class="['item', { active: curDate === index + 1 }]"
            @click="changeCurDate(index + 1)"
          >
            {{ index + 1 }} 일차
          </div>
        </template>
        <template #footer>
          <div class="item bgo" @click="addDate"><span>날짜추가</span></div>
        </template>
      </draggable>
    </div>

    <draggable
      class="drag-item-box scroll"
      :list="currentDayList"
      group="people"
      itemKey="name"
    >
      <template #item="{ element, index }">
        <div @click.stop="show(element)" class="cart-item md wa">
          <div class="memo-btn" @click.stop="insertMemo(element)">
            <i class="fa fa-pencil-square-o"></i>
          </div>

          <div class="cart-item-inner">
            <img
              class="item-img"
              :src="element.first_image ? element.first_image : '/noImage.png'"
            />
            <div class="row">
              <div class="item-txt txt-webkit-box-1 fz a">
                {{ element.title }}
              </div>
              <div class="item-txt txt-webkit-box-1 fz gray">
                {{ element.addr1 }}
              </div>
            </div>
          </div>
        </div>
      </template>
      <template #header>
        <div v-if="currentDayList.length === 0" class="q">
          장바구니 목록을 여기로 드래그 하세요
        </div>
      </template>
    </draggable>

    <div class="aaaaaa">
      <div class="aa-title">장바구니</div>
      <draggable
        class="cart-container scroll"
        :list="cartList"
        group="people"
        itemKey="name"
      >
        <template #item="{ element, index }">
          <div class="cart-item">
            <div class="cart-item-inner">
              <img
                class="item-img"
                :src="
                  element.first_image ? element.first_image : '/noImage.png'
                "
              />
              <div class="row">
                <div class="item-txt txt-webkit-box-1 fz a">
                  {{ element.title }}
                </div>
                <div class="item-txt txt-webkit-box-1 fz gray">
                  {{ element.addr1 }}
                </div>
              </div>
            </div>
          </div>
        </template>
      </draggable>
      <div v-if="cartList.length === 0" class="qwe">텅</div>
    </div>
  </div>
</template>

<style scoped>
.ddday{
  font-size: 12px;
}
.saveBtn{
  background-color: #03C755;
  color: #fff;
  padding: 10px 8px;
  border-radius: 7px;
  font-size: 14px;
  cursor: pointer;
}
.q {
  position: absolute;
  top: 0;
  text-align: center;
  width: 100%;
}
.qwe {
  font-size: 3.5em;
}
.memo-btn {
  width: 30px;
  height: 30px;

  top: 10;
  right: 0;
  position: absolute;
}
.md {
  margin-bottom: 10px;
  border-radius: 10px;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}
.a {
  font-size: 20px !important;
}
.gray {
  color: gray;
}
.row {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.cart-item-inner {
  display: flex;
  align-items: center;
}
.aa-title {
  padding: 5px;
  font-size: 16px;
}
.aaaaaa {
  flex: 1;
  border-top: 1px solid #eff2f3;
  background-color: #f8f9fa;
  box-shadow: 0 -10px 5px -5px rgba(0, 0, 0, 0.2);
}
.fz {
  font-size: 14px;
}
.setting-container button {
  background-color: transparent; /* 배경색 제거 */
  border: none;
  cursor: pointer;
  color: #8f8f8f;
}
.setting-container {
  display: flex;
  justify-content: space-between;
  color: #8f8f8f;
  font-size: 15px;
  margin-top: 5px;
}
.title-container {
  display: flex;
  justify-content: space-between;
}
.input-container {
  padding-bottom: 10px;
  box-shadow: 0 10px 5px -5px rgba(0, 0, 0, 0.2);
  flex: 1;
  z-index: 20;
}
.cart-item {
  width: 100%;
  background-color: #fff;
  padding: 10px 10px;
  cursor: pointer;
  height: 100%;
  border: 1px solid #eee;
}
.cart-item img {
  width: 100px; /* 이미지의 최대 너비를 부모 요소의 너비에 맞추기 */
  height: 100px;
  object-fit: cover; /* 이미지의 비율을 유지하면서 부모 요소에 맞추기 */
  border-radius: 50%;
}
.drag-item-box {
  position: relative;
  height: 50vh;
  width: 100%;
  flex: 3;
  padding: 20px 0px;
  overflow-y: auto;
  overflow-x: auto;
}
.drag-container {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.cart-container {
  display: flex; /* Flexbox 적용 */
  flex-wrap: nowrap; /* 줄 바꿈 금지 */
  overflow-x: auto; /* 가로 스크롤 추가 */
  overflow-y: hidden;
}
.item:hover {
  color: var(--login-btn-color);
}
.item.active {
  background-color: var(--login-btn-color);
  color: white;
}
.item {
  padding: 10px 10px;
  background-color: #eee;
  border-radius: 10px;
  margin-right: 10px;
  white-space: nowrap;
  text-align: center;
  margin-top: 10px;
  margin-bottom: 10px;
  cursor: pointer;
  font-size: 16px;
}
.menu-container {
  overflow-x: scroll;
  display: flex;
}
.bgo {
  border: 1px solid rgba(0, 123, 255, 0.3);
  background-color: rgba(0, 123, 255, 0.05);
}
.item-img {
  margin-right: 20px;
}
.item-txt {
  flex: 3;
}
.cart-item {
  flex: 0 0 auto; /* 자동 크기 지정 */
  width: calc(var(--side-gnb-width) - 150px); /* 이미지의 최대 너비 */
  margin-right: 10px; /* 이미지 사이의 간격 설정 */
  height: 100px;
}

.wa {
  position: relative;
  width: 360px;
}
</style>
