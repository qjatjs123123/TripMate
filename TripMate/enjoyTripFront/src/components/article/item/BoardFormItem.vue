<script setup>
import { ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import { registArticle, detailArticle, modifyArticle } from "@/api/article";
import { QuillEditor } from "@vueup/vue-quill";
import { storeToRefs } from "pinia";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import "quill/dist/quill.snow.css";
//import { storeToRefs } from "pinia";
import { useUserStore } from "@/stores/user";
import SlideInput from "@/components/common/SlideInput.vue";
import { useArticleStore } from "@/stores/article";
const articleStore = useArticleStore();
const { cur_idx } = storeToRefs(articleStore);

const userStore = useUserStore();
const userId = userStore.userId;

//const { isLogin } = storeToRefs(userStore);

const router = useRouter();
const route = useRoute();
const props = defineProps({ type: String });
const isUseId = ref(false);
const subjectErrMsg = ref("");
const contentErrMsg = ref("");
const files = ref(null);

const article = ref({
  board_id: 0,
  title: "",
  content: "",
  user_id: userId,
  hit: 0,
  registerdate: "",
});

// Quill Editor 옵션 설정
const editorOption = {
  theme: "snow",
  modules: {
    toolbar: [
      ["bold", "italic", "underline", "strike"],
      ["clean"],
      ["link"],
    ],
  },
  placeholder: "내용을 입력하세요...",
};

if (props.type === "modify") {
  let { boardId } = route.params;
  console.log(boardId + "번글 얻어와서 수정할거야");
  detailArticle(
    boardId,
    ({ data }) => {
      article.value = data;
      isUseId.value = true;
    },
    (error) => {
      console.log(error);
    }
  );
  isUseId.value = true;
}

watch(
  () => article.value.title,
  (value) => {
    let len = value.length;
    if (len == 0 || len > 30) {
      subjectErrMsg.value = "제목을 확인해 주세요!!!";
    } else subjectErrMsg.value = "";
  },
  { immediate: true }
);

watch(
  () => article.value.content,
  (value) => {
    let len = value.length;
    if (len == 0 || len > 500) {
      contentErrMsg.value = "내용을 확인해 주세요!!!";
    } else contentErrMsg.value = "";
  },
  { immediate: true }
);

function onSubmit() {
  // event.preventDefault();
  if (subjectErrMsg.value) {
    alert(subjectErrMsg.value);
  } else if (contentErrMsg.value) {
    alert(contentErrMsg.value);
  } else {
    props.type === "regist" ? writeArticle() : updateArticle();
  }
}

function writeArticle() {
  console.log("글등록하자!!", article.value);
  let formData = new FormData();
  formData.append(
    "boardDto",
    new Blob([JSON.stringify(article.value)], { type: "application/json" })
  );
  Array.from(files.value.files).forEach((file) => {
    formData.append("files", file);
  });
  registArticle(
    formData,
    (response) => {
      let msg = "글등록 처리시 문제 발생했습니다.";
      if (response.status == 200) msg = "글등록이 완료되었습니다.";
      alert(msg);
      cur_idx.value = 0;
      moveList();
    },
    (error) => console.log(error)
  );
}

function updateArticle() {
  console.log(article.value.board_id + "번글 수정하자!!", article.value);
  let formData = new FormData();
  formData.append(
    "boardDto",
    new Blob([JSON.stringify(article.value)], { type: "application/json" })
  );
  Array.from(files.value.files).forEach((file) => {
    formData.append("files", file);
  });
  modifyArticle(
    formData,
    (response) => {
      let msg = "글수정 처리시 문제 발생했습니다.";
      if (response.status == 200) msg = "글정보 수정이 완료되었습니다.";
      alert(msg);
      // moveList();
      router.push({ name: 'hotplace-view', params: { boardId: article.value.articleNo } });
    
    },
    (error) => console.log(error)
  );
}

function moveList() {
  router.replace({ name: "hotplace-list" });
}

function handleMessage(message, name) {
  article.value.title = message;
}
</script>

<template>
  <div class="">
    <label for="userid" class="form-label">작성자 ID : {{ article.user_id }}</label>

    <div class="mb">
      <SlideInput :title="'제목'" :name="'title'" :data="article.title" @update="handleMessage"/>
    </div>
    <QuillEditor
      :options="editorOption"
      v-model:content="article.content"
      contentType="text"
      theme="snow"
    />
    <div class="mb">
      
    </div>
    <div class="mb3">
      <label for="file" class="form-label">이미지 업로드 : </label>
      <input type="file" class="form-control" ref="files" multiple="multiple" id="upload" />
    </div>

    <div class="aa2">
      <div class="col-auto text-center">
        <button @click="onSubmit" type="submit" class="btn btn-outline-primary mb-3" v-if="type === 'regist'">
          글작성
        </button>
        <button  @click="onSubmit" type="submit" class="btn btn-outline-success mb-3" v-else>글수정</button>
        
      </div>
    </div>
  </div>
</template>

<style scoped>
.aa2{
  display: flex;
  justify-content: end;
}
.mb3{
  margin-top: 30px;
  margin-bottom: 10px;
}
.mb {
  margin-top: 30px;
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
</style>
