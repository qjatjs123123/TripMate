<script setup>
import { defineProps } from "vue";

const props = defineProps({
  items: {
    type: Array,
    required: true,
  },
});
console.log(props.items);
</script>
<script>
import { defineComponent } from "vue";
import { Carousel, Navigation, Slide } from "vue3-carousel";

import "vue3-carousel/dist/carousel.css";

export default defineComponent({
  // eslint-disable-next-line vue/multi-word-component-names
  name: "Breakpoints",
  components: {
    Carousel,
    Slide,
    Navigation,
  },
  data: () => ({
    // carousel settings
    settings: {
      itemsToShow: 1,
      snapAlign: "center",
    },
    // breakpoints are mobile first
    // any settings not specified will fallback to the carousel settings
    breakpoints: {
      // 700px and up
      500: {
        itemsToShow: 1.5,
        snapAlign: "center",
      },
      700: {
        itemsToShow: 2,
        snapAlign: "center",
      },
      850: {
        itemsToShow: 3.5,
        snapAlign: "center",
      },
      // 1024 and up
      1024: {
        itemsToShow: 4,
        snapAlign: "start",
      },
    },
  }),
});
</script>
<template>
  <carousel v-bind="settings" :breakpoints="breakpoints">
    <Slide v-for="slide in props.items" :key="slide">
      <div class="box-inner">
        <img :src="slide.imgData" class="menu-img" />
        <div class="menu-txt">{{ slide.title }}</div>
      </div>
    </Slide>

    <template #addons>
      <navigation :class="'navi'" />
    </template>
  </carousel>
</template>

<style>
.navi {
  margin-top: calc(var(--slick-box-txt-height) * -0.5);
}
.box-inner {
  height: var(--slick-box-inner-height);
  width: 100%;
  margin: 0 var(--slick-box-padding-left);
  /* padding-right: var(--slick-box-padding-left); */
}
.menu-img {
  width: 100%;
  height: var(--slick-box-img-height);
  object-fit: cover;
}
.menu-txt {
  width: 100%;
  height: var(--slick-box-txt-height);
  text-align: center;
}
</style>
