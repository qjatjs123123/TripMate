<script setup>
import { ref, onMounted, watchEffect ,watch } from 'vue';
import { storeToRefs } from "pinia";
import { useArticleStore } from "@/stores/article";
import { useRouter, useRoute } from "vue-router";
const router = useRouter();
const route = useRoute()
const articleStore = useArticleStore();
const { cur_idx } = storeToRefs(articleStore);
const tabBar = ref(null);

watch(cur_idx, () => {
  tabBar.value.style.marginLeft = `${cur_idx.value * 100}px`;
})
const tabBarhandle = (idx) => {
  cur_idx.value = idx;

  
  tabBar.value.style.marginLeft = `${cur_idx.value * 100}px`;
  if (cur_idx.value === 0) router.push({ name: "hotplace" });
  else router.push({ name: "hotplace-write" });
};

</script>

<template>
  <div class="responsive-padding">
    <div class="inner-container">
      <div class="user-wrapper">
        <div class="user-tabs">
          <div class="tabs">
            <div @click="tabBarhandle(0)" :class="['tab', { active: cur_idx === 0 }]">
              <i class="fa fa-list-alt"></i>
              <span>게시물</span>
            </div>

            <div @click="tabBarhandle(1)" :class="['tab', { active: cur_idx === 1 }]">
              <i class="fa fa-pencil-square-o"></i>
              <span>글쓰기</span>
            </div>
          </div>
          <div ref="tabBar" class="tab-bar"></div>
        </div>
        <div class="user-container"></div>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<style>
.user-wrapper {
  width: calc(100% - 20px );
  height: auto;

}
.user-tabs {
  width: 100%;
  height: 50px;
  margin-top: 20px;
  margin-bottom: 40px;

}
.user-tabs > .tabs {
  display: flex;
  height: 100%;
  width: auto;
  min-width: 1100px;
  position: relative;
}
.user-tabs > .tabs > .tab {
  width: 90px;
  height: 100%;
  display: flex;
  font-size: 20px;
  color: rgb(134, 142, 150);
  padding-top: 10px;
  margin-right: 10px;
  text-align: center;
  justify-content: center;
  cursor: pointer;
}
.user-tabs > .tabs > .tab.active {
  color: #000;
  font-weight: bold;
}
.user-tabs > .tabs > .tab > .fa {
  margin-right: 10px;
  transform: translateY(5px);
}
.tab-bar {
  width: 90px;
  height: 2px;
  background-color: #000;
  transition: 0.3s;
}

.hotplace-text {
  color: #4996f6; /* 원하는 핫플 색상으로 변경 */
}
</style>
