const UserController = require("../controllers/user-controller");

module.exports = (fastify, _, next) => {
    const userController = new UserController(fastify)

    fastify.get('/users/:id', {
        onRequest: fastify.authenticate,
        schema: {
            params: {
                type: 'query',
                properties: {
                    id: { type: 'integer' }
                }
            }
        }
    }, (req, res) => userController.getUserById(req, res))

    next();
}

module.exports.autoPrefix = '/users';