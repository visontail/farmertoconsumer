module.exports = (fastify, _, next) => {
    fastify.get('/', {
        onRequest: fastify.authenticate,
        schema: {
            query: {
                type: 'object',
                properties: {
                    filter: {
                        type: 'string',
                        enum: ['with_response', 'no_response', 'approved', 'declined']
                    },
                    userId: { type: 'integer' },
                    skip: { type: 'number' },
                    take: { type: 'number' }
                }
            }
        }
    }, (req, res) => fastify.UserUpgradeRequestController.getAll(req, res));

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
    }, (req, res) => fastify.UserUpgradeRequestController.getById(req, res))

    fastify.post('/', {
        onRequest: fastify.authenticate,
        schema: {
            body: {
                type: 'object',
                required: ['description', 'contact'],
                properties: {
                    description: { type: 'string', minLength: 1 },
                    contact: { type: 'string', minLength: 1 },
                    profileDescription: { type: 'string', minLength: 1 },
                },
            }
        }
    }, (req, res) => fastify.UserUpgradeRequestController.create(req, res))

    fastify.post('/:id/reply', {
        onRequest: fastify.authenticateAdmin,
        schema: {
            body: {
                type: 'object',
                required: ['approve'],
                properties: {
                    approve: { type: 'boolean' }
                },
            }
        }
    }, (req, res) => fastify.UserUpgradeRequestController.reply(req, res))

    next();
}

module.exports.autoPrefix = '/user-upgrade-requests';