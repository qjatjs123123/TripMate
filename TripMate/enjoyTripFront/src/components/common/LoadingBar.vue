<script setup>
import { storeToRefs } from "pinia";
import { useApiStore } from "@/stores/api";
import { watch } from 'vue';
const apiStore = useApiStore();
const { apiInfo } = storeToRefs(apiStore);


let timerId = null;
// apiInfo 변경 시 처리
watch(apiInfo, () => {
  // apiInfo가 변경될 때마다 timer를 초기화하고, active 클래스를 추가한 후 0.3초 후에 제거합니다.
  clearTimeout(timerId); // 기존 타이머 초기화
  apiInfo.value ? addActiveClass() : removeActiveClass();
}, { deep: true });

function addActiveClass() {
  const loadingContainer = document.querySelector('.loading-container');
  if (loadingContainer == null) return;
  loadingContainer.classList.add('active');
  timerId = setTimeout(() => {
    loadingContainer.classList.remove('active');
  }, 1500);
}

function removeActiveClass() {
  clearTimeout(timerId); // active 클래스 제거 시 타이머 초기화
  document.querySelector('.loading-container').classList.remove('active');
}
</script>

<template>
  <div class="loading-container">
    {{ apiInfo.api }} {{apiInfo.state}}
  </div>
</template>

<style scoped>
  .loading-container{
    position: fixed;
    bottom: -50px;
    width: 178px;
    height: 50px;
    background-color: #333333;
    color: #fff;
    z-index: 1000;
    left: 50%;
    transform: translate(-50%);
    border-radius: 10px 10px 0 0;
    text-align: center;
    line-height: 2.7em;
    transition: 0.2s;
  }
  .active {
    bottom: 0; 
  }
</style>