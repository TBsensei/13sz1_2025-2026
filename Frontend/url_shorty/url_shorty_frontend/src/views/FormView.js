export default class FormView {
    constructor(formEl) {
        this.formEl = formEl;
    }

    bind(onSubmit) {
        this.formEl.addEventListener("submit", async (e) => {
            e.preventDefault();
            const target = document.getElementById("target").value.trim();
            const slug = document.getElementById('custom-slug').value.trim() || undefined
            await  onSubmit({target, slug});
            document.getElementById('target').value="";
            document.getElementById('custom-slug').value="";
        })
    }
}