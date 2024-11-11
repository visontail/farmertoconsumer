const { User } = require('../models');

const authenticate = async (req, res) => {
    try {
        await req.jwtVerify();
        const user = await User.findByPk(req.user.id);
        if (!user) {
            throw Error('Invalid user id');
        }
        return user;
    } catch (err) {
        res.status(401).send({ message: "Unauthorized" });
    }
}

const authenticateProducer = async (req, res) => {
    await _authorize(req, res, async (user) => {
        const producerData = await user.getProducerData();
        return producerData !== null;
    })
}

const authenticateAdmin = async (req, res) => {
    await _authorize(req, res, async (user) => user.isAdmin)
}

const _authorize = async (req, res, condition) => {
    const user = await authenticate(req, res);
    if (!(await condition(user))) {
        res.status(401).send({ message: "Unauthorized" });
    }
}

module.exports = { authenticate, authenticateProducer, authenticateAdmin }