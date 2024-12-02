const { Op } = require("sequelize");
const { UserUpgradeRequest, ProducerData, User } = require("../models");
const ControllerBase = require("./controller-base");

class UserUpgradeRequestController extends ControllerBase {
    async getAll(req, res) {
        const { query } = req;
        const { UserUpgradeRequestShaper } = this.fastify;

        const actingUser = await User.findByPk(req.user.id)
        if (!actingUser.isAdmin && actingUser.id !== query.userId) {
            return res.status(401).send({ message: 'Unauthenticated' })
        }

        let whereTemp = {
            '$User.id$': query.userId,
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
            include: UserUpgradeRequestShaper.single.includes,
        }

        const total = await UserUpgradeRequest.count(config);
        const data = await UserUpgradeRequest.findAll(config);

        const userUpgradeRequests = await UserUpgradeRequestShaper.single.shapeArray(data);

        return {
            userUpgradeRequests,
            total,
            current: userUpgradeRequests.length
        }
    }

    async getById(req, res) {
        const { UserUpgradeRequestShaper } = this.fastify;

        const userUpgradeRequest = await UserUpgradeRequest.findByPk(req.params.id,
            { include: UserUpgradeRequestShaper.single.includes });
        if (!userUpgradeRequest) {
            return res.status(404)
                .send({ message: 'User upgrade request with the given id could not be found.' })
        }

        const actingUser = await User.findByPk(req.user.id)
        if (!actingUser.isAdmin && actingUser.id !== userUpgradeRequest.UserId) {
            return res.status(401).send({ message: 'Unauthenticated' })
        }

        return await UserUpgradeRequestShaper.single.shape(userUpgradeRequest);
    }

    async create(req, res) {
        const existingRequest = await UserUpgradeRequest
            .findOne({ where: { UserId: req.user.id, approved: null } })
        if (existingRequest) {
            return res.status(400)
                .send({ message: 'User has already submitted a request' })
        }

        const userUpgradeRequest = await UserUpgradeRequest.create({
            UserId: req.user.id,
            description: req.body.description,
            contact: req.body.contact,
            profileDescription: req.body.profileDescription ?? null,
            approved: null
        })

        return this.fastify.UserUpgradeRequestShaper.single.shape(userUpgradeRequest);
    }

    async reply(req, res) {
        const userUpgradeRequest = await UserUpgradeRequest
            .findByPk(req.params.id, {
                include: {
                    model: User,
                    as: 'User'
                }
            });

        if (!userUpgradeRequest) {
            return res.status(404)
                .send({ message: 'User upgrade request with the given id could not be found.' })
        }

        if (userUpgradeRequest.approved !== null) {
            return res.status(400)
                .send({ message: 'User upgrade request has already been replied to' })
        }

        if (req.body.approve && !(await userUpgradeRequest.User.getProducerData())) {
            await ProducerData.create({
                description: userUpgradeRequest.profileDescription,
                contact: userUpgradeRequest.contact,
                UserId: userUpgradeRequest.User.id
            })
        }

        await userUpgradeRequest.update({ approved: req.body.approve })

        return;
    }
}

module.exports = UserUpgradeRequestController;