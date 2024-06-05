<script setup>
import { defineProps, defineEmits } from "vue";
import { useCartStore } from "@/stores/cart";

const cartStore = useCartStore();
const { cartInsertFunc, cartDeleteFunc } = cartStore;



const emit = defineEmits(["clickEvent"]);
const props = defineProps({
  item: Object,
});


const putBasketItem = () => {
  if (props.item.isExist === 0) {
    cartInsertFunc(props.item);
    
    return;
  }
  cartDeleteFunc(props.item);

};
</script>

<template>
  <div @click.stop="putBasketItem" class="middle">
    <i v-if="props.item.isExist === 0" class="fa fa-heart-o no"></i>
    <i v-else class="fa fa-heart yes"></i>
  </div>
</template>

<style scoped>
.middle {
  display: flex;
  align-items: center; /* 수직 중앙 정렬 */
  justify-content: center; /* 수평 중앙 정렬 */
  height: calc(100% - 10px); /* 부모 요소의 높이를 차지하도록 설정 (필요에 따라 조정) */
  cursor: pointer;
  padding: 5px 5px;
}
.no {
  color: gray;
}
.yes {
  color: var(--withdraw-btn-color);
}
</style>
