<script setup>
import { onMounted } from "vue";
import MapSideMenu from "@/components/map/MapSideMenu.vue";
import MapGnb from "@/components/map/MapGnb.vue";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { getMapListByParam, mapMaker } = mapStore;

onMounted(() => {
  mapMaker();
  getMapListByParam(false, false);
});
</script>

<template>
  <div class="container">
    <div id="map" class="map">
      <MapSideMenu />  
      <MapGnb/>
    </div>
  </div>
</template>

<style scoped>
.container {
  width: 100vw;
  height: calc(100vh - var(--header-height) - 1px);
  overflow: hidden
}
#map {
  width: 100%;
  height: 100%;
}
</style>
