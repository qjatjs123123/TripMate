<template>
  <div class="m-w noscrollx">
    <Header />
    <HeaderResponse />
    <RegisterModal />
    <LoginModal />
    <RouterView />
    <LoadingBar />
    <ChatBot />
  </div>
</template>

<style>
@import "@/assets/common.css";
.m-w {
  min-width: 300px;
}
</style>

<script setup>
import { RouterView } from "vue-router";
import { ref, onMounted } from "vue";
import {
  CONTENT_MAX_WIDTH,
  MODAL_MAX_WIDTH,
  MODAL_MAX_HEIGHT,
} from "@/assets/Constants.js";
import Header from "@/components/main/Header.vue";
import HeaderResponse from "./components/main/HeaderResponse.vue";
import LoadingBar from "./components/common/LoadingBar.vue";
import LoginModal from "@/components/main/LoginModal.vue";
import RegisterModal from "@/components/main/RegisterModal.vue";
import ChatBot from "./components/main/ChatBot.vue";

const padding = ref(0);
const padding_modal = ref(0);
const padding_height_modal = ref(0);

onMounted(() => {
  handleResize();
  window.addEventListener("resize", handleResize);
});

const handleResize = () => {
  padding.value =
    (document.documentElement.clientWidth - CONTENT_MAX_WIDTH) / 2 > 10
      ? (document.documentElement.clientWidth - CONTENT_MAX_WIDTH) / 2
      : 20;
  padding_modal.value =
    (document.documentElement.clientWidth - MODAL_MAX_WIDTH) / 2 > 30
      ? (document.documentElement.clientWidth - MODAL_MAX_WIDTH) / 2
      : 30;

  padding_height_modal.value =
    (document.documentElement.clientHeight - MODAL_MAX_HEIGHT) / 2 > 20
      ? (document.documentElement.clientHeight - MODAL_MAX_HEIGHT) / 2
      : 20;
  document.documentElement.style.setProperty(
    "--container-padding",
    `${padding.value}px`
  );
  document.documentElement.style.setProperty(
    "--container-padding-modal",
    `${padding_modal.value}px`
  );
  document.documentElement.style.setProperty(
    "--container-padding-height-modal",
    `${padding_height_modal.value}px`
  );
};
</script>
