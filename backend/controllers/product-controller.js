const { Product, User } = require('../models');
const { Op, where } = require('sequelize');
const ControllerBase = require('./controller-base');

class ProductController extends ControllerBase {
    async getAll(req, res) {
        const { query } = req;
        const { ProductShaper } = this.fastify;

        const where = this.fastify.ObjectSimplifier.simplify({
            name: { [Op.like]: `%${req.query.search ?? ""}%` },
            ProductCategoryId: query.categoryId,
            ProducerDataId: query.producerDataId,
            '$ProducerData.User.id$': query.producerId,
        })

        const config = {
            where,
            offset: query.skip ?? null,
            limit: query.take ?? null,
            include: ProductShaper.single.includes,
        }

        const total = await Product.count(config);
        const data = await Product.findAll(config);

        const products = await ProductShaper.single.formatArray(data);

        return {
            products,
            total,
            current: products.length
        }
    }

    async getById(req, res) {
        const { ProductShaper } = this.fastify;

        const product = await Product.findByPk(req.params.id, { include: ProductShaper.single.includes });
        if (!product) {
            res.status(404).send({ message: 'Product with the given id could not be found.' })
        }

        return await ProductShaper.single.format(product);
    }

    async create(req, res) {
        const user = await User.findByPk(req.user.id);
        const producerData = await user.getProducerData();

        const { name, categoryId, quantity, quantityUnitId, price } = req.body;

        await Product.create({
            name,
            ProductCategoryId: categoryId,
            quantity,
            QuantityUnitId: quantityUnitId,
            price,
            ProducerDataId: producerData.id,
        })
        
        return this.fastify.ProductShaper.single.format(product);
    }

    async update(req, res) {
        const { ProductShaper } = this.fastify;

        const user = await User.findByPk(req.user.id);
        const producerData = await user.getProducerData();
        const product = await Product.findByPk(req.params.id, { include: ProductShaper.single.includes });

        if (product.ProducerDataId !== producerData.id) {
            return res.status(401).send({ message: 'Unauthorized' });
        }

        const { name, categoryId, quantity, quantityUnitId, price } = req.body;

        await product.update(this.fastify.ObjectSimplifier.simplify({
            name,
            ProductCategoryId: categoryId,
            quantity,
            QuantityUnitId: quantityUnitId,
            price,
            ProducerDataId: producerData.id,
        }));

        return ProductShaper.single.format(product);
    }
}

module.exports = ProductController;