<script setup lang="ts">
import { OrbitControls, Sphere, PointerLockControls, Stars } from '@tresjs/cientos';
import * as THREE from 'three';
import { useLoop, useTresContext } from '@tresjs/core';
import { ref, shallowRef } from 'vue'
import { time } from 'three/tsl';

const solRef = shallowRef()
const tierraRef = shallowRef()
const mercurioRef = shallowRef()
const camaraRef = shallowRef()
const timeUnit = 200
const spaceUnit = 1
const sizeUnit = 50
const RADIO_SOL = 2.31
const RADIO_TIERRA = 0.02 * sizeUnit
const RADIO_MERCURIO = 0.02 * sizeUnit
const RADIO_ORBITA_TIERRA = 500 * spaceUnit
const RADIO_ORBITA_MERCURIO = 193.03 * spaceUnit
const PERIODO_TIERRA = 365
const PERIODO_MERCURIO = 88
const { camera, renderer, cameras } = useTresContext()
const { onBeforeRender } = useLoop()

onBeforeRender(({ delta, elapsed }) => {
  if (tierraRef.value) {
    tierraRef.value.position.x = Math.sin(elapsed / Math.PI / 2 / PERIODO_TIERRA * timeUnit) * RADIO_ORBITA_TIERRA
    tierraRef.value.position.z = Math.cos(elapsed / Math.PI / 2 / PERIODO_TIERRA * timeUnit) * RADIO_ORBITA_TIERRA
  }
  if (mercurioRef.value) {
    mercurioRef.value.position.x = Math.sin(elapsed / Math.PI / 2 / PERIODO_MERCURIO * timeUnit) * RADIO_ORBITA_MERCURIO
    mercurioRef.value.position.z = Math.cos(elapsed / Math.PI / 2 / PERIODO_MERCURIO * timeUnit) * RADIO_ORBITA_MERCURIO
  }
  // if (camaraRef.value && tierraRef.value && mercurioRef.value) {
  //   camaraRef.value.position.x = tierraRef.value.position.x
  //   camaraRef.value.position.y = tierraRef.value.position.y
  //   camaraRef.value.position.z = tierraRef.value.position.z
  //   camaraRef.value.lookAt(mercurioRef.value.position)
  // }
})
</script>

<template>
  <!-- <TresPerspectiveCamera :position="[0, 50, 0]" :arg="[140, 1, 1, 1000]" ref="camaraRef"/> -->
  <TresPerspectiveCamera
    :position="[0, 50, 0]"
    :fov="120"
    :near="0.1"
    :far="2000"
    ref="camaraRef"
  />
  <!-- <PointerLockControls /> -->
  <OrbitControls />
  <TresPointLight :arg="[0xFFFFFF, 5000]"/>
  <!-- <TresGridHelper :args="[1000, 10]" /> -->
  <TresMesh ref="solRef" :scale="RADIO_SOL">
		<TresSphereGeometry :args="[1, 64, 64]" />
    <TresMeshPhongMaterial :emissive="0xFFFF00"/>
	</TresMesh>
  <TresMesh ref="tierraRef" :scale="RADIO_TIERRA">
		<TresSphereGeometry :args="[1, 64, 64]" />
    <!-- <TresMeshPhongMaterial :emissive="0x112244" :color="0x22FFFF"/> -->
    <TresMeshBasicMaterial :color="0x22FFFF"/>
	</TresMesh>
  <TresMesh ref="mercurioRef" :scale="RADIO_MERCURIO">
		<TresSphereGeometry :args="[1, 64, 64]" />
    <!-- <TresMeshPhongMaterial :emissive="0x112244" :color="0x2233F0"/> -->
    <TresMeshBasicMaterial :color="0xFFFFFF"/>
	</TresMesh>
  <TresMesh :scale="[1,1,1]">
    <TresPlaneGeometry :arg="[100,100]"/>
    <TresMeshBasicMaterial :color="0xFFFFFF"/>
	</TresMesh>
  <Stars :radius="1300" :count="5000" :size="0.5" :depth="1" :size-attenuation="false" />
</template>
