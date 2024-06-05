<script setup>
import { onMounted } from "vue";
import { usePlanStore } from "@/stores/plan";
import MemoModal from "@/components/plan/MemoModal.vue";
import planGnb from "@/components/plan/planGnb.vue";
import PlanSettingModal from "@/components/plan/PlanSettingModal.vue";
import MemoShowModal from "@/components/plan/MemoShowModal.vue";

const planStore = usePlanStore();
const { mapMaker } = planStore;

onMounted(() => {
  mapMaker();
});
</script>

<template>
  <div class="container">
    <div id="map" class="map">
      <planGnb/> 
      <PlanSettingModal />
      <MemoModal />
      <MemoShowModal/>
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
