<template>
  <div class="input-box">
    <label>{{ props.title }}</label>
    <input
      :name="props.name"
      ref="inputRef"
      @focus="handleFocus"
      @blur="handleBlur"
      type="text"
      :placeholder="props.title"
      :value="props.data"
      @input="updateValue"
    />

    <div class="inputbarbox-container">
      <div class="inputbarbox">
        <div class="inputbarleft-inner">
          <div
            ref="leftBarRef"
            class="inputbarleft"
            :class="{ active: isActive }"
          ></div>
        </div>

        <div class="inputbarright-inner">
          <div
            ref="rightBarRef"
            class="inputbarright"
            :class="{ active: isActive }"
          ></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps, ref, defineEmits } from "vue";

const props = defineProps({
  title: String,
  name: String,
  data: String,
});

const emit = defineEmits(['update']);

function updateValue(event) {
  emit('update', event.target.value, props.name);
}


const isActive = ref(false);

const inputRef = ref(null);
const leftBarRef = ref(null);
const rightBarRef = ref(null);

function handleFocus() {
  isActive.value = true;
  leftBarRef.value.classList.add("active");
  rightBarRef.value.classList.add("active");
}

function handleBlur() {
  isActive.value = false;
  leftBarRef.value.classList.remove("active");
  rightBarRef.value.classList.remove("active");
}
</script>

<style scoped>
label {
  font-size: 16px;
}
input {
  border: none;
  border-bottom: 2px solid #ccc; /* 하단 border 스타일 지정 */
  padding: 8px 12px;
  outline: none;
  font-size: 16px;
  transition: border-color 0.3s ease; /* border 색상 변화에 대한 transition 효과 */
  width: calc(100% - 24px);
}

input::placeholder {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
}

.inputbarbox-container {
  position: absolute;
  width: 100%;
  bottom: 1px;
}

.slide-input {
  position: relative;
  width: 100%;
}
.input-box {
  position: relative;
  margin-bottom: 20px;
}
.inputbarbox {
  width: 100%;
  position: relative;
  display: flex;
}
.inputbarleft-inner {
  width: 50%;
  height: 2px;
  overflow: hidden;
  position: relative;
}
.inputbarright-inner {
  width: 50%;
  height: 2px;
  overflow: hidden;
  position: relative;
}
.inputbarleft {
  position: absolute;
  width: 0%;
  height: 50px;
  right: 0;
  top: 0;
  background-color: #000;
  transition: 0.25s;
}
.inputbarright {
  position: absolute;
  width: 0%;
  height: 50px;
  left: 0;
  top: 0;
  background-color: #000;
  transition: 0.25s;
}
.inputbarleft.active,
.inputbarright.active {
  width: 100%;
}
</style>
