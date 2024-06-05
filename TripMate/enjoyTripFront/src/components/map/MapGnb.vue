<script setup>
import SearchInput from "@/components/common/SearchInput.vue";
import MapCityMenu from "@/components/map/MapCityMenu.vue";
import MapGnbBtn from "@/components/map/MapGnbBtn.vue";

import MapItem from "@/components/map/MapItem.vue";
import { ref, watch} from "vue";
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { mapList, pageNo } = storeToRefs(mapStore);
const { getMapListByParam } = mapStore;
const isActive = ref(false);
const scrollContainer = ref(null);

function onChangeActive(state) {
  isActive.value = state;
}
function checkScroll() {
  const container = scrollContainer.value;
  
  console.log(container.scrollHeight- container.clientHeight, Math.round(container.scrollTop))

  if (container.scrollHeight - container.clientHeight <= Math.round(container.scrollTop)) {
    // 스크롤이 하단에 도달했을 때의 처리
    pageNo.value++;
    getMapListByParam(true, true);
  }
}
</script>

<template>
  <div class="gnb-container" :class="{ active: isActive }">
    <MapGnbBtn :isActive="isActive" @clickEvent="onChangeActive" />
    <div class="input-container">
      <SearchInput />
      <MapCityMenu />
    </div>

    <div class="item_container scroll" ref="scrollContainer" @scroll="checkScroll">
      <template v-if="mapList.length === 0">
        <div class="blank">텅</div>
      </template>
      <!-- mapList가 0이 아닌 경우 MapItem을 표시 -->
      <template v-else>
        <MapItem v-for="(item) in mapList" :key="`${item.content_id}-${item.isExist}`" :props="item" />
      </template>
    </div>
  </div>
</template>

<style scoped>
.blank{
  margin-top: 30px;
  font-size: 50px;
  text-align: center;
}
.input-container {
  padding-bottom: 30px;
  box-shadow: 0 10px 5px -5px rgba(0, 0, 0, 0.2);
}

.item_container {
  display: flex;
  flex-direction: column;
  padding-bottom: 30px;
  border-bottom: 1px solid #ccc;
}
.gnb-container {
  position: fixed;
  width: var(--side-gnb-width);
  height: 100%;
  background-color: #fff;
  left: calc(
    var(--side-menu-width) - var(--side-gnb-width) - calc(var(--side-gnb-width-padding) * 2)
  );
  z-index: 19;
  transition: 0.5s;
  box-shadow: 10px 0 5px -5px rgba(0, 0, 0, 0.2);
  padding: 20px var(--side-gnb-width-padding);
  display: flex;
  flex-direction: column;
}
.active {
  left: var(--side-menu-width) !important;
}
.item_container {
  overflow-y: auto;
}

@media (max-width: 466px) {
  .gnb-container {
    width: calc(var(--side-gnb-width-res1) - 20px);
  }
  .gnb-container {
    left: calc(var(--side-menu-width) - var(--side-gnb-width-res1));
  }
}
@media (max-width: 350px) {
  .gnb-container {
    width: calc(var(--side-gnb-width-res2) - 20px);
  }
  .gnb-container {
    left: calc(var(--side-menu-width) - var(--side-gnb-width-res2));
  }
}
</style>
