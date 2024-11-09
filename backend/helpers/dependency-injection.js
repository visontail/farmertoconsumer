const ObjectSimplifier = require("./object-simplifier");
const ModelExtender = require("./model-extender");

const injectHelpers = (fastify) => {
    fastify.decorate('ModelExtender', new ModelExtender());
    fastify.decorate('ObjectSimplifier', new ObjectSimplifier());
}

module.exports = injectHelpers;