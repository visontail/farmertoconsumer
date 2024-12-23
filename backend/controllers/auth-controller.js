const { User } = require('../models');
const bcrypt = require('bcrypt');
const ControllerBase = require('./controller-base');

class AuthController extends ControllerBase {
    async register(req, res) {
        if (req.body.password !== req.body.confirmPassword) {
            return res.status(400).send({ message: "Passwords do not match" })
        }
        if (await User.findOne({ where: { email: req.body.email } })) {
            return res.status(409).send({ message: "Email address is already in use" })
        }

        const { email, name } = req.body;
        const password = await bcrypt.hash(req.body.password, 10)

        const { id } = await User.create({ email, name, password })
        const token = this.fastify.jwt.sign({ id });

        return res.status(200).send({ id, token });
    }

    async login(req, res) {
        const user = await User.findOne({ where: { email: req.body.email } });
        if (!user || !await bcrypt.compare(req.body.password, user.password)) {
            return res.status(401).send({ message: 'Invalid credentials.' });
        }
        const token = this.fastify.jwt.sign({ id: user.id });
        return res.send({ token });
    }

    async profile(req, res) {
        const user = await User.findByPk(req.user.id);

        return await this.fastify.UserShaper.profile.shape(user)
    }
}

module.exports = AuthController;