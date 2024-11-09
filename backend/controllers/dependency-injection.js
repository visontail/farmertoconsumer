const AuthController = require("./auth-controller");
const OrderController = require("./order-controller");
const ProductController = require("./product-controller");
const UserController = require("./user-controller");

const injectControllers = (fastify) => {
    fastify.decorate('AuthController', new AuthController(fastify));
    fastify.decorate('ProductController', new ProductController(fastify));
    fastify.decorate('OrderController', new OrderController(fastify));
    fastify.decorate('UserController', new UserController(fastify));
}

module.exports = injectControllers;