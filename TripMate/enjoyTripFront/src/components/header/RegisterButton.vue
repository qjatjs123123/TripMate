<template>
  <button class="login-button nb nbgc" @click="openRegisterModal">
    <span class="nfz">회원가입</span>
  </button>
</template>

<script setup>
import { useMainStore_register } from "@/stores/main";

const registerStore = useMainStore_register();

const { openRegisterModal } = registerStore;
</script>

<style scoped>
.login-button {
  border-radius: 20px;
  padding: 10px 16px;
  background-color: #333333;
  color: white;
  cursor: pointer;
  margin-right: 5px; 
}
</style>