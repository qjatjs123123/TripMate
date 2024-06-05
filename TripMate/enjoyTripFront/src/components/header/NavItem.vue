<script setup>
import { defineProps } from "vue";
import { NAV_ITEM } from "@/assets/Constants.js";
const props = defineProps({
  item: {
    type: Object,
    required: true,
  },
});
</script>

<template>
  <button class="navItem-button nb nbgc">
    <span class="nfz"
      ><router-link
        :key="props.item.name"
        :to="{ name: props.item.name }"
        class="logo"
      >
        {{ props.item.title }}</router-link
      ></span
    >
  </button>
</template>

<style scoped>
.logo {
  text-decoration: none; /* 밑줄 제거 */
  color: black;
}
.navItem-button {
  border-radius: 20px;
  padding: 10px 16px;
  cursor: pointer;
}

.navItem-button:hover {
  /* 호버시 배경색 변경 */
  background-color: var(--navItem-button-color); /* 변경할 색상 지정 */
}
</style>
