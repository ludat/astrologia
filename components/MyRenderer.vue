<script setup lang="ts">
import { TresCanvas } from '@tresjs/core';
import SistemaSolar from './SistemaSolar.vue';
</script>

<template>
  <TresCanvas
    clear-color="#000"
  >
    <SistemaSolar/>
  </TresCanvas>
</template>

<style>
#canvas {
  height: 100%;
  width: 100%;
}
</style>
