<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
import { defineProps, defineEmits } from "vue";
import { NAV_ITEM } from "@/assets/Constants.js";
import CloseBtn from "@/components/common/CloseBtn.vue";
import router from "@/router"; // Vue Router 인스턴스를 가져옵니다.

const props = defineProps({
  isActive: Boolean,
});

const emit = defineEmits(["clickEvent"]);

function onChangeActive() {
  emit("clickEvent");
}
const handleRouterNavigation = (routeName) => {

  router.push({ name: routeName });
};
</script>

<template>
  <div class="gnb" :class="{ active: props.isActive }">
    <div class="flexbox">
      <div class="trigger-box">
        <CloseBtn @clickEvent="onChangeActive" />
      </div>
      <div class="logoBox logo">Tripmate</div>
      <div
        v-for="(item, index) in NAV_ITEM"
        :key="index"
        @click="handleRouterNavigation(item.name)"
      >
        <div class="item">
          {{ item.title }}
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.nfz {
  text-decoration: none; /* 밑줄 제거 */
  color: black;
}
.item {
  padding: 20px 10px;
  cursor: pointer;
}

.trigger-box {
  display: flex;
  justify-content: end;
}

.flexbox {
  display: flex;
  flex-direction: column;
  width: 60%;
  background-color: var(--gnb-background-color);
  height: 100vh;
  box-shadow: 5px 0 10px rgba(0, 0, 0, 0.2);
  padding: 20px 10px;
  padding-right: 30px;
}
.gnb {
  display: none;
  position: fixed;
  top: 0;
  left: calc(-100vw);
  width: calc(100vw);
  height: 100vh;
  z-index: 100;
  transition: 0.5s;
}
.active {
  left: 0;
}
.logo {
  color: var(--logo-font-color);
  font-size: var(--logo-font-size);
  border-bottom: 1px solid var(--navItem-border-color);
  padding: 20px 10px;
}
@media (max-width: 768px) {
  .gnb {
    display: block;
  }
}
</style>
