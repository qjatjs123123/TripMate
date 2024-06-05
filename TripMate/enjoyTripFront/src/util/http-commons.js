import axios from "axios";
import { storeToRefs } from "pinia";
import router from "@/router"; // Vue Router 인스턴스를 가져옵니다.

// onlyAuthUser 함수 정의
const onlyAuthUser = async (config) => {
  const { useUserStore } = await import("@/stores/user"); // 경로는 실제 경로로 수정하세요.
  const userStore = useUserStore();
  const { data, isValidToken } = storeToRefs(userStore);
  if (!isValidToken.value || data.value === null) {
    alert("로그인 후 사용해주세요");
    router.push({ name: "main" });
    throw new axios.Cancel("Unauthorized"); // 요청을 취소합니다.
  }
  return config;
};

// local vue api axios instance
function localAxios() {
  const instance = axios.create({
    baseURL: 'http://localhost:8080',
    headers: {
      "Content-Type": "application/json;charset=utf-8",
    },
  });

  // 요청 인터셉터 추가
  instance.interceptors.request.use(
    async (config) => {
      console.log(config.url);
      if (config.url === "/cart/") {
        config = await onlyAuthUser(config);
      }
      return config;
    },
    (error) => {
      return Promise.reject(error);
    }
  );

  return instance;
}

export { localAxios };
