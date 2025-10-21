import sum, {PI, circleArea} from "../moduls/math.js";
import {formatDate} from "../moduls/ui/formatDate.js";
import renderCard from "../moduls/ui/renderCard.js";

export function renderHome() {
    const container = document.createElement('section')
    const intro = document.createElement('p')
    intro.textContent = `Betöltve: ${formatDate()} - A PI értéke: ${PI}, - a két szám összege: 5+6=${sum(5 , 6)}, - A kör területe: r=3 T=${circleArea(3)}`
    container.appendChild(intro)
    container.appendChild(renderCard({
        title: 'A modulok működnek',
        body: 'Ez a kártya egy külön modul eredménye'
    }))
    return container
}
