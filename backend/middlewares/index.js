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
    const user = await authenticate(req, res);
    if (!user.isProducer) {
        res.status(401).send({ message: "Unauthorized" });
    }
}

module.exports = { authenticate, authenticateProducer }