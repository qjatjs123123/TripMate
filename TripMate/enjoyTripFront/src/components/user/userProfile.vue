<script setup>
import { ref } from "vue";
import CommonBtn from "../common/CommonBtn.vue";
import { useUserStore } from "@/stores/user";
import { storeToRefs } from "pinia";
import modifyItem from "@/components/user/modifyItem.vue";


const userStore = useUserStore();
const { inputList, userWithdraw } = userStore;
const { data } = storeToRefs(userStore);
const paramData = ref(data.value);
const isModify = ref([false, false, false, false]);

function imageUpload() {
  alert("upload");
}

function imageRemove() {
  alert("remove");
}
const handleModify = (idx, state) => {
  if (idx === 0) isModify.value[idx] = state;
  else if (idx === 1) isModify.value[idx] = state;
  else if (idx === 2) isModify.value[idx] = state;
  else if (idx === 3) isModify.value[idx] = state;
};

const userDelete = () => {
  const confirmed = window.confirm("정말로 삭제하시겠습니까?");
  if (confirmed) {
    userWithdraw(data.value.userId);
  }
};

function handleMessage(message, name) {
  paramData.value[name] = message;
}
</script>

<template>
  <div class="container" style="border-bottom: 0px">
    <div class="img-container">
      <div class="box">
        <img src="/profile.png" />
        <CommonBtn :name="'이미지 업로드'" :func="imageUpload" />
        <CommonBtn :name="'이미지 제거'" :func="imageRemove" :class="{ mb: true }" />
      </div>
    </div>

    <div class="txt-container">
      <div class="inner" v-if="!isModify[0]">
        <div class="title">{{ inputList[0].title }}</div>
        <div class="nickname"  v-if="data">{{ data.userId }}</div>
      </div>
      <modifyItem
        @clickEvent="handleModify"
        @InputEvent="handleMessage"
        :data="paramData.userId"
        :idx="0"
        :paramData="paramData"
        v-else
      />
    </div>
  </div>

  <div v-for="(item, index) in inputList.slice(1)" class="txt-container" :key="index + 1">
    <div class="inner" v-if="!isModify[index + 1]">
      <div class="title">{{ inputList[index + 1].title }}</div>
      <div class="nickname">{{ paramData[item.name] }}</div>
      <button class="txt-update-btn" @click="handleModify(index + 1, true)">수정</button>
    </div>
    <modifyItem
      @InputEvent="handleMessage"
      @clickEvent="handleModify"
      :data="paramData[item.name]"
      :idx="index + 1"
      :paramData="paramData"
      v-else
    />
  </div>
  <div class="btn">
    <button class="nfz" @click="userDelete">회원탈퇴</button>
  </div>
</template>

<style scoped>
.btn button {
  background-color: var(--withdraw-btn-color);
  color: white;
  border-radius: 20px;
  padding: 7px 16px;
  border: 1px solid var(--withdraw-btn-color);
  line-height: 1em;
  cursor: pointer;
  position: absolute;
  right: 0;
}
.btn {
  width: 100%;
  height: 40px;
  display: flex;
  padding: 30px 0;
  position: relative;
}
.inner {
  display: block;
}
.txt-update-btn {
  justify-content: end;
  border-radius: 20px;
  padding: 7px 16px;
  background-color: #333333;
  color: white;
  cursor: pointer;
  width: 70px;
  position: absolute;
  right: 0;
  font-family: "Jua", sans-serif;
  font-style: normal;
  font-size: 18px;
  top: 50%;
  transform: translateY(-50%);
}
.box {
  width: 150px;
}
.mb {
  margin-top: 10px;
  background: var(--img-reset-btn-color);
  color: var(--common-btn-color);
}
.nickname {
  color: gray;
  font-size: 30px;
}
.title {
  font-size: 30px;
}
.img-container img {
  width: var(--profile-img-size);
  height: var(--profile-img-size);
}
.container {
  display: flex;
  border-bottom: 1px solid var(--navItem-border-color2);
  padding-bottom: 30px;
}
.img-container {
  display: flex;
  flex-direction: column;
  margin-right: 3rem;
  width: calc(100% - var(--container-padding) * 2);
}
.txt-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 100%;
  position: relative;
  padding: 60px 0;
  border-bottom: 1px solid var(--navItem-border-color2);
}
@media (max-width: 768px) {
  .container {
    border-bottom: 0px;
  }
  .img-container {
    width: calc(100%);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 30px;
  }
  .container {
    flex-direction: column;
  }
  .txt-container {
    padding: 50px 20px;
    width: calc(100% - 40px);
    display: flex;
    align-items: unset;
    justify-content: unset;
    border-bottom: 1px solid var(--navItem-border-color);
  }
  .txt-update-btn {
    position: unset; /* Add this line */
    left: 0;
    margin-top: 10px;
    transform: translateY(0);
  }
}
</style>
