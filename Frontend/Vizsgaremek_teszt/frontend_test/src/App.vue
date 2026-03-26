<template>
  <Navbar />

  <main>
    <router-view></router-view>
  </main>
</template>

<script>
import Navbar from './components/Navbar.vue'

export default {
  name: 'App',
  components: {
    Navbar
  }
}
</script>

<style>
/* Alapértelmezett háttérszín a weblapnak */
body {
  background-color: #fafafa;
}
</style>