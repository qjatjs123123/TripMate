<script setup>
import CloseBtn from "../common/CloseBtn.vue";
import { storeToRefs } from "pinia";
import { usePlanStore } from "@/stores/plan";
import { ref, computed, watch } from "vue";
import { useCartStore } from "@/stores/cart";

const planStore = usePlanStore();
const { ismemoModal, curContent_id, dayList  } = storeToRefs(planStore);
const { findContentById } = planStore;
const memoData = ref({});
const txtareaContent = ref(memoData.value.memo || "");


const onChangeActive = () => {
  txtareaContent.value = "";
  ismemoModal.value = false;
};

const okbutton = () => {
  const data = findContentById(curContent_id.value);
  data.memo = memoData.value.memo;
  onChangeActive();
}

watch(ismemoModal, () => {
  if (!ismemoModal.value) return;
  memoData.value = findContentById(curContent_id.value)
  if (!memoData.value.memo) memoData.value.memo = '';
  console.log(memoData.value );
});

</script>

<template>
  <div
    @click="onChangeActive"
    :class="['login-container', { active: ismemoModal }]"
  >
    <div class="loginBody" @click.stop>
      <div class="closeBtn">
        <CloseBtn @clickEvent="onChangeActive" />
      </div>
      <div class="loginInfo">
        <span>여행메모 등록</span>
      </div>

      <div class="cart-item">
        <div class="cart-item-inner">
          <img
            class="item-img"
            :src="memoData.first_image ? memoData.first_image : '/noImage.png'"
          />
          <div class="row">
            <div class="item-txt txt-webkit-box-1 fz a">
              {{ memoData.title }}
            </div>
            <div class="item-txt txt-webkit-box-1 fz gray">
              {{ memoData.addr1 }}
            </div>
          </div>
        </div>
      </div>

      <label class="ff">메모</label>
      <textarea
        v-model="memoData.memo"
        class="content"
        placeholder="메모를 입력하세요..."
      ></textarea>

      <div class="flexs">
        
        <div class="cancel-button" @click="onChangeActive">취소</div>
        <div class="login-button" @click="okbutton">확인</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.cancel-button {
  width: 34px;
  border-radius: 20px;
  padding: 10px 16px;
  background-color: #333333;
  color: white;
  cursor: pointer;
}
.login-button {
  width: 34px;
  border-radius: 20px;
  padding: 10px 16px;
  background-color: rgb(0, 123, 255);
  color: white;
  cursor: pointer;
  margin-left: 10px;
}
.flexs{
  margin-top: 10px;
  display: flex;
  justify-content: end;
}
.content {
  width: 100%;
  height: 50px;
}
.cart-item {
  width: calc(100% - 20px);
  background-color: #f6f8fa;
  padding: 10px 10px;
  cursor: pointer;
  height: 100%;
  border: 1px solid #eee;
  border-radius: 10px;
}
.cart-item img {
  width: 100px; /* 이미지의 최대 너비를 부모 요소의 너비에 맞추기 */
  height: 100px;
  object-fit: cover; /* 이미지의 비율을 유지하면서 부모 요소에 맞추기 */
  border-radius: 50%;
}
.cart-item-inner {
  display: flex;
  align-items: center;
}
.trash {
}
.nov {
  display: none;
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
.delete-message {
  color: #ff6b6b;
}
.delete-message:hover {
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
