const { authenticate, authenticateProducer } = require(".");

const decorateMiddlewares = (fastify) => {
    fastify.decorate("authenticate", authenticate);
    fastify.decorate("authenticateProducer", authenticateProducer);
}

module.exports = decorateMiddlewares;