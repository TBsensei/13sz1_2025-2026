import './style.css'
import {renderHome} from "./pages/home.js";
import {renderList} from "./moduls/renderList.js";

const app = document.querySelector('#app')
app.appendChild(renderHome())

// Dinamikus import pelda

document.querySelector('#dynamicBtn').addEventListener('click', async ()=>{
    const {getPosts} = await import('./moduls/apiClient.js')
    const posts = await getPosts()
    const titles = posts.map(p => p.title)
    app.appendChild(renderList(titles))
    const bodies = posts.map(p => p.body)
    app.appendChild(renderList(bodies))
})

// TLA import: ez csak egy demo

document.getElementById('tlaBtn').addEventListener('click', async ()=>{
    const mod = await import('./moduls/apiClient.js')
    console.log('Mock config: ', mod.config)
    alert("Nézd meg a konzolt!")
})