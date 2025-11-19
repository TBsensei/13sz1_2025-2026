export default class LinkModel {
    constructor(api) {
        this.api = api;
        this.items = [];
        this.filters = {q: "", sort: "createdAt", dir: "desc"};
        this.listeners = new Set();
    }

    onChange(fn) {
        this.listeners.add(fn);
    }

    offChange(fn) {
        this.listeners.delete(fn);
    }

    #emit() {
        for (const fn of this.listeners) fn(this);
    }

    async load() {
        this.items = await this.api.list(this.filters);
        this.#emit();
    }

    async create(target, slug) {
        await this.api.create({target, slug})
        await this.load();
    }

    async update(id, patch) {
        await this.api.update({id, patch});
        await this.load();
    }
    async delete(id){
        await this.api.remove(id);
        await this.load();
    }
}