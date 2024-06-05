<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const goToArticle = (articleId) => {
  router.push({ name: 'hotplace-view', params: { boardId: articleId } });
};
const props = defineProps({
  article: Object,
});
</script>

<template>
  <div class="item-box" @click="goToArticle(article.board_id)">
    <div class="image-container">
      <img class="grid-image" :src="article.imgData" />
    </div>
    <div class="txt-container">
      <div class="text-center overxy">
        {{ article.title }}
        <!-- <router-link
        :to="{
          name: 'hotplace-view',
          params: { boardId: article.board_id },
        }"
        class="article-title link-dark"
      >
        {{ article.title }}
      </router-link> -->
      </div>
      <div class="content txt-webkit-box-2">
        {{ article.content }}
      </div>
      <div class="date">
        {{ article.registerdate }}
      </div>
    </div>
    <div class="id-container">
      <div class="userid">
        by <span>{{ article.user_id }}</span>
      </div>

      <div class="fzd">
        <div>
          <i class="fa fa-heart-o"></i> <span> {{ article.hit }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.item-box:hover {
  transform: translateY(-7px); /* 호버될 때 위로 5px만큼 이동 */
}
.fzd {
  font-size: 18px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.userid {
  font-size: 18px;
  color: #868e96;
}
.userid span {
  font-size: 20px;
  color: black;
}
.id-container {
  padding: 10px 10px;
  border: 1px solid #eee;
  display: flex;
  justify-content: space-between;
}
.date {
  color: #868e96;
  font-size: 13px;
  margin-top: 30px;
}
.overxy {
  overflow-x: hidden;
  overflow-y: hidden;
  word-break: break-word;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
  overflow: hidden;
  text-overflow: ellipsis;
}
.txt-container {
  padding: 1rem;
  display: flex;
  flex: 1 1;
  flex-direction: column;
}
/* 기본 그리드 레이아웃 (모바일) */
.date {
}
.text-center {
  font-size: 22px;
  margin-top: 10px;
}
.content {
  font-size: 18px;
  color: #868e96;

  word-break: break-word;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
  text-overflow: ellipsis;
}
.item-box {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  position: relative; /* 이미지의 절대 위치를 설정하기 위한 부모 컨테이너 */
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 4px 16px 0 rgba(0, 0, 0, 0.04);
  transition: 0.5s;
  cursor: pointer;
}

/* 이미지 컨테이너 */
.image-container {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  padding-top: 50%;
}

/* 이미지 스타일 */
.grid-image {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 이미지 비율을 유지하며, 컨테이너에 맞게 조정 */
  position: absolute;
  top: 0;
  left: 0;
}

/* 링크 스타일 */
a {
  text-decoration: none;
}
</style>
