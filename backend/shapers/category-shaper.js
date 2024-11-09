const ModelShaperBase = require("./model-shaper-base");

class CategoryShaper extends ModelShaperBase {
    get single() {
        throw Error('Not implemented'); // TODO
    }
}

module.exports = CategoryShaper;