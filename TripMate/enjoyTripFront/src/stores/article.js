import { defineStore } from "pinia";
import { ref } from "vue";

export const useArticleStore = defineStore("articleStore", () => {
  let imageData = "";
  const cur_idx = ref(0);

  const setImageData = (data) => {
    imageData = data;
  };

  return {
    imageData,
    setImageData,
    cur_idx

  };
});
