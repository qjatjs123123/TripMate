<script setup>
import CommonBtn from "../common/CommonBtn.vue";
import SlideInput from "../common/SlideInput.vue";
import { useUserStore } from "@/stores/user";
import { defineEmits, ref, watch } from "vue";

const emit = defineEmits(["clickEvent", "inputEvent"]);

function onChangeActive() {
  emit("clickEvent", props.idx, false);
}

function onChangeInput(message, name) {
  emit("inputEvent", message, name);
}

const userStore = useUserStore();
const { inputList, userModify } = userStore;

const props = defineProps({
  data: String,
  idx: Number,
  paramData: Object,
});

let new_paramData = ref(props.paramData);

const update = () => {
  userModify(inputList[props.idx].title, new_paramData.value);
  onChangeActive();
};

watch(
  () => props.paramData,
  (newVal) => {
    // 변경 사항 처리
    console.log();
    new_paramData = newVal;
  }
);
</script>

<template>
  <form class="input-inner" @submit.prevent="onSubmit">
    <SlideInput
      :data="data"
      :title="inputList[props.idx].title"
      :name="inputList[props.idx].name"
      :key="inputList[props.idx].title"
      @update="onChangeInput"
    ></SlideInput>

    <CommonBtn :name="'저장'" :func="update" :class="['txt-update-btn']" />
  </form>
</template>

<style scoped>
.txt-update-btn {
  border-radius: 20px;
  padding: 7px 16px;
  background-color: var(--common-btn-color);
  color: white;
  cursor: pointer;
  width: 70px;
  position: absolute;
  right: 0;
  font-family: "Jua", sans-serif;
  font-style: normal;
  font-size: 18px;
}
</style>
