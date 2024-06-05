
import { defineStore } from "pinia";
import { ref } from "vue";
import { cartInsert, cartDelete, findCartById } from "@/api/cart.js";
import { useUserStore } from "@/stores/user";
import { useMapStore } from "@/stores/map";
import { storeToRefs } from "pinia";
import {
  useApiStore
} from "@/stores/api";

export const useCartStore = defineStore("cartStore", () => {
  const cartList = ref([]);
  const cartCnt = ref(0);
  const userStore = useUserStore();
  const mapStore = useMapStore();
  const { userId } = storeToRefs(userStore);
  const { changeStateByContentId } = mapStore;;
  const apiStore = useApiStore();
  const {
    apiStateFunc
  } = apiStore;

  const cartInsertFunc = async (data,success) => {
    const param = {
      userId: userId.value,
      content_id: data.content_id
    };
    apiStateFunc('장바구니', '저장요청...');
    await cartInsert(
      param,
      (response) => {
        apiStateFunc('장바구니', '저장완료...');
        cartList.value = [];
        cartList.value = cartList.value.concat(response.data.cartList);
        cartCnt.value = cartList.value.length;
        changeStateByContentId(data.content_id, 1)
      },
      (err) => {
        apiStateFunc('장바구니', '저장실패...');
        console.error(err);
      }
    );
    cartCnt.value = cartList.value.length;
    // cartInsert(param, success, fail);
  }

  const cartDeleteFunc = async (data, success) => {
    const param = {
      userId: userId.value,
      content_id: data.content_id
    };
    apiStateFunc('장바구니', '삭제요청...');
    await cartDelete(
      param,
      (response) => {
        apiStateFunc('장바구니', '삭제완료...');
        cartList.value = [];
        cartList.value = cartList.value.concat(response.data.cartList);
        cartCnt.value = cartList.value.length;
        changeStateByContentId(data.content_id, 0)
      },
      (err) => {
        apiStateFunc('장바구니', '삭제실패...');
        console.error(err);
      }
    );
    cartCnt.value = cartList.value.length;
  }

  const findCartByIdFunc = async (isClick) => {

    await findCartById(
      userId.value,
      (response) => {
        cartList.value = [];
        cartList.value = cartList.value.concat(response.data.cartList);
        cartCnt.value = cartList.value.length;
        console.log(cartList.value);
      },
      (err) => {
        console.error(err);
      }
    );
  }


  return {
    cartList,
    cartCnt,
    cartInsertFunc,
    cartDeleteFunc,
    findCartByIdFunc
  };
});
