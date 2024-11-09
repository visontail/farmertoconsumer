const ModelShaperBase = require("./model-shaper-base");
const ModelShape = require("./model-shape");
const { Product, ProducerData, QuantityUnit, ProductCategory, User } = require('../models');
const { Model } = require("sequelize");
const ModelExtender = require("../helpers/model-extender");

class OrderShaper extends ModelShaperBase {
    get single() {
        const includes = [
            {
                model: User,
                as: 'User',
            },
            {
                model: Product,
                as: 'Product',
                include: [
                    {
                        model: ProducerData,
                        as: 'ProducerData',
                        include: [
                            {
                                model: User,
                                as: 'User',
                            },
                        ]
                    },
                    {
                        model: ProductCategory,
                        as: 'ProductCategory',
                    },
                    {
                        model: QuantityUnit,
                        as: 'QuantityUnit',
                    }
                ],
            },
        ];
        const associationSetup = async (order) => {
            const { ModelExtender } = this.fastify;
            await ModelExtender.ensureAssociationIncluded(order, 'User');
            await ModelExtender.ensureAssociationIncluded(order, 'Product');
            await ModelExtender.ensureAssociationIncluded(order.Product, 'ProducerData');
            await ModelExtender.ensureAssociationIncluded(order.Product.ProducerData, 'User');
            await ModelExtender.ensureAssociationIncluded(order.Product, 'ProductCategory');
            await ModelExtender.ensureAssociationIncluded(order.Product, 'QuantityUnit');
        }
        const shaperCallback = async (order) => {
            const product = order.Product;
            const customer = order.User;
            const producerData = product.ProducerData;
            const producer = producerData.User;
            const category = product.ProductCategory;
            const quantityUnit = product.QuantityUnit;
            return {
                id: order.id,
                customer: {
                    id: customer.id,
                    name: customer.name,
                    email: customer.email,
                },
                product: {
                    id: product.id,
                    name: product.name,
                    producer: {
                        id: producer.id,
                        name: producer.id,
                        email: producer.id,
                        producerData: {
                            id: producerData.id,
                            description: producerData.description,
                        }
                    },
                    category: {
                        id: category.id,
                        name: category.name,
                    },
                    quantity: product.quantity,
                    quantityUnit: {
                        id: quantityUnit.id,
                        name: quantityUnit.name
                    },
                    price: product.price
                },
                quantity: order.quantity,
                quantityUnit: {
                    id: quantityUnit.id,
                    name: quantityUnit.name
                },
                price: product.price,
                approved: order.approved
            }
        };
        return new ModelShape(shaperCallback, includes, associationSetup);
    }
}

module.exports = OrderShaper;