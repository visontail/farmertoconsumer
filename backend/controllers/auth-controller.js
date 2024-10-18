const AuthService = require("../services/auth-service");

module.exports = (fastify, _, next) => {
    const authService = new AuthService(fastify)

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
    }, (req, res) => authService.register(req, res));

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
    }, (req, res) => authService.login(req, res))

    next();
}

module.exports.autoPrefix = '/auth';