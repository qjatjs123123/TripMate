<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { listArticle, getImg } from "@/api/article.js";
import BoardListItem from "@/components/article/item/BoardListItem.vue";
import infiniteLoading from "v3-infinite-loading";
import "v3-infinite-loading/lib/style.css";
import { useUserStore } from "@/stores/user";
import { storeToRefs } from "pinia";

const router = useRouter();
const userStore = useUserStore();
const { isLogin } = storeToRefs(userStore);
const articles = ref([]);
const { VITE_ARTICLE_LIST_SIZE } = import.meta.env;
const param = ref({
  start: 1,
  limit: VITE_ARTICLE_LIST_SIZE,
  key: "",
  word: "",
});

const listArticlePromise = (params) => {
  return new Promise((resolve, reject) => {
    listArticle(params, resolve, reject);
  });
};

const getImgPromise = (imgId) => {
  return new Promise((resolve, reject) => {
    getImg(imgId, resolve, reject);
  });
};

const getArticleList = async () => {
  try {
    console.log("서버에서 글목록 얻어오자!!!", param.value);
    const response = await listArticlePromise(param.value);
    const { data } = response;

    // 각 게시글의 이미지를 불러옵니다.
    const articlesWithImages = await Promise.all(
      data.articles.map(async (article) => {
        try {
          const imgResponse = await getImgPromise(article.img);
          console.log(article.img);
          article.imgData = `data:image/jpeg;base64,${imgResponse.data}`;
        } catch (error) {
          console.error("Error fetching image for article:", article, error);
        }
        return article;
      })
    );

    if (param.value.start === 1) {
      articles.value = articlesWithImages;
    } else {
      articles.value.push(...articlesWithImages);
    }
    console.log(articles.value.length);
  } catch (error) {
    console.error("Error fetching articles:", error);
  }
};

const load = async ($state) => {
  console.log(param.value.start);
  param.value.start = parseInt(param.value.start) + parseInt(param.value.limit);
  try {
    const response = await listArticlePromise(param.value);
    const { data } = response;

    // 각 게시글의 이미지를 불러옵니다.
    const articlesWithImages = await Promise.all(
      data.articles.map(async (article) => {
        try {
          const imgResponse = await getImgPromise(article.img);
          article.imgData = `data:image/jpeg;base64,${imgResponse.data}`;
        } catch (error) {
          console.error("Error fetching image for article:", article, error);
        }
        return article;
      })
    );

    console.log(data.articles.length);
    if (articlesWithImages.length === 0) {
      $state.complete();
    } else {
      articles.value.push(...articlesWithImages);
      $state.loaded();
    }
  } catch (error) {
    console.error("Error fetching more articles:", error);
    $state.complete();
  }
};

const moveWrite = () => {
  console.log(isLogin);
  if (isLogin) {
    router.push({ name: "hotplace-write" });
  } else {
    alert("로그인 후 이용 가능합니다!");
  }
};

onMounted(() => {
  getArticleList();
});
</script>

<template>
  <div class="grid-container">
    <BoardListItem
      v-for="article in articles"
      :key="article.board_id"
      :article="article"
    ></BoardListItem>
  </div>
</template>

<style scoped>
.grid-container {
  width: 100%;
  max-width: 1240px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(
    auto-fill,
    minmax(200px, 1fr)
  ); /* 미디어 쿼리 적용 전, 기본 레이아웃 설정 */
  gap: 20px; /* 항목 사이에 간격 추가 */
}

/* 버튼 스타일은 그대로 유지 */

/* 미디어 쿼리 - 768px 이상 */
@media screen and (min-width: 768px) {
  .grid-container {
    grid-template-columns: repeat(2, 1fr); /* 2개의 컬럼으로 변경 */
  }
}


/* 미디어 쿼리 - 1440px 이상 */
@media screen and (min-width: 1440px) {
  .grid-container {
    grid-template-columns: repeat(2, 2fr); /* 2개의 컬럼으로 변경 */
  }
}

/* 미디어 쿼리 - 1919px 이상 */
@media screen and (min-width: 1919px) {
  .grid-container {
    grid-template-columns: repeat(3, 3fr); /* 4개의 컬럼으로 변경 */
  }
}
</style>
