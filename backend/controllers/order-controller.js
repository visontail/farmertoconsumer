const { User, Product, ProducerData, Order } = require('../models');
const { Op, where } = require('sequelize');
const ControllerBase = require('./controller-base');

class OrderController extends ControllerBase {
    async getAll(req, res) {
        const { query } = req;
        const { OrderShaper } = this.fastify;

        if (req.user.id !== query.userId) {
            return res.status(404).send({ message: 'Unauthorized' })
        }

        let whereTemp = {
            [`${query.userType === 'customer'
                ? '$User.id$'
                : '$Product.ProducerData.User.id$'}`]
                : query.userId,
        }

        if (query.filter) {
            let condition;
            switch (query.filter) {
                case 'with_response':
                    condition = { [Op.not]: null }
                    break;
                case 'no_response':
                    condition = { [Op.eq]: null };
                    break;
                case 'approved':
                    condition = { [Op.eq]: true };
                    break;
                case 'declined':
                    condition = { [Op.eq]: false };
                    break;
            }
            if (condition) {
                whereTemp = {
                    approved: condition,
                    ...whereTemp
                }
            }
        }

        const where = this.fastify.ObjectSimplifier.simplify(whereTemp)

        const config = {
            where,
            offset: query.skip ?? null,
            limit: query.take ?? null,
            include: OrderShaper.single.includes,
        }

        const total = await Order.count(config);
        const data = await Order.findAll(config);

        const orders = await OrderShaper.single.shapeArray(data);

        return {
            orders,
            total,
            current: orders.length
        }
    }

    async getById(req, res) {
        const { OrderShaper, ModelExtender } = this.fastify;

        const order = await Order.findByPk(req.params.id, { include: OrderShaper.single.includes });
        if (!order) {
            return res.status(404).send({ message: 'Order with the given id could not be found.' })
        }

        await ModelExtender.ensureAssociationIncluded(order, 'User');
        await ModelExtender.ensureAssociationIncluded(order, 'Product');
        await ModelExtender.ensureAssociationIncluded(order.Product, 'ProducerData');
        await ModelExtender.ensureAssociationIncluded(order.Product.ProducerData, 'User');

        if (order.User.id !== req.user.id && order.Product.ProducerData.User.id !== req.user.id) {
            return res.status(401).send({ message: 'Unauthorized' })
        }

        return await OrderShaper.single.shape(order);
    }

    async create(req, res) {
        const product = await Product.findByPk(req.body.productId);
        if (!product) {
            return res.status(404).send({ message: 'Product with the given id could not be found.' })
        }

        if (product.quantity < req.body.quantity) {
            return res.status(400).send({ message: 'Requested quantity can\'t be higher than the available one.' });
        }

        const user = await User.findByPk(req.user.id);

        const order = await Order.create({
            price: product.price,
            quantity: req.body.quantity,
            approved: null,
            QuantityUnitId: product.QuantityUnitId,
            ProductId: product.id,
            UserId: user.id,
        })

        const newQuantity = product.quantity - req.body.quantity;

        await product.update({
            quantity: newQuantity,
        });

        return this.fastify.OrderShaper.single.shape(order);
    }

    async reply(req, res) {
        const order = await Order.findByPk(req.params.id, {
            include: [
                {
                    model: Product,
                    as: 'Product',
                    include: {
                        model: ProducerData,
                        as: 'ProducerData',
                        include: [
                            {
                                model: User,
                                as: 'User',
                            }
                        ]
                    }
                }
            ]
        });

        if (!order) {
            return res.status(404).send({ message: 'Order with the given id could not be found.' })
        }

        if (order.Product.ProducerData.User.id !== req.user.id) {
            return res.status(401).send({ message: 'Unauthorized' })
        }

        if (order.approved !== null) {
            return res.status(400).send({ message: 'Order has already been replied to.' })
        }

        if (!req.body.approve) {
            const newQuantity = order.Product.quantity + order.quantity;

            await order.Product.update({
                quantity: newQuantity,
            });
        }

        await order.update({ approved: req.body.approve })

        return;
    }
}

module.exports = OrderController;