import { createRouter, createWebHistory, useRoute } from "vue-router";
// import TheBoardView from "@/views/TheBoardView.vue";
import TheMainView from "@/views/TheMainView.vue";
import TheUserView from "@/views/TheUserView.vue";
import TheMapView from "@/views/TheMapView.vue";
import ThePlanView from "@/views/ThePlanView.vue";
import TheHotPlaceView from "@/views/TheHotPlaceView.vue";
import { storeToRefs } from "pinia";
import { useUserStore } from "@/stores/user";
import { useApiStore } from "@/stores/api";
import { useArticleStore } from "@/stores/article";

const onlyAuthUser = async (to, from, next) => {
  const userStore = useUserStore();
  const apiStore = useApiStore();
  const { apiStateFunc } = apiStore;

  const { data, isValidToken } = storeToRefs(userStore);
  if (!isValidToken.value || data.value === null) {
    alert("로그인 후 사용해주세요");
    next({ name: "main" });
  } else {
    next();
  }
};
const check = () => {
  console.log("QWe");
  const articleStore = useArticleStore();
  const { cur_idx } = storeToRefs(articleStore);
  const route = useRoute()
    const currentRouteName = route.name;
    if(currentRouteName === 'hotplace-list') cur_idx.value = 0;
    else cur_idx.value = 1;

}
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "main",
      component: TheMainView,
    },
    {
      path: "/user",
      name: "user",
      beforeEnter: onlyAuthUser,
      component: TheUserView,
    },
    {
      path: "/map",
      name: "map",
      component: TheMapView,
    },
    {
      path: "/plan",
      name: "plan",
      component: ThePlanView,
    },
    {
      path: "/hotplace",
      name: "hotplace",
      // component: TheBoardView,
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/TheBoardView.vue"),
      redirect: { name: "hotplace-list" },
      children: [
        {
          path: "list",
          name: "hotplace-list",
          component: () => import("@/components/article/ArticleList.vue"),
        },
        {
          path: "view/:boardId",
          name: "hotplace-view",
          component: () => import("@/components/article/ArticleDetail.vue"),
        },
        {
          path: "write",
          name: "hotplace-write",
          component: () => import("@/components/article/ArticleWrite.vue"),
        },
        {
          path: "modify/:boardId",
          name: "hotplace-modify",
          component: () => import("@/components/article/ArticleModify.vue"),
        },
      ],
    },
  ],
});

router.beforeEach(async () => {
  // 여기에서 모든 라우트에 대해 공통된 작업을 수행할 수 있습니다.

  const userStore = useUserStore();
  const { getUserInfo } = userStore;

  let token = sessionStorage.getItem("accessToken");

  if (token) {
    await getUserInfo(token);
  }
});

export default router;
