export default function renderCard({title, body}){
    const el = document.createElement('article')
    el.className = 'card'
    el.innerHTML = `<h3>${title}</h3><p>${body}</p>`
    return el
}