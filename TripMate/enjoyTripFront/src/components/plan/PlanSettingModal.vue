<script setup>
import CloseBtn from "../common/CloseBtn.vue";
import SlideInput from "../common/SlideInput.vue";
import { storeToRefs } from "pinia";
import { usePlanStore } from "@/stores/plan";
import { ref, computed, watch } from "vue";
import Datepicker from "vue3-datepicker";
import draggable from "vuedraggable";
import { useCartStore } from "@/stores/cart";


const picked = ref(new Date());
const trashList = ref([]);
const planStore = usePlanStore();
const cartStore = useCartStore();
const { isSettingModal, tripTitle, startDate, startDateString, dayList, curDate } = storeToRefs(planStore);
const { addDate, changeCurDate } = planStore;
const { cartCnt, cartList } = storeToRefs(cartStore);

function onChangeActive() {
  isSettingModal.value = !isSettingModal.value;
}

function preventEvent(e) {
  e.stopPropagation();
}
const formattedDate = (message) => {
    const year = message.getFullYear();
    const month = String(message.getMonth() + 1).padStart(2, "0");
    const day = String(message.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
}

watch(startDate, (newValue) => {
  if (newValue instanceof Date) {
    startDateString.value = formattedDate(newValue);
  }
});
function handleMessage(message, name) {
  tripTitle.value = message;
}
function handleMessage1(message, name) {
  const regex = /^(\d{4})-(\d{2})-(\d{2})$/;
  if (!regex.test(message)) {
    return;
  }
  startDateString.value = message;
  startDate.value = parseDate(message);
}
// "yyyy-mm-dd" 형식의 문자열을 Date 객체로 변환하는 함수
function parseDate(dateString) {
  console.log(dateString);
  const [year, month, day] = dateString.split("-").map(Number);
  return new Date(year, month - 1, day); // 월은 0부터 시작하기 때문에 -1을 해줍니다.
}

function addDays() {
  const result = new Date(startDate.value);
  result.setDate(result.getDate() + dayList.value.length - 1);

  return formattedDate(result);
}

const onMove = (evt, originalEvent) => {
    if (dayList.value.length === 0) {
        dayList.value.push(trashList.value.pop());
    }
};

</script>

<template>
  <div @click="onChangeActive" :class="['login-container', { active: isSettingModal }]">
    <div class="loginBody" @click="preventEvent">
      <div class="closeBtn">
        <CloseBtn @clickEvent="onChangeActive" />
      </div>
      <div class="loginInfo">
        <span>여행정보 수정</span>
      </div>
      <SlideInput
        :title="'여행 제목'"
        :name="'tripTitle'"
        :data="tripTitle"
        @update="handleMessage"
      />
      <div class="date-container">
        <div class="visible">
          <label>시작일자</label>
          <Datepicker
            v-model="startDate"
            :style="{
              'border-radius': '5px',
              width: '100%',
              'font-size': '14px',
              color: 'gray',
              border: '2px solid black',
              'font-family': 'Jua, sans-serif',
            }"
          />
        </div>
        <div class="mvisible">
          <SlideInput
            :title="'시작 일자'"
            :name="startDateString"
            :data="startDateString"
            @update="handleMessage1"
          />
        </div>
        <label class="dd">종료일자</label>
        <div class="endDate">{{ addDays() }}</div>
      </div>

      <div class="trash">
        <label class="ff">여행 일정</label>
        <draggable
          class="menu-container scroll"
          :group="'ass'"
          :list="dayList"
          itemKey="name"
          @move="onMove"
        >
          <template #item="{ element, index }">
            <div
              :class="['item']"
              @click="changeCurDate(index + 1)"
            >
              {{ index + 1 }} 일차
            </div>
          </template>
          <template #footer>
            <div class="item bgo" @click="addDate"><span>날짜추가</span></div>
          </template>
        </draggable>

        <draggable
          :list="trashList"
          :group="'ass'"
          class="delete-zone"
          itemKey="name"
          @change="onMove"
        >
          <template #item="{ element, index }">
            <div class="nov">{{ index }}</div>
          </template>
          <template #footer>
            <div class="item delete-message"><span>Drag here to delete</span></div>
          </template>
        </draggable>
      </div>
    </div>
  </div>
</template>

<style scoped>
.trash{

}
.nov {
    display: none;;
}
.ff {
    display: block;
    margin-top: 30px;
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
.date-container {
  padding-bottom: 20px;
  border-bottom: 1px solid #e0e0e0;
}
.dd {
  display: block;
  margin-top: 10px;
}
.endDate {
  font-size: 14px;
  color: gray;
  padding: 5px 0px;
}
label {
  font-size: 16px;
}
.input-box {
  position: relative;
  margin-bottom: 20px;
}
.login-result {
  color: var(--login-result-color);
  font-size: var(--login-result-fz);
}
.input-inner {
  position: relative;
  margin-top: 30px;
  width: 100%;
}

.button {
  background-color: var(--logo-font-color);
  color: var(--login-btn-ft-color);
  border: none;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 5px;
  width: 100%;
  margin-top: 20px;
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
  font-size: var(--font-size);
}
.button:hover {
  background-color: var(--login-btn-color);
}

.login-container {
  position: fixed;
  background-color: var(--scrimModal);
  width: calc(100vw - 30px);
  height: 0;
  z-index: 10;
  overflow-y: hidden;
  visibility: hidden;
  align-items: center;
  justify-content: center;
  transition: 0.2s;
  display: flex;
  bottom: 0;
  padding: 20px 15px;
  z-index: 100;
}
.active {
  visibility: visible;
  height: calc(100vh - 40px);
}
.loginBody {
  width: 350px;
  padding: 40px 45px 30px;
  background-color: #fff;
  color: #000;
  border-radius: 10px;
  position: relative;
}
.closeBtn {
  position: absolute;
  top: 20px;
  right: 20px;
}
.logo {
  color: var(--logo-font-color);
  font-size: 40px;
  padding: 20px 0px;
}
.loginInfo {
  font-size: 22px;
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 15px;
  margin-bottom: 15px;
}
.v3dp__popout {
  width: 100% !important;
}
.visible {
  display: block;
}
.mvisible {
  display: none;
}
.delete-message{
    color: #ff6b6b;
}
.delete-message:hover{
    color: #ff6b6b;
 }
@media (max-width: 400px) {
  .visible {
    display: none;
  }
  .mvisible {
    display: block;
  }
}
@media (max-width: 450px) {
  .loginBody {
    width: 330px;
  }
}
@media (max-width: 400px) {
  .loginBody {
    width: 280px;
  }
}
</style>
