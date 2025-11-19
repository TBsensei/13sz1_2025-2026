const DEFAULT_BASE_URL = "http://localhost:3000"
export default class ApiService {
    constructor(baseURL = DEFAULT_BASE_URL) {
        this.base = baseURL.replace(/\/+$/, "");
    }

    setBaseUrl(u) {
        this.base = u.replace(/\/+$/, "");
    }

    async list({q = "", sort = "createdAt", dir = "desc"} = {}) {
        const p = new URLSearchParams({q, sort, dir});
        const res = await fetch(`${this.base}/api/links?${p.toString()}`)
        if (!res.ok) throw new Error("Nem sikerült lekérni a linkeket.")
        return await res.json();
    }

    async create({target, slug}) {
        const res = await fetch(`${this.base}/api/links`, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({target, slug})
        });
        const data = await res.json().catch(()=>({}));
        if(!res.ok) throw new Error(data.error || "Nem sikerült létrehozni.")
        return data;
    }
    async update(id, patch){
        const res = await fetch(`${this.base}/api/links/${encodeURIComponent(id)}`,{
            method: "PATCH",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(patch)
        });
        const data = await res.json().catch(()=>({}));
        if(!res.ok) throw new Error(data.error || "Nem sikerült módosítani.")
        return data;
    }
    async remove(id){
        const res = await fetch(`${this.base}/api/links/${encodeURIComponent(id)}`,{
            method: "DELETE"
        });
        if (!res.ok) {
            const err =  await res.json().catch(()=>({}));
            throw  new Error(err.error || "Nem sikerült törölni.")
        }
    }
}