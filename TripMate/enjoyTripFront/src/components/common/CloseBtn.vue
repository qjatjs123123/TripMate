<script setup>
import { defineEmits } from "vue";

const emit = defineEmits(["clickEvent"]);

function onChangeActive() {
  emit("clickEvent");
}
</script>

<template>
  <div class="trigger" @click="onChangeActive">
    <span></span>
    <span></span>
  </div>
</template>

<style scoped>
.trigger {
  display: block;
  width: 20px;
  height: 14px;
  position: relative;
  cursor: pointer;
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
  transform: translateY(-50%) rotate(45deg);
}

.trigger span:nth-child(2) {
  top: 50%;
  transform: translateY(-50%) rotate(-45deg);
}

</style>
