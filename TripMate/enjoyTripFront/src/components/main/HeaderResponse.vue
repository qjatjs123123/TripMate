<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
import Gnb from "@/components/header/Gnb.vue";
import { ref } from "vue";
import { storeToRefs } from "pinia";
import { useMainStore } from "@/stores/main";
import { useMainStore_register } from "@/stores/main";
import { useUserStore } from "@/stores/user";
import UserButton from "@/components/header/UserButton.vue";
import CartBtn from "@/components/header/CartBtn.vue";

const registerStore = useMainStore_register();
const mainStore = useMainStore();
const userStore = useUserStore();

const { isLogin } = storeToRefs(userStore);
const isActive = ref(false);
const { openRegisterModal } = registerStore;
const { openLoginModal } = mainStore;

const onResponseMenu = () => {
  isActive.value = !isActive.value;
};
</script>

<template>
  <Gnb :isActive="isActive" @clickEvent="onResponseMenu" />
  <div class="container responsive-padding visible">
    <nav class="inner-container fj">
      <div class="gnbBox">
        <div @click="onResponseMenu" class="trigger">
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
      <div class="logoBox">
        <router-link :to="{ name: 'main' }" class="router-link logo"
          >Tripmate</router-link
        >
      </div>
      <div class="loginBox">
        <div class="button-inner" v-if="!isLogin">
          <div class="img-box mr" @click="openRegisterModal">
            <img src="/join.png" />
          </div>
          <div class="img-box" @click="openLoginModal">
            <img src="/login.png" />
          </div>
        </div>
        <div class="button-inner" v-else>
          <CartBtn />
          <div class="ml-20">
            <UserButton />
          </div>
        </div>
      </div>
    </nav>
  </div>
</template>

<style scoped>
.ml-20 {
  margin-left: 10px;
}
.mr {
  margin-right: 5px;
}
.img-box {
  width: 30px;
  height: 30px;
  cursor: pointer;
}
.img-box img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
}
.trigger {
  display: block;
  width: 20px;
  height: 14px;
  position: relative;
  cursor: pointer;
}

.trigger span {
  position: absolute;
  height: var(--hambugerbtn-height);
  width: 100%;
  background-color: var(--hambugerbtn-color);
}

.trigger span:nth-child(1) {
  top: 50%;
  width: 80%;
}

.trigger span:nth-child(2) {
  top: 100%;
}

.trigger span:nth-child(3) {
  align-items: flex-end;
}

.visible {
  display: none;
}

@media (max-width: 878px) {
  .visible {
    display: block;
  }
}
.container {
  width: 100%;
  height: 65px;
  border-bottom: 1px solid var(--navItem-border-color);
}
.fj {
  display: flex;
  justify-content: space-between;
}

.logoBox {
  display: flex;
  flex: 2;
  text-decoration: none; /* 밑줄 제거 */
  align-items: center;
  justify-content: center;
}
.logo {
  color: var(--logo-font-color);
  font-size: var(--logo-font-size);
}

.gnbBox {
  flex: 1;
  display: flex;
  align-items: center;
}

.loginBox {
  display: grid;
  justify-content: end;
  flex: 1;
}
.button-inner {
  height: 100%;
  display: flex;
  align-items: center; /* 상하 중앙 정렬 */
  /* margin-left: 20px; */
}
</style>
