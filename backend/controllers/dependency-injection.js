const AuthController = require("./auth-controller");
const CategoryController = require("./category-controller");
const OrderController = require("./order-controller");
const ProductController = require("./product-controller");
const QuantityUnitController = require("./quantity-unit-controller");
const UserController = require("./user-controller");
const UserUpgradeRequestController = require("./user-upgrade-request-controller");

const injectControllers = (fastify) => {
    fastify.decorate('AuthController', new AuthController(fastify));
    fastify.decorate('ProductController', new ProductController(fastify));
    fastify.decorate('OrderController', new OrderController(fastify));
    fastify.decorate('UserController', new UserController(fastify));
    fastify.decorate('CategoryController', new CategoryController(fastify));
    fastify.decorate('QuantityUnitController', new QuantityUnitController(fastify));
    fastify.decorate('UserUpgradeRequestController', new UserUpgradeRequestController(fastify));
}

module.exports = injectControllers;