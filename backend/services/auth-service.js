const { User } = require('../models');
const bcrypt = require('bcrypt');

class AuthService {
    #fastify;

    constructor(fastify) {
        this.#fastify = fastify;
    }

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

        res.status(200).send({ id })
    }

    async login(req, res) {
        const user = await User.findOne({ where: { email: req.body.email } });
        if (!user) {
            return res.status(404).send({ message: 'User not found.' });
        }
        const token = this.#fastify.jwt.sign({ id: user.id });
        return res.send({ token });
    }
}

module.exports = AuthService;