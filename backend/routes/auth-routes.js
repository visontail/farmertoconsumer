module.exports = (fastify, _, next) => {
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
    }, (req, res) => fastify.AuthController.register(req, res));

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
    }, (req, res) => fastify.AuthController.login(req, res))

    fastify.get('/profile', {
        onRequest: fastify.authenticate
    }, (req, res) => fastify.AuthController.profile(req, res))

    next();
}

module.exports.autoPrefix = '/auth';