const ModelShape = require("./model-shape");
const ModelShaperBase = require("./model-shaper-base");
const { ProducerData, QuantityUnit, ProductCategory, User } = require('../models');


class ProductShaper extends ModelShaperBase {
    get single() {
        const includes = [
            {
                model: ProducerData,
                as: 'ProducerData',
                include: [
                    {
                        model: User,
                        as: 'User',
                    }
                ]
            },
            {
                model: ProductCategory,
                as: "ProductCategory",
            },
            {
                model: QuantityUnit,
                as: "QuantityUnit",
            }
        ];
        const associationSetup = async (product) => {
            const { ModelExtender } = this.fastify;
            await ModelExtender.ensureAssociationIncluded(product, 'ProducerData');
            await ModelExtender.ensureAssociationIncluded(product.ProducerData, 'User');
            await ModelExtender.ensureAssociationIncluded(product, 'ProductCategory');
            await ModelExtender.ensureAssociationIncluded(product, 'QuantityUnit');
        }
        const shaperCallback = async (product) => {
            const producerData = product.ProducerData;
            const producer = product.ProducerData.User;
            const category = product.ProductCategory;
            const quantityUnit = product.QuantityUnit;

            return {
                id: product.id,
                name: product.name,
                producer: {
                    id: producer.id,
                    name: producer.name,
                    email: producer.email,
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
                    name: quantityUnit.name,
                },
                price: product.price
            }
        };
        return new ModelShape(shaperCallback, includes, associationSetup);
    }
}

module.exports = ProductShaper;