<script setup>
import { MAP_SIDE_MENU } from "@/assets/Constants.js";
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { contentTypeId } = storeToRefs(mapStore);
const { getMapListByParam } = mapStore;

const handleContentTypeId = (id) => {
  contentTypeId.value = id;
  getMapListByParam(true, false);
}
</script>

<template>
  <div class="side_container">
    <div
      v-for="({ title, value, url }, index) in MAP_SIDE_MENU"
      :class="{ active: contentTypeId === value }"
      :key="index"
      class="side_item"
      @click="handleContentTypeId(value)"
    >
      <img :src="url" class="side-img" />
      <div>{{ title }}</div>
    </div>
  </div>
</template>

<style scoped>
.side_item:hover {
  color: var(--login-btn-color);
}
.side_item.active {
  background-color: var(--login-btn-color); /* 원하는 배경색으로 변경하세요 */
  color:white;
}
.side_item {
  padding: 10px 0px;
  font-size: 14px;
  text-align: center;
  cursor: pointer;
  border-bottom: 1px solid #eee;
}
.side-img {
  width: 20px;
  height: 20px;
}
.side_container {
  height: 100%;
  width:  var(--side-menu-width);
  background-color: #fff;
  position: fixed;
  z-index: 20;
  box-shadow: 10px 0 5px -5px rgba(0, 0, 0, 0.2);
}

</style>
