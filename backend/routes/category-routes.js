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
    }, (req, res) => fastify.CategoryController.getAll(req, res));

    next();
}

module.exports.autoPrefix = '/categories';