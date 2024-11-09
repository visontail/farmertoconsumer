class ModelShaperBase {
    fastify

    constructor(fastify) {
        this.fastify = fastify;
    }

    get single() {
        throw Error('Not implemented');
    }
}

module.exports = ModelShaperBase;