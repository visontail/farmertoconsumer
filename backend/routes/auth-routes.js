const AuthController = require("../controllers/auth-controller");

module.exports = (fastify, _, next) => {
    const authController = new AuthController(fastify)

    fastify.post('/register', {
        schema: {
            body: {
                type: 'object',
                required: ['email', 'name', 'password', 'confirmPassword'],
                properties: {
                    email: { type: 'string', format: 'email' },
                    name: { type: 'string', minLength: 3 },
                    password: { type: 'string', minLength: 8 },
                    confirmPassword: { type: 'string' },
                }
            }
        }
    }, (req, res) => authController.register(req, res));

    fastify.post('/login', {
        schema: {
            body: {
                type: 'object',
                required: ['email', 'password'],
                properties: {
                    email: { type: 'string', format: 'email' },
                    password: { type: 'string' }
                }
            }
        }
    }, (req, res) => authController.login(req, res))

    fastify.get('/profile', {
        onRequest: fastify.authenticate
    }, (req, res) => authController.profile(req, res))

    next();
}

module.exports.autoPrefix = '/auth';