<script setup>
import { storeToRefs } from "pinia";
import { useMapStore } from "@/stores/map";

const mapStore = useMapStore();
const { getMapListByParam } = mapStore;

const { keyword } = storeToRefs(mapStore);

const focushandler = (e) => {
  e.target.parentElement.querySelector(".fa").style.color = "#007bff";
  e.target.parentElement.style.border = "2px solid #007bff";
};
const blurhandler = (e) => {
  e.target.parentElement.querySelector(".fa").style.color = "#adb5bd";
  e.target.parentElement.style.border = "2px solid #adb5bd";
};
const enterHandler = (e) => {
  keyword.value = e.target.value;
  getMapListByParam(true, false);
  e.target.value = '';
  keyword.value = '';
};
</script>

<template>
  <div className="tab-search-container">
    <i className="fa fa-search"></i>
    <input @focus="focushandler" @blur="blurhandler" @keyup.enter="enterHandler"/>
  </div>
</template>

<style scoped>
.tab-search-container {
  display: flex;
  border: 2px solid #adb5bd;
  padding: 10px 20px;
  color: #adb5bd;
  transition: 0.3s;
  align-items: center;
  border-radius: 8px;
}
.tab-search-container .fa {
  font-size: 22px;
  margin-right: 10px;
  transition: 0.3s;
}
.tab-search-container input {
  border: none;
  width: 100%;
  background: transparent;
}
.tab-search-container input:focus {
  outline: none;
}
.tab-search-container input:focus .tab-search-container {
  border: 1px solid #000;
}
</style>
