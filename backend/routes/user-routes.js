module.exports = (fastify, _, next) => {
    fastify.get('/:id', {
        schema: {
            params: {
                type: 'object',
                properties: {
                    id: { type: 'integer' }
                }
            }
        }
    }, (req, res) => fastify.UserController.getById(req, res))

    fastify.get('/:id/producerData', {
        schema: {
            params: {
                type: 'object',
                properties: {
                    id: { type: 'integer' }
                }
            }
        }
    }, (req, res) => fastify.UserController.getProducerDataByUserId(req, res))

    fastify.patch('/:id/producerData', {
        onRequest: fastify.authenticate,
        schema: {
            params: {
                type: 'object',
                properties: {
                    id: { type: 'integer' }
                }
            },
            body: {
                type: 'object',
                properties: {
                    description: { type: 'string', minLength: 1 },
                    contact: { type: 'string', minLength: 1 }
                }
            }
        }
    }, (req, res) => fastify.UserController.updateProducerDataByUserId(req, res))

    next();
}

module.exports.autoPrefix = '/users';