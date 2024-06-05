
import { defineStore } from "pinia";
import { ref } from "vue";

export const useApiStore = defineStore("apiStore", () => {

  let cnt = 0;
  const apiInfo = ref({
    api:"",
    state: "",
    count: cnt
  });

  const apiStateFunc = (apiParam, stateParam) => {
    apiInfo.value.api = apiParam
    apiInfo.value.state = stateParam
    apiInfo.value.count = ++cnt;
  }

  return {
    apiInfo,
    apiStateFunc,
  };
});
