<script setup>
import { ref } from 'vue'
import { Camera, CameraResultType } from '@capacitor/camera'

const photoUrl = ref(null)

async function prendrePhoto() {
  const photo = await Camera.getPhoto({
    resultType: CameraResultType.Uri,
    quality: 90
  })

  photoUrl.value = photo.webPath
}
</script>

<template>
  <main>
    <h1>Mon application</h1>

    <button @click="prendrePhoto">
      📷 Prendre une photo
    </button>

    <div v-if="photoUrl">
      <h2>Ma photo</h2>

      <img :src="photoUrl" alt="Photo prise" />
    </div>
  </main>
</template>