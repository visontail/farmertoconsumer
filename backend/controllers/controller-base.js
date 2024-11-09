class ControllerBase {
    fastify

    constructor(fastify) {
        if (new.target === ControllerBase) {
            throw new Error("Cannot instantiate abstract class directly.");
        }
        this.fastify = fastify;
    }
}

module.exports = ControllerBase