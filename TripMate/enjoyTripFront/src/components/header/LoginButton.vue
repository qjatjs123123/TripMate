<template>
  <button class="login-button nb nbgc" @click="openLoginModal">
    <span class="nfz">로그인</span>
  </button>
</template>

<script setup>
import { useMainStore } from "@/stores/main";

const mainStore = useMainStore();

const { openLoginModal } = mainStore;
</script>

<style scoped>
.login-button {
  border-radius: 20px;
  padding: 10px 16px;
  background-color: #333333;
  color: white;
  cursor: pointer;
  min-width: 30px;
}

</style>