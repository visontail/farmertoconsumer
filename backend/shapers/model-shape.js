class ModelShape {
    #includes
    #shaperCallBack
    #associationSetup

    constructor(shaperCallback, includes, associationSetup) {
        this.#includes = includes;
        this.#shaperCallBack = shaperCallback;
        this.#associationSetup = associationSetup
    }

    get includes() {
        return this.#includes;
    }

    async shape(model) {
        await this.#associationSetup(model);
        return this.#shaperCallBack(model);
    }

    async shapeArray(models) {
        const result = [];
        for (let model of models) {
            result.push(await this.shape(model));
        }
        return result;
    }
}

module.exports = ModelShape;