const { authenticate, authenticateProducer, authenticateAdmin } = require("./auth");

const decorateMiddlewares = (fastify) => {
    fastify.decorate("authenticate", authenticate);
    fastify.decorate("authenticateProducer", authenticateProducer);
    fastify.decorate("authenticateAdmin", authenticateAdmin);
}

module.exports = decorateMiddlewares;