<script setup>
import { storeToRefs } from "pinia";
import { usePlanStore } from "@/stores/plan";

const planStore = usePlanStore();
const { isbottomGnb } = storeToRefs(planStore);

const onChangeActive = () => {
  isbottomGnb.value = !isbottomGnb.value;
};
</script>

<template>
  <div class="cart_container" :class="{ active: isbottomGnb }">
    <button class="btn" @click="onChangeActive">
      <i v-if="!isbottomGnb" class="fa fa-chevron-up"></i>
      <i v-else class="fa fa-chevron-down"></i>
    </button>
    <div class="cartContainer"></div>
  </div>
</template>

<style scoped>

.cart_container {
  position: fixed;
  width: 100vw;
  height: calc(20vh + 20px);
  z-index: 20;
  bottom: calc(20vh * -1);
  transition: 0.5s;
  left: 0;
}
.active {
  bottom: 0;
}
.btn:hover {
  color: var(--login-btn-color);
}
.btn {
  width: 40px;
  height: 20px;
  position: absolute;
  z-index: 20;
  border: 1px solid #bbb;
  background-color: #fff;
  cursor: pointer;
  border-radius: 10px 10px 0 0;
  left: 50%;
  transform: translateX(-50%);
}
.cartContainer {
  width: 100vw;
  height: 20vh;
  position: absolute;
  bottom: 0;
  left: 0;
  background-color: #fff;
  z-index: 10;
  box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.5);
}
</style>
