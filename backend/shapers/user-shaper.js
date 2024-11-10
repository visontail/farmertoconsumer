const { ProducerData } = require("../models");
const ModelShape = require("./model-shape");
const ModelShaperBase = require("./model-shaper-base");

class UserShaper extends ModelShaperBase {
    get single() {
        const shaperCallback = (user) => {
            const producerData = user.ProducerData;

            return {
                id: user.id,
                email: user.email,
                name: user.name,
                producerData: producerData ? {
                    id: producerData.id,
                    description: producerData.description,
                } : null
            }
        };
        const includes = [
            {
                model: ProducerData,
                as: 'ProducerData'
            }
        ]
        const associationSetup = async (user) => {
            await this.fastify.ModelExtender.ensureAssociationIncluded(user, 'ProducerData');
        };
        return new ModelShape(shaperCallback, includes, associationSetup);
    }
}

module.exports = UserShaper;