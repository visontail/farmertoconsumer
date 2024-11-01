const path = require('path');
const db = require('./models');
const decorateMiddlewares = require('./middlewares/decorate');
require('dotenv').config();

const fastify = require('fastify')({
    logger: { file: 'server.log' },
})

fastify.register(require('@fastify/autoload'), {
    dir: path.join(__dirname, "routes"),
})

fastify.register(require('@fastify/jwt'), {
    secret: process.env.JWT_SECRET
})

decorateMiddlewares(fastify);

const port = process.env.SERVER_PORT || 3000;
const host = process.env.SERVER_HOST || 'localhost'

fastify.listen({ port, host }, (err, addr) => {
    if (err) {
        fastify.log.error(err);
        process.exit(1);
    }
    console.log(`🚀 Server is listening on ${addr}`)
});