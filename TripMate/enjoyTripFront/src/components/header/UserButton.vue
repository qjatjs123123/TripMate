<script setup>
import { USERMENU_LIST } from "@/assets/Constants.js";
import { ref, onMounted, onUnmounted } from "vue";
import { logout } from "@/api/user";
import { storeToRefs } from "pinia";
import { useUserStore } from "@/stores/user";
import { useRouter } from 'vue-router'

const router = useRouter()
const userStore = useUserStore();
const isActive = ref(false);
const { userId } = storeToRefs(userStore);
const { userLogout } = userStore;


const toggleDropdown = (event) => {
  event.stopPropagation();
  isActive.value = !isActive.value;
};
const handleClickOutside = () => {
  isActive.value = false;
};

const handleItemClick = (event, item) => {
  event.stopPropagation();
  if (item === USERMENU_LIST[0] )
    router.push({ name: 'user' })
  else if(item === USERMENU_LIST[1])
    userLogout();
  isActive.value = false;
};

onMounted(() => {
  document.body.addEventListener("click", handleClickOutside);
});

onUnmounted(() => {
  document.body.removeEventListener("click", handleClickOutside);
});
</script>

<template>
  <div class="img-box" @click="toggleDropdown">
    <img src="/profile.png" />
    <i class="fa fa-caret-down md"></i>
    <div class="tab-dropbox-drop" :class="{ active: isActive }">
      <div v-for="(item, index) in USERMENU_LIST" :key="index" @click="(event) => handleItemClick(event, item)">
        {{ item }}
      </div>
    </div>
  </div>
</template>

<style scoped>

@media (max-width: 768px) {
  .md {
    display: none;
  }
}

.tab-dropbox-drop {
  position: absolute;
  right: 0;
  top: 0;
  width: 150px;

  background-color: #fff;
  margin-top: 50px;
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
.tab-dropbox-drop > div:hover {
  color: var(--login-btn-color);
}

.img-box:hover .md {
  color: black;
}
.md {
  margin-left: 10px;
  color: #7a7a7a;
}

.img-box {
  position: relative;
  width: 55px;
  height: 45px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.img-box img {
  width: 45px;
  height: 45px;
  border-radius: 50%;
}
</style>
