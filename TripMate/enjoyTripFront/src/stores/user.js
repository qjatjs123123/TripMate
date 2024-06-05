
import { defineStore } from "pinia";
import { ref } from "vue";
import { update, login, findById, tokenRegeneration, logout, withdraw,register } from "@/api/user.js";
import { useApiStore } from "@/stores/api";
import { httpStatusCode } from "@/assets/Constants.js"
import { jwtDecode } from "jwt-decode"
import { useRouter } from "vue-router"
import { useMainStore_register } from "@/stores/main";


export const useUserStore = defineStore("userStore", () => {
  const apiStore = useApiStore();
  const { apiStateFunc } = apiStore;
  const isLogin = ref(false);
  const userId = ref("");
  const isError = ref(false);
  const isValidToken = ref(false)
  const router = useRouter()
  const modalName = "수정";
  const data = ref(null);

  const inputList = [
    {title : '아이디', name :'userId'},
    {title : '비밀번호', name :'password'},
    {title : '이름', name :'name'},
    {title : '이메일', name :'email'},
  ]
 
  const userLogin = async (loginUser, success, fail) => {
    apiStateFunc('로그인', '요청중...');
    await login(loginUser,
      (response) => {
        if  (response.status === httpStatusCode.CREATE) {
          success();
          apiStateFunc('로그인', '성공...');
          let { data } = response;
          let accessToken = data["access-token"]
          let refreshToken = data["refresh-token"]
          isLogin.value = true;
          userId.value = loginUser.userId;
          isError.value=false;
          isValidToken.value = true
          sessionStorage.setItem("accessToken", accessToken);
          sessionStorage.setItem("refreshToken", refreshToken); 
    
        }
      },
      (err) => {
        if (err.response.status === httpStatusCode.UNAUTHORIZED) apiStateFunc('로그인', '실패...');
        else {
          apiStateFunc('로그인', '서버오류');
          fail();
        }
        isError.value = true;
        isValidToken.value = false
      }
    )

  }

  const getUserInfo = async (token) => {
    let decodeToken = jwtDecode(token)
    await findById(
      decodeToken.userId,
      (response) => {
        if (response.status === httpStatusCode.OK) {
          data.value = response.data.userInfo
          isLogin.value = true;
          userId.value = data.value.userId;
          isError.value=false;
          isValidToken.value = true;
   
        } else {
          console.log("유저 정보 없음!!!!")
        }
      },
      async (error) => {
        console.error(
          "g[토큰 만료되어 사용 불가능.] : ",
          error.response.status,
          error.response.statusText
        )
        isValidToken.value = false

        await tokenRegenerate()
      }
    )
  }

  const tokenRegenerate = async () => {
    await tokenRegeneration(
      JSON.stringify(data.value),
      (response) => {
        if (response.status === httpStatusCode.CREATE) {
          let accessToken = response.data["access-token"]
          sessionStorage.setItem("accessToken", accessToken)
          isValidToken.value = true
        }
      },
      async (error) => {
        // HttpStatus.UNAUTHORIZE(401) : RefreshToken 기간 만료 >> 다시 로그인!!!!
        if (error.response.status === httpStatusCode.UNAUTHORIZED) {
          // 다시 로그인 전 DB에 저장된 RefreshToken 제거.
          await logout(
            data.value.userId,
            (response) => {
              if (response.status === httpStatusCode.OK) {
                console.log("리프레시 토큰 제거 성공")
              } else {
                console.log("리프레시 토큰 제거 실패")
              }
              alert("RefreshToken 기간 만료!!! 다시 로그인해 주세요.")
              isLogin.value = false
              data.value = null
              isValidToken.value = false
              router.push({ name: "user-login" })
            },
            (error) => {
              console.error(error)
              isLogin.value = false
              data.value = null
            }
          )
        }
      }
    )
  }

  const userLogout = async () => {
    apiStateFunc('로그아웃', '요청중...');
    await logout(
      userId.value,
      (response) => {
        if (response.status === httpStatusCode.OK) {
          isLogin.value = false
          data.value = null
          isValidToken.value = false

          sessionStorage.removeItem("accessToken")
          sessionStorage.removeItem("refreshToken")
          apiStateFunc('로그아웃', '완료...');
          router.push({ name: "main" })
        } else {
          apiStateFunc('유저정보', '없음');
        }
      },
      () => {
        apiStateFunc('로그아웃', '서버오류');
      }
    )
  }

  const userModify = async (title, param) => {
    apiStateFunc(title, '수정중...');
    await update(
      JSON.stringify(param),
      (response) => {
        if (response.status === httpStatusCode.OK) {
          data.value = response.data.userInfo;
          userId.value = data.value.userId;
          apiStateFunc(title, '수정완료...');
        } else {
          apiStateFunc(title, '서버오류');
        }
      },
      () => {
        apiStateFunc(title, '서버오류');
      }
    )
  }

  const userWithdraw = async () => {
    apiStateFunc('회원', '삭제중...');
    await withdraw(
      userId.value,
      (response) => {
        if (response.status === httpStatusCode.OK) {
          apiStateFunc('회원', '삭제완료...');
          isLogin.value = false;
          data.value = null;
          sessionStorage.removeItem("accessToken");
          sessionStorage.removeItem("refreshToken");
          router.push({ name: "main" });
        } else {
          apiStateFunc('', '서버오류');
        }
      },
      () => {
        apiStateFunc(title, '서버오류');
      }
    )

  }


  const userRegister = async (paramData) => {
    const registerStore = useMainStore_register();
    const { closeRegisterModal } = registerStore;
    apiStateFunc('회원', '등록중...');
    await register(
      paramData,
      (response) => {
        if (response.status === httpStatusCode.OK) {
          closeRegisterModal();
          apiStateFunc('회원', '등록완료...');
        } else {
          apiStateFunc('회원', '등록오류');
        }
      },
      () => {
        apiStateFunc('회원', '서버오류');
      }
    )
  }

  return {
    isError,
    isLogin,
    userId,
    isValidToken,
    userModify,
    userLogin,
    getUserInfo,
    userLogout,
    tokenRegenerate,
    userWithdraw,
    userRegister,
    data,
    inputList,
    modalName,
  };
});
