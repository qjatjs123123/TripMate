<template>
  <button class="login-button nb nbgc" @click="props.func" :class=" props.color">
    <span class="nfz">{{ props.name }}</span>
  </button>
</template>

<script setup>
const props = defineProps({ 
  name: String,
  color: String,
  func : Function
});
</script>

<style scoped>
.login-button {
  width: 100%;
  border-radius: 20px;
  padding: 10px 16px;
  background-color: #333333;
  color: white;
  cursor: pointer;
}
.red {
  background-color: var(--withdraw-btn-color);
}
</style>
