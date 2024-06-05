<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
import { NAV_ITEM } from "@/assets/Constants.js";
import NavItem from "@/components/header/NavItem.vue"
import LoginButton from "@/components/header/LoginButton.vue"
import RegisterButton from "@/components/header/RegisterButton.vue"
import CartBtn from "@/components/header/CartBtn.vue"
import { storeToRefs } from "pinia";
import { useUserStore } from "@/stores/user";
import UserButton from "@/components/header/UserButton.vue"


const userStore = useUserStore();

const { isLogin } = storeToRefs(userStore);
</script>

<template>
  
  <div class="container responsive-padding visible">
    <nav class="inner-container fj">
      <div class="logoBox">
       
        <router-link :to="{ name: 'main' }" class="router-link logo"> 🛫 Tripmate</router-link>

      </div>
      <div class="navBox">
        <div class="nav">
          <div v-for="(item, index) in NAV_ITEM" :key="index">
            <NavItem :item="item" />
          </div>
        </div>
      </div>
      <!-- 로그인 체크 부분 -->
      <div class="loginBox" v-if="!isLogin">
        <div class="button-inner">
          <RegisterButton/>
          <LoginButton />
        </div>
      </div>
      
      <div class="loginBox" v-else>
        <CartBtn />
        <div class="button-inner">   
          <UserButton />  
        </div>
      </div>
      <!-- ----------- -->
    </nav>
  </div>
</template>

<style scoped>
.visible {
    display: block;
  }

@media (max-width: 878px) {
  .visible {
    display: none;
  }
}

.container {
  width: 100vw;
  height: var(--header-height);
  border-bottom: var(--header-border-height) solid var(--navItem-border-color);
  background-color: #fff;
}
.fj{
  display: flex;
  justify-content: space-between;
}
.logoBox {
  position: relative;
  flex:1;
  text-decoration: none; /* 밑줄 제거 */
}
.logo {
  color: var(--logo-font-color);
  font-size: var(--logo-font-size);
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}

.navBox {
  flex:2;
  height: 100%;
  display: flex;
  align-items: center; /* 상하 중앙 정렬 */
  
}

.nav {
  display: grid;
  justify-content: center;
  grid-auto-flow: column;
  margin: 0 auto;
}
.loginBox{
  display: flex;
  justify-content: end;
  flex:1;
  align-items: center;
}
.button-inner {
  height: 100%;
  display: flex;
  align-items: center; /* 상하 중앙 정렬 */
  margin-left: 20px;
}
</style>