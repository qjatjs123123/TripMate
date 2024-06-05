<script setup>
import SlickSlider from "./SlickSlider.vue";
import { getLatestAttraction } from "@/api/map";
import { onMounted, ref } from "vue";

const attractions = ref([
  {
    title: "",
    imgData: "",
  },
]);

onMounted(() => {
  getAttractions();
});

const getLatestAttractionPromise = () => {
  return new Promise((resolve, reject) => {
    getLatestAttraction(resolve, reject);
  });
};

const getAttractions = async () => {
  try {
    const response = await getLatestAttractionPromise();
    attractions.value = response.data.map((attraction) => ({
      title: attraction.title,
      imgData: attraction.first_image,
    }));
  } catch (error) {
    throw new Error("Failed to fetch latest attractions");
  }
};

console.log(attractions);
</script>

<template>
  <div class="responsive-padding">
    <div class="inner-container">
      <h3>최신 여행지</h3>
      <SlickSlider :items="attractions" />
    </div>
  </div>
</template>

<style scoped>
h3 {
  margin-left: var(--slick-box-padding-left);
}
</style>
