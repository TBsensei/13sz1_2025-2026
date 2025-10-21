const config = {baseURL: 'local-mock'}

const MOCK_POST = [
    {id: 1, title: 'Első poszt', body: 'Lorem Ipsum'},
    {id: 2, title: 'Modul JS', body: 'Exportok, importok, TLA...'},
    {id: 3, title: 'Vite dev', body: 'Webszerver host'},
    {id: 4, title: 'Dinamikus import', body: 'Kodszpliteles a gyakorlatban'},
    {id: 5, title: 'Mock backend', body: 'Demo Backend (köze sincs hozzá)'},

]

export async function getPosts(){
    await new Promise(r => setTimeout(r, 150))
    return JSON.parse(JSON.stringify(MOCK_POST))
}

export {config}
