module.exports = (fastify, _, next) => {
    fastify.get('/', {
        schema: {
            query: {
                type: 'object',
                properties: {
                    search: { type: 'string' },
                    categoryId: { type: 'number' },
                    producerId: { type: 'number' },
                    producerDataId: { type: 'number' },
                    skip: { type: 'number' },
                    take: { type: 'number' }
                }
            }
        }
    }, (req, res) => fastify.ProductController.getAll(req, res));

    fastify.get('/:id', {
        schema: {
            params: {
                type: 'object',
                properties: {
                    id: { type: 'integer' }
                }
            }
        }
    }, (req, res) => fastify.ProductController.getById(req, res))

    fastify.post('/', {
        onRequest: fastify.authenticateProducer,
        schema: {
            body: {
                type: 'object',
                required: ['name', 'categoryId', 'quantity', 'quantityUnitId', 'price'],
                properties: {
                    name: { type: 'string' },
                    categoryId: { type: 'integer' },
                    quantity: { type: 'integer' },
                    quantityUnitId: { type: 'integer' },
                    price: { type: 'integer' },
                },
            }
        }
    }, (req, res) => fastify.ProductController.create(req, res))

    fastify.patch('/:id', {
        onRequest: fastify.authenticateProducer,
        schema: {
            body: {
                type: 'object',
                properties: {
                    name: { type: 'string' },
                    categoryId: { type: 'integer' },
                    quantity: { type: 'integer' },
                    quantityUnitId: { type: 'integer' },
                    price: { type: 'integer' },
                },
            }
        }
    }, (req, res) => fastify.ProductController.update(req, res))

    next();
}

module.exports.autoPrefix = '/products';