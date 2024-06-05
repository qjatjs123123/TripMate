<template>

  <div class="container">
      <carousel :wrap-around="true" transition="1000">
        <slide v-for="slide in MAINIMG_LIST" :key="slide">
          <img :src="slide" class="mainImg"/>     
        </slide>

        <template #addons>
          <navigation />
          
        </template>
      </carousel>
  </div>
</template>
<script setup>
import { MAINIMG_LIST } from '@/assets/Constants.js';

</script>
<script>
// If you are using PurgeCSS, make sure to whitelist the carousel CSS classes
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel'


export default {
  name: 'App',
  components: {
    Carousel,
    Slide,
    Navigation,
  },
}
</script>
<style scoped>
.container {
  width: 100vw;
  height: var(--mainImg-size);
}

.mainImg{
  width: 100%;
  height: var(--mainImg-size);
  object-fit:cover;
}

</style>
