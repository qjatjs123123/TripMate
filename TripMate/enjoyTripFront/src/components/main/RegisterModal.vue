<script setup>
import CloseBtn from "../common/CloseBtn.vue";
import SlideInput from "../common/SlideInput.vue";
import { storeToRefs } from "pinia";
import { useMainStore_register } from "@/stores/main";
import { useUserStore } from "@/stores/user";
import { ref } from "vue";


const registerStore = useMainStore_register();
const userStore = useUserStore();

const { userRegister  } = userStore;
const { inputList, modalName, closeRegisterModal } =
  registerStore;

function onChangeActive() {
  closeRegisterModal();
}

function preventEvent(e) {
  e.stopPropagation();
}
const { isRegisterModal } = storeToRefs(registerStore);

const data = ref({
  userId: '',
  password: '',
  name: '',
  email: ''
});

function handleMessage(message, name) {
  data.value[name] = message;
}

function onSubmit() {
  userRegister(data.value);
  // register(data.value, registerCallback, ErrorHandler());
}

</script>

<template>
  <div
    class="login-container"
    :class="{ active: isRegisterModal }"
    @click="onChangeActive"
  >
    <div class="loginBody" @click="preventEvent">
      <div class="closeBtn">
        <CloseBtn @clickEvent="onChangeActive" />
      </div>
      <div class="logoBox logo">Tripmate</div>
      <div class="loginInfo">
        <span>{{ modalName }}하여 Tripmate를 즐겨보세요.</span>
      </div>

      <form class="input-inner" @submit.prevent="onSubmit">
        <SlideInput
          v-for="item in inputList"
          :title="item.title"
          :name="item.name"
          :key="item.title"
          :data="data[item.name]"
          @update="handleMessage"
        ></SlideInput>

        <button class="button" type="submit">{{ modalName }}</button>
      </form>
    </div>
  </div>
</template>

<style scoped>
.login-result {
  color: var(--login-result-color);
  font-size: var(--login-result-fz );
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
  z-index: 1000;
  overflow-y: hidden;
  visibility: hidden;
  align-items: center;
  justify-content: center;
  transition: 0.2s;
  display: flex;
  bottom: 0;
  padding: 20px 15px;
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
}
</style>
