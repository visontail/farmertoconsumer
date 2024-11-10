const { QuantityUnit } = require("../models");
const ControllerBase = require("./controller-base");

class QuantityUnitController extends ControllerBase {
    async getAll(req, res) {
        const config = {
            offset: req.query.skip ?? null,
            limit: req.query.take ?? null,
            include: this.fastify.QuantityUnitShaper.includes
        }

        const total = await QuantityUnit.count(config);
        const data = await QuantityUnit.findAll(config);

        const quantityUnits = await this.fastify.QuantityUnitShaper.single.shapeArray(data);

        return {
            quantityUnits,
            total,
            current: quantityUnits.length
        };
    }
}

module.exports = QuantityUnitController;