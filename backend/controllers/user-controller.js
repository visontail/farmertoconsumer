const { User } = require('../models');
const ControllerBase = require('./controller-base');

class UserController extends ControllerBase {
    async getById(req, res) {
        const user = await this.#getUserByIdStrict(req.params.id, res);

        return await this.fastify.UserShaper.single.shape(user)
    }

    async getProducerDataByUserId(req, res) {
        const user = await this.#getUserByIdStrict(req.params.id, res);
        const producerData = await this.#getProducerDataStrict(user, res);

        return await this.fastify.ProducerDataShaper.single.shape(producerData);
    }

    async updateProducerDataByUserId(req, res) {
        const user = await this.#getUserByIdStrict(req.params.id, res);
        if (user.id !== req.user.id) {
            return res.status(401).send({ message: 'Unauthenticated' })
        }
        
        const producerData = await this.#getProducerDataStrict(user, res);

        await producerData.update(this.fastify.ObjectSimplifier.simplify({
            description: req.body.description,
            contact: req.body.contact
        }))

        return await this.fastify.ProducerDataShaper.single.shape(producerData);

    }

    async #getUserByIdStrict(id, res) {
        const user = await User.findByPk(id);
        if (!user) {
            return res.status(404)
                .send({ message: "User with the given id could not be found." })
        }
        return user;
    }

    async #getProducerDataStrict(user, res) {
        await user.getProducerData();
        const producerData = await user.getProducerData();
        if (!producerData) {
            console.log("joh")
            return res.status(404)
                .send({ message: "Producer data could not be found." });
        }
        return producerData;
    }
}

module.exports = UserController;