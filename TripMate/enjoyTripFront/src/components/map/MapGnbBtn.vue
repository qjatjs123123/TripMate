<script setup>
import { defineEmits, defineProps } from "vue";

const emit = defineEmits(["clickEvent"]);
const props = defineProps({
  isActive: Boolean
});


function onChangeActive() {
  emit("clickEvent", !props.isActive);
}
</script>

<template>
  <button class="btn" @click="onChangeActive" :class="{ active1: props.isActive }">
    <i v-if="!props.isActive" class="fa fa-chevron-right"></i>
    <i v-else class="fa fa-chevron-left"></i>
  </button>
</template>

<style scoped>
.btn:hover {
  color: var(--login-btn-color);
}
.btn {
  height: 40px;
  position: absolute;
  z-index: 20;
  right: -24px;
  top: 50%;
  transform: translateY(calc(-50% - var(--header-height)));
  border: 1px solid #bbb;
  background-color: #fff;
  cursor: pointer;
  border-radius: 0 10px 10px 0;
}

</style>
