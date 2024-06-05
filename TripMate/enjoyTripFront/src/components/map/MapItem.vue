<script setup>
import { defineProps, ref } from "vue";
import { getMapContentTitle } from "@/assets/Constants.js";
import LoveBtn from "../common/LoveBtn.vue";
import MapDetail from "@/components/map/MapDetail.vue";
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { isdetailModal, detailData } = storeToRefs(mapStore);
const items = defineProps({
  props: {
    type: Object,
    required: true,
  },
});

const tmp = items.props;
const item = ref(tmp);


const changeState = (num) => {
  item.value.isExist = num;
};
function closeModal() {
  isdetailModal.value = false;
}
function detailClick() {
  isdetailModal.value = true;
  detailData.value = item.value;
}

</script>

<template>
  <MapDetail
    @clickEvent="closeModal"
    @clickLoveBtn="changeState"
    :detailData="item"
    :isdetailModal="isdetailModal"
    v-if="isdetailModal"
  />
  <div class="item-inner" @click="detailClick">
    <img :src="item.first_image ? item.first_image : '/noImage.png'" />
    <div class="title">
      <div class="title-w">
        {{ item.title }}
        <span>{{ getMapContentTitle(item.content_type_id) }}</span>
      </div>

      <div class="title-fa">
        <LoveBtn :item="item" @clickEvent="changeState" />
      </div>
    </div>
    <div class="address">{{ item.addr1 }}</div>
    <div class="address">{{ item.addr2 }}</div>
    <div class="overview-container">
      <div class="overview">
        {{ item.overview }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.item-inner {
  margin-top: 30px;
  cursor: pointer;
}
.item-inner {
  display: flex;
  flex-direction: column;
  padding-bottom: 30px;
  border-bottom: 1px solid #ccc;
}
.overview-container {
  padding-top: 20px;
  padding-bottom: 20px;
  background: rgb(243, 247, 248);
}
.overview {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
  text-overflow: ellipsis;
  font-size: 18px;
}
.title {
  margin-top: 20px;
  color: var(--logo-font-color);
  font-size: 25px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-right: 10px;
}
.title span {
  color: gray;
  font-size: 14px;
}
.address {
  font-size: 18px;
}
.title-fa {
  margin-left: auto;
  color: gray;
}
.title-w {
  flex: 1;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
