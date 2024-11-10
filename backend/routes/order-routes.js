module.exports = (fastify, _, next) => {
    fastify.get('/', {
        onRequest: fastify.authenticate,
        schema: {
            query: {
                type: 'object',
                required: ['userId', 'userType'],
                properties: {
                    userId: { type: 'integer' },
                    userType: {
                        type: 'string',
                        enum: ['customer', 'producer']
                    },
                    filter: {
                        type: 'string',
                        enum: ['with_response', 'no_response', 'approved', 'declined']
                    },
                    skip: { type: 'number' },
                    take: { type: 'number' }
                }
            }
        }
    }, (req, res) => fastify.OrderController.getAll(req, res));

    fastify.get('/:id', {
        onRequest: fastify.authenticate,
        schema: {
            params: {
                type: 'object',
                properties: {
                    id: { type: 'integer' }
                }
            }
        }
    }, (req, res) => fastify.OrderController.getById(req, res))

    fastify.post('/', {
        onRequest: fastify.authenticate,
        schema: {
            body: {
                type: 'object',
                required: ['productId', 'quantity'],
                properties: {
                    productId: { type: 'string' },
                    quantity: { type: 'integer' },
                },
            }
        }
    }, (req, res) => fastify.OrderController.create(req, res))

    fastify.post('/:id/reply', {
        onRequest: fastify.authenticateProducer,
        schema: {
            body: {
                type: 'object',
                required: ['approve'],
                properties: {
                    approve: { type: 'boolean' }
                },
            }
        }
    }, (req, res) => fastify.OrderController.reply(req, res))

    next();
}

module.exports.autoPrefix = '/orders';