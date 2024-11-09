const { User, ProducerData } = require('../models');

class UserController {
    #fastify;

    constructor(fastify) {
        this.#fastify = fastify;
    }

    async getById(req, res) {
        const user = await User.findByPk(req.params.id);
        if (!user) {
            return res.status(404)
                .send({ message: "User with the given id could not be found." })
        }

        const producerData = await user.getProducerData();
        const { id, email, name } = user;

        return {
            id,
            email,
            name,
            producerData: producerData ? {
                id: producerData.id,
                description: producerData.description
            } : null
        }
    }

    async getProducerDataByUserId(req, res) {
        const { producerData } = await this.getById(req, res);
        if (!producerData) {
            return res.status(404)
                .send({ message: "Producer data could not be found." });
        }

        const { id, description } = producerData;

        return {
            id,
            description
        }
    }
}

module.exports = UserController;