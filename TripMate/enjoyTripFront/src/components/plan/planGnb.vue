<script setup>
import { storeToRefs } from "pinia";
import { usePlanStore } from "@/stores/plan";
import PlanDate from "@/components/plan/PlanDate.vue";

const planStore = usePlanStore();
const { isLeftGnb, isbottomGnb } = storeToRefs(planStore);

const onChangeActive = () => {
  isLeftGnb.value = !isLeftGnb.value;
};
</script>

<template>
  <div
    class="gnb-container m-w"
    :class="{ active: isLeftGnb, active1: isbottomGnb }"
  >
    <button class="btn" @click="onChangeActive">
      <i v-if="!isLeftGnb" class="fa fa-chevron-right"></i>
      <i v-else class="fa fa-chevron-left"></i>
    </button>

    <PlanDate />



  </div>
</template>

<style scoped>
.gnb-container {
  position: fixed;
  width: var(--side-gnb-width);
  height: calc(100% - var(--header-height) - 1px - 40px);
  background-color: #fff;
  left: calc(
    calc(var(--side-gnb-width) + calc(var(--side-gnb-width-padding) * 2)) * -1
  );
  z-index: 19;
  transition: 0.5s;
  box-shadow: 10px 0 5px -5px rgba(0, 0, 0, 0.2);
  padding: 20px var(--side-gnb-width-padding);
  display: flex;
  flex-direction: column; 
}

.btn:hover {
  color: var(--login-btn-color);
}

.btn {
  display: block;
  position: absolute;
  height: 40px;
  z-index: 20;
  width: 24px;
  right: -24px;
  top: 50%;
  /* transform: translateY(calc(-50% - var(--header-height))); */
  border: 1px solid #bbb;
  background-color: #fff;
  cursor: pointer;
  border-radius: 0 10px 10px 0;
}
.active {
  left: 0 !important;
}

@media (max-width: 466px) {
  .gnb-container {
    width: calc(var(--side-gnb-width-res1) - 20px);
  }
  .gnb-container {
    left: calc(var(--side-gnb-width-res1) * -1 - 20px);
  }
}
@media (max-width: 350px) {
  .gnb-container {
    width: calc(var(--side-gnb-width-res2) - 20px);
  }
  .gnb-container {
    left: calc(var(--side-gnb-width-res2) * -1 - 7  0px);
  }
}
</style>
