import { ref } from "vue";
import { defineStore } from "pinia";

export const useMainStore = defineStore("mainStore", () => {
  const isLoginModal = ref(false);

  const modalName = "로그인";
  const inputList = [
    {title : '아이디', name :'userId'},
    {title : '비밀번호', name :'password'},
  ]

  const closeLoginModal = () => {
    isLoginModal.value = false;
    document.body.style.overflow = "visible";
  };

  const openLoginModal = () => {
    document.body.style.overflow = "hidden";
    isLoginModal.value = true;
  };

  return {
    modalName,
    inputList,
    isLoginModal,
    closeLoginModal,
    openLoginModal,
  };
});


export const useMainStore_register = defineStore("registerStore", () => {
  const isRegisterModal = ref(false);
  const modalName = "회원가입";
  const inputList = [
    {title : '아이디', name :'userId'},
    {title : '비밀번호', name :'password'},
    {title : '이름', name :'name'},
    {title : '이메일', name :'email'},
  ]


  const closeRegisterModal = () => {
    isRegisterModal.value = false;
    document.body.style.overflow = "visible";
  };

  const openRegisterModal = () => {
    document.body.style.overflow = "hidden";
    isRegisterModal.value = true;
  };
  return {
    inputList,
    modalName,
    isRegisterModal,
    closeRegisterModal,
    openRegisterModal,
  };
});
