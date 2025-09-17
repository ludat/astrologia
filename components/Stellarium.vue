<script setup lang="ts">
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'
import { computed, ref } from 'vue'

type Planet = 'Sun' | 'Mercury' | 'Moon'

const props = defineProps(['astro', 'fecha'])

const fecha = ref<string>(props.fecha)
const astro = ref<Planet>(props.astro)
const url = computed(() => {
  if (!astro.value) {
    return null;
  }
  const url = new URL(`https://stellarium-web.org/skysource/${astro.value}`);

  if (!fecha.value) {
    return null;
  }
  url.searchParams.set('date', fecha.value);
  url.searchParams.set('lat', '-34.60');
  url.searchParams.set('lng', '-58.38');
  url.searchParams.set('elev', '0');

  return url.toString();
})
</script>
<template>
  <div :style="{display: 'flex'}">
    <span><vue-date-picker v-model="fecha"></vue-date-picker></span>
    <select v-model="astro">
      <option value=""></option>
      <option value="Sun">☀️</option>
      <option value="Moon">🌘</option>
      <option value="Mercury">☿️</option>
    </select>
  </div>
  <iframe allowfullscreen v-if="url" width="100%" height="100%" :src="url"></iframe>
</template>
