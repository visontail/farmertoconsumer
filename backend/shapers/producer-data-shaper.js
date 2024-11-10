const { User } = require("../models");
const ModelShape = require("./model-shape");
const ModelShaperBase = require("./model-shaper-base");

class ProducerDataShaper extends ModelShaperBase {
    get single() {
        const shaperCallback = (producerData) => {
            const user = producerData.User;
            return {
                id: producerData.id,
                description: producerData.description,
                user: {
                    id: user.id,
                    email: user.email,
                    name: user.name
                }
            }
        };
        const includes = [
            {
                model: User,
                as: 'User'
            }
        ]
        const associationSetup = async (producerData) => {
            await this.fastify.ModelExtender.ensureAssociationIncluded(producerData, 'User');
        };
        return new ModelShape(shaperCallback, includes, associationSetup);
    }
}

module.exports = ProducerDataShaper;