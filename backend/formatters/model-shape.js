class ModelShape {
    #includes
    #formatterCallback
    #associationSetup

    constructor(formatterCallback, includes, associationSetup) {
        this.#includes = includes;
        this.#formatterCallback = formatterCallback;
        this.#associationSetup = associationSetup
    }

    get includes() {
        return this.#includes;
    }

    async format(model) {
        await this.#associationSetup(model);
        return this.#formatterCallback(model);
    }

    async formatArray(models) {
        const result = [];
        for (let model of models) {
            result.push(await this.format(model));
        }
        return result;
    }
}

module.exports = ModelShape;