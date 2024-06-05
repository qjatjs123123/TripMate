<script setup>
  import userProfile from "@/components/user/userProfile.vue";
</script>

<template>
  <div class="bg-img">
    <img src="/main/banner0.png"/>
  </div>
  <div class="container responsive-padding">
    <userProfile />
  </div>
</template>

<style scoped>
  .bg-img{
    width: 100vw;
    height: 60vh;
  }
  .bg-img img{
    width: 100%;
    height: 100%;
    object-fit:cover;
  }
</style>