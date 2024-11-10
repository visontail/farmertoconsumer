module.exports = (fastify, _, next) => {
    fastify.get('/', {
        schema: {
            query: {
                type: 'object',
                properties: {
                    skip: { type: 'number' },
                    take: { type: 'number' }
                }
            }
        }
    }, (req, res) => fastify.QuantityUnitController.getAll(req, res));

    next();
}

module.exports.autoPrefix = '/quantity-units';