import { createApp } from 'vue'
import App from './App.vue'
import router from './router' // 1. Beimportáljuk a routert, amit az előbb megírtunk

// Bootstrap CSS és JS
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap/dist/js/bootstrap.bundle.min.js'

const app = createApp(App)

app.use(router) // 2. Megmondjuk a Vue alkalmazásnak, hogy használja a routert
app.mount('#app')