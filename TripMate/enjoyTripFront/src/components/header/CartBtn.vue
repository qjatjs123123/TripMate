<script setup>
import { computed, ref, onMounted, onUnmounted } from "vue";
import { storeToRefs } from "pinia";
import { useCartStore } from "@/stores/cart";
const cartStore = useCartStore();
const { cartDeleteFunc, findCartByIdFunc } = cartStore;

onMounted(() => {
  document.body.addEventListener("click", handleClickOutside);
  findCartByIdFunc();
});

onUnmounted(() => {
  document.body.removeEventListener("click", handleClickOutside);
});

const isActive = ref(false);

const toggleDropdown = (event) => {
  event.stopPropagation();
  isActive.value = !isActive.value;
};
const { cartCnt, cartList } = storeToRefs(cartStore);

const displayCartCnt = computed(() => {
  return cartCnt.value >= 10 ? "9+" : cartCnt.value;
});
const handleClickOutside = () => {
  isActive.value = false;
};



const deleteCartItem = (item) => {
  cartDeleteFunc(item)
}

</script>

<template>
  <div class="img-container" @click="toggleDropdown">
    <img src="/cart.png" />
    <div class="cartCnt-container">{{ displayCartCnt }}</div>
    <div @click.stop class="tab-dropbox-drop scroll" :class="{ active: isActive }">
      <div class="middle">찜 목록</div>
      <div
        v-for="(item, index) in cartList"
        :key="index"
        class="item"
      >
      <img :src="item.first_image ? item.first_image : '/noImage.png'" />
        <div class="info">
          <div class="txt-webkit-box-1" :title="item.title">
            {{ item.title }}
          </div>
          <div class="txt-webkit-box-1" :title="item.addr1">
            {{ item.addr1 }}
          </div>
        </div>
        <div class="btn-container">
          <button class="login-button nb nbgc" @click="deleteCartItem(item)">
            <span class="nfz">삭제</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-button {
  width: 100%;
  border-radius: 20px;
  padding: 10px 16px;
  background-color: var(--withdraw-btn-color);
  color: white;
  cursor: pointer;
}
.item {
  display: flex;
}
.item button {
  flex: 1;
}
.item .info {
  flex: 8;
  display: flex;
  flex-direction: column;
  font-size: 15px;
  justify-content: center;
}
.item img {
  width: 50px;
  height: 50px;
  flex: 3;
  margin-right: 20px;
}
.tab-dropbox-drop {
  position: absolute;
  right: 0;
  top: 0;
  width: 500px;
  max-height: 300px;
  overflow-y: auto;
  overflow-x: hidden;
  background-color: #fff;
  margin-top: 40px;
  transform: scale(0.5, 0.5);
  transform-origin: 100% 0;
  transition: 0.3s;
  opacity: 0;
  border-radius: 5px;
  box-shadow: 0px 0px 8px 0px rgba(0, 0, 0, 0.1);
  z-index: 100;
  visibility: hidden;
}
.tab-dropbox-drop.active {
  transform: scale(1, 1);
  opacity: 1;
  visibility: visible;
}
.tab-dropbox-drop > div {
  padding: 10px 20px;
  border-bottom: 1px solid #eee;
}

.cartCnt-container {
  top: 0;
  right: 0;
  background-color: var(--withdraw-btn-color);
  color: #fff;
  position: absolute;
  width: 15px;
  height: 15px;
  border-radius: 50%;
  text-align: center;
  font-size: 10px;
  line-height: 1.7em;
}
.img-container {
  width: 30px;
  height: 30px;
  cursor: pointer;
  position: relative;
}
img {
  width: 100%;
  height: 100%;
}
@media (max-width: 768px) {
  .login-button {
    padding: 0 0;
  }
  .img-container img {
    width: 100%;
  }
  .btn-container {
    width: 70px;
    height: 20px;
    margin: 0 auto;
  }
  .tab-dropbox-drop {
    width: 200px;
  }
  .item {
    display: flex;
    flex-direction: column;
  }
}
</style>
