class ModelShaperBase {
    fastify

    constructor(fastify) {
        if (new.target === ModelShaperBase) {
            throw new Error("Cannot instantiate abstract class directly.");
        }
        this.fastify = fastify;
    }

    get single() {
        throw Error('Not implemented');
    }
}

module.exports = ModelShaperBase;