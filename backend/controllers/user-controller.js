const { User, ProducerData } = require('../models');

class UserController {
    #fastify;

    constructor(fastify) {
        this.#fastify = fastify;
    }

    async getUserById(req, res) {
        
    }
}

module.exports = UserController;