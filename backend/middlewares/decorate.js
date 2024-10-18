const { authenticate } = require(".");

const decorateMiddlewares = (fastify) => {
    fastify.decorate("authenticate", authenticate);
}

module.exports = decorateMiddlewares;