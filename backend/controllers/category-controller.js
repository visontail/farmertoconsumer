const { ProductCategory } = require("../models");
const ControllerBase = require("./controller-base");

class CategoryController extends ControllerBase {
    async getAll(req, res) {
        const config = {
            offset: req.query.skip ?? null,
            limit: req.query.take ?? null,
            include: this.fastify.CategoryShaper.includes
        }

        const total = await ProductCategory.count(config);
        const data = await ProductCategory.findAll(config);

        const categories = await this.fastify.CategoryShaper.single.shapeArray(data);

        return {
            categories,
            total,
            current: categories.length
        };
    }
}

module.exports = CategoryController;