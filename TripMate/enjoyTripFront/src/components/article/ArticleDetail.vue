<script setup>
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { detailArticle, deleteArticle, getImg } from "@/api/article";
import { useUserStore } from "@/stores/user";
import { storeToRefs } from "pinia";
import { useArticleStore } from "@/stores/article";
const route = useRoute();
const router = useRouter();
const userStore = useUserStore();
const { isLogin, userId } = storeToRefs(userStore);
const articleStore = useArticleStore();
const { cur_idx } = storeToRefs(articleStore);
// const articleno = ref(route.params.articleno);
const { boardId } = route.params;

const article = ref({});

onMounted(() => {
  getArticle();
});

const detailArticlePromise = (boardId) => {
  return new Promise((resolve, reject) => {
    detailArticle(boardId, resolve, reject);
  });
};

const getImgPromise = (imgId) => {
  return new Promise((resolve, reject) => {
    getImg(imgId, resolve, reject);
  });
};

const getArticle = async () => {
  try {
    const response = await detailArticlePromise(boardId);
    article.value = response.data;

    const imgResponse = await getImgPromise(article.value.img);
    article.value.imgData = `data:image/jpeg;base64,${imgResponse.data}`;
  } catch (error) {
    console.error("Error fetching article:", error);
  }
};

function moveList() {
  router.push({ name: "hotplace-list" });
}

function moveModify() {
  console.log(isLogin, userId, article.value.user_id);
  if (isLogin.value && userId.value === article.value.user_id) {
    router.push({ name: "hotplace-modify", params: { boardId } });
  } else {
    alert("수정 권한이 없습니다!");
  }
}

function onDeleteArticle() {
  // const { articleno } = route.params;
  console.log()
  if (isLogin.value && userId.value === article.value.user_id) {
    console.log(boardId + "번글 삭제하러 가자!!!");
    deleteArticle(
      boardId,
      (response) => {
        if (response.status == 200) {
          alert("삭제완료");
          cur_idx.value = 0;
          moveList();

        }
      },
      (error) => {
        console.log(error);
      }
    );
  } else {
    alert("삭제 권한이 없습니다!");
  }
}
</script>

<template>
  <div class="zzz">
    <div class="">
      <div class="">
        <mark class="sky">글보기</mark>
      </div>
      <div class="">
        <div class="">
          <h2 class="">제목 : {{ article.title }}</h2>
        </div>
        <div class="row">
          <div class="col-md-8">
            <div class="clearfix align-content-center">
              <img
                class="avatar me-2 float-md-start bg-light p-2"
                src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
              />
              <span class="fw-bold"> : {{ article.user_id }}</span>
              <p>
                <span class="text-secondary fw-light">
                  등록일 : {{ article.registerdate }} <br />
                  조회 : {{ article.hit }}
                </span>
              </p>
            </div>
          </div>
          <div><img :src="article.imgData" class="img" /></div>
          <div class="divider mb-3"></div>
          <div class="text-secondary mb-10">
            글 내용 : {{ article.content }}
          </div>
          <div class="divider mt-3 mb-3"></div>
          <div class="aaaaa">
            <button type="button" class="btn1 nfz" @click="onDeleteArticle">
              글삭제
            </button>
            <button type="button" class="btn2 nfz" @click="moveModify">
              글수정
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.text-secondary {
  margin-bottom: 30px;
}
.btn1 {
  width: 100px;
  border-radius: 20px;
  padding: 10px 16px;
  background-color: #ff6b6b;
  color: white;
  cursor: pointer;
  border: 0px;
}
.btn2 {
  margin-left: 10px;
  border: 0px;
  background-color: #007bff;
  width: 100px;
  border-radius: 20px;
  padding: 10px 16px;
  color: white;
  cursor: pointer;
}
.aaaaa {
  display: flex;
  justify-content: end;
  margin-bottom: 50px;
}
.zzz {
  overflow: hidden;
}
/* 버튼 스타일 */
.btn:hover {
  background-color: #007bff; /* 마우스 호버 시 배경색 변경 */
  color: #fff; /* 글자색 변경 */
  transition: background-color 0.3s; /* 배경색 변경 시 transition 효과 적용 */
}

.btn {
  height: 40px; /* 높이 설정 */
  border: 1px solid #007bff; /* 테두리 스타일 */
  background-color: transparent; /* 배경색 투명으로 설정 */
  cursor: pointer; /* 커서 설정 */
  border-radius: 5px; /* 테두리 둥글게 설정 */
  padding: 0 15px; /* 내부 여백 설정 */
  color: #007bff; /* 글자색 설정 */
  font-size: 16px; /* 글자 크기 설정 */
  line-height: 40px; /* 글자 수직 가운데 정렬 */
  font-family: "Jua", sans-serif; /* 글꼴 설정 */
}

/* 버튼 클릭 시 */
.btn:active {
  background-color: #0056b3; /* 클릭 시 배경색 변경 */
}

.img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  margin-bottom: 10px;
}
</style>
