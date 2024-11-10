const ModelShape = require("./model-shape");
const ModelShaperBase = require("./model-shaper-base");

class CategoryShaper extends ModelShaperBase {
    get single() {
        return new ModelShape((category) => ({
            id: category.id,
            name: category.name
        }));
    }
}

module.exports = CategoryShaper;