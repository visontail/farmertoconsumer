const { User } = require("../models");
const ModelShaperBase = require("./model-shaper-base");
const ModelShape = require("./model-shape");

class UserUpgradeRequestShaper extends ModelShaperBase {
    get single() {
        const includes = [
            {
                model: User,
                as: 'User',
            }
        ];
        const associationSetup = async (userUpgradeRequest) => {
            const { ModelExtender } = this.fastify;
            await ModelExtender.ensureAssociationIncluded(userUpgradeRequest, 'User');
        }
        const shaperCallback = async (userUpgradeRequest) => {
            const user = userUpgradeRequest.User

            return {
                id: userUpgradeRequest.id,
                user: {
                    id: user.id,
                    name: user.name,
                    email: user.email
                },
                description: userUpgradeRequest.description,
                contact: userUpgradeRequest.contact,
                profileDescription: userUpgradeRequest.profileDescription,
                approved: userUpgradeRequest.approved
            }
        };
        return new ModelShape(shaperCallback, includes, associationSetup);
    }
}

module.exports = UserUpgradeRequestShaper;