<script setup>
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { areaCode, areaList } = storeToRefs(mapStore);
const { getMapListByParam } = mapStore;


const handleAreaCode = (id) => {
  areaCode.value = id;
  getMapListByParam(true, false);
};

</script>

<template>
  <div class="menu-container scroll">
    <div
      v-for="({ code, name }, index) in areaList"
      :key="index"
      class="item"
      :class="{ active: areaCode === code }"
      @click="handleAreaCode(code)"
    >
      {{ name }}
    </div>
  </div>
</template>

<style scoped>
.item:hover {
  color: var(--login-btn-color);
}
.item.active {
  background-color: var(--login-btn-color); /* 원하는 배경색으로 변경하세요 */
  color: white;
}
.item {
  padding: 10px 10px;
  background-color: #eee;
  border-radius: 10px;
  margin-right: 10px;
  white-space: nowrap; /* 글자가 개행되지 않고 한 줄로 유지되도록 설정 */
  text-align: center; /* 텍스트를 중앙에 정렬 */
  margin-top: 15px;
  margin-bottom: 15px;
  cursor: pointer;
  font-size: 16px;
}
.menu-container {
  overflow: auto;
  display: flex;
}

</style>
