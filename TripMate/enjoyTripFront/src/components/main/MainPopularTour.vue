<script setup>
import SlickSlider from "./SlickSlider.vue";
import { ref, onMounted } from "vue";
import { getPopularArticle, getImg } from "@/api/article.js";

const articles = ref([]);

onMounted(() => {
  getArticleList();
});

const getPopularArticlePromise = () => {
  return new Promise((resolve, reject) => {
    getPopularArticle(resolve, reject);
  });
};

const getImgPromise = (imgId) => {
  return new Promise((resolve, reject) => {
    getImg(imgId, resolve, reject);
  });
};

const getArticleList = async () => {
  try {
    console.log("서버에서 글목록 얻어오자!!!");
    const response = await getPopularArticlePromise();
    const { data } = response;
    articles.value = await Promise.all(
      data.articles.map(async (article) => {
        try {
          const imgResponse = await getImgPromise(article.img);
          article.imgData = `data:image/jpeg;base64,${imgResponse.data}`;
          return article;
        } catch (error) {
          console.error("Error fetching image for article:", article, error);
          return article;
        }
      })
    );
  } catch (error) {
    console.error("Error fetching articles:", error);
  }
};
</script>

<template>
  <div class="responsive-padding">
    <div class="inner-container">
      <h3>핫플 인기글</h3>
      <SlickSlider :items="articles" />
    </div>
  </div>
</template>

<style scoped>
h3 {
  margin-left: var(--slick-box-padding-left);
}
</style>
