// import "./assets/main.css";

import { createApp } from "vue";
import { createPinia } from "pinia";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

import App from "./App.vue";
import router from "./router";

import InfiniteLoading from "v3-infinite-loading";
import "v3-infinite-loading/lib/style.css";

import { QuillEditor } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.core.css";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import "@vueup/vue-quill/dist/vue-quill.bubble.css";


const app = createApp(App);
const pinia = createPinia();

pinia.use(piniaPluginPersistedstate);

app.use(pinia);
// app.use(createPinia().use(piniaPluginPersistedstate));
app.use(router);

app.component("infinite-loading", InfiniteLoading);
app.component("QuillEditor", QuillEditor);

router.isReady().then(() => {
  app.mount("#app");
});
