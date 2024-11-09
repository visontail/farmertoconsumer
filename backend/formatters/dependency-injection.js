const OrderShaper = require("./order-shaper");
const ProductShaper = require("./product-shaper");

const injectShapers = (fastify) => {
    fastify.decorate('ProductShaper', new ProductShaper(fastify));
    fastify.decorate('OrderShaper', new OrderShaper(fastify));
}

module.exports = injectShapers;