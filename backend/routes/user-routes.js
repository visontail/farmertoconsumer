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

    next();
}

module.exports.autoPrefix = '/users';