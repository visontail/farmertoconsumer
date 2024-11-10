const CategoryShaper = require("./category-shaper");
const OrderShaper = require("./order-shaper");
const ProducerDataShaper = require("./producer-data-shaper");
const ProductShaper = require("./product-shaper");
const QuantityUnitShaper = require("./quantity-unit-shaper");
const UserShaper = require("./user-shaper");
const UserUpgradeRequestShaper = require("./user-upgrade-request-shaper");

const injectShapers = (fastify) => {
    fastify.decorate('ProductShaper', new ProductShaper(fastify));
    fastify.decorate('OrderShaper', new OrderShaper(fastify));
    fastify.decorate('CategoryShaper', new CategoryShaper(fastify));
    fastify.decorate('QuantityUnitShaper', new QuantityUnitShaper(fastify));    
    fastify.decorate('UserUpgradeRequestShaper', new UserUpgradeRequestShaper(fastify));
    fastify.decorate('ProducerDataShaper', new ProducerDataShaper(fastify));
    fastify.decorate('UserShaper', new UserShaper(fastify));

}

module.exports = injectShapers;