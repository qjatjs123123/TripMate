<script setup>
import { defineEmits, watch } from "vue";
import LoveBtn from "../common/LoveBtn.vue";
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { detailData, mapList } = storeToRefs(mapStore);

function onLoveBtnActive(num) {
  emit("clickLoveBtn", num);
}
const emit = defineEmits(["clickEvent", "clickLoveBtn"]);

function onChangeActive() {
  emit("clickEvent");
}

watch(
  mapList,
  (newValue) => {
    // mapList 배열을 순회하면서 detailData의 content_id와 일치하는 객체를 찾습니다.
    if (!detailData.value.content_id) return;
    for (const item of newValue) {
      if (item.content_id === detailData.value.content_id) {
        // detailData를 해당 객체로 변경합니다.
        detailData.value = item;
        break; // 찾았으면 반복문 종료
      }
    }
  },
  { deep: true }
); // 깊은 감시 설정
</script>

<template>
  <div class="responsive-padding-modal modal-container1" @click="onChangeActive">
    <div class="content-container inner-container-modal" @click.stop>
      <div class="info">관광지 정보</div>
      <div class="close-modal" @click="onChangeActive">
        <i class="fa fa-times"></i>
      </div>
      <div class="inner-container scroll">
        <div class="img-container">
          <div class="img-title">
            <div class="title-w"><i class="fa fa-bookmark"></i> {{ detailData.title }}</div>
            <div class="title-fa">
              <LoveBtn :item="detailData" @clickEvent="onLoveBtnActive" />
            </div>
          </div>
          <img class="img-item" :src="detailData.first_image ? detailData.first_image : '/noImage.png'" />
        </div>
        <div class="img-addr">
          <i class="fa fa-home"></i> {{ detailData.addr1 }} (<span>{{ detailData.addr2 }} </span>)
        </div>
        <div class="img-overview"><i class="fa fa-sticky-note"></i> {{ detailData.overview }}</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.title-fa {
  margin-left: auto;
}
.title-w {
  flex: 1;
}
.close-modal {
  position: absolute;
  top: 4px;
  right: 8px;
  color: white;
  padding: 1px 1px;
  cursor: pointer;
  font-size: 30px;
}
.img-overview {
  line-height: 1.1em;
  margin-bottom: 20px;
}
.inner-container i {
  color: var(--login-btn-color);
}
.img-addr {
  margin-bottom: 10px;
}
.img-addr span {
  font-size: 16px;
  color: gray;
}
.img-title {
  color: var(--login-btn-color);
  display: flex;
  font-size: 30px;
  word-wrap: break-word; /* 텍스트가 div의 너비를 넘을 때 자동으로 개행 */
  word-break: break-word; /* 긴 단어가 있을 때 자동으로 개행 */
  white-space: normal; /* 기본적인 공백 처리 (기본값) */
}
.img-container {
  padding: 0px 5%;
}
.info {
  padding: 10px;
  background-color: var(--common-btn-color);
  color: #fff;
  border-radius: 10px 10px 0 0;
}
.inner-container {
  padding: 30px 30px;
  width: calc(100%);
  height: calc(100% - 60px);
  overflow-y: auto;
  padding-bottom: 0px;
  box-sizing: border-box;
}
.img-item {
  width: calc(100%);
  object-fit: fill;
}
.modal-container1 {
  width: 100%;
  height: calc(100% - var(--header-total-height));
  background-color: rgba(0, 0, 0, 0.08);
  z-index: 21;
  position: fixed;
  display: flex;
  flex-direction: column;
  left: var(--side-menu-width);
  top: var(--header-total-height);
  overflow: hidden;
}
.content-container {
  background-color: #fff;
  position: absolute;
  border-radius: 10px;
  overflow: hidden;
}
</style>
