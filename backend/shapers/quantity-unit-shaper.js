const ModelShaperBase = require("./model-shaper-base");

class QuantityUnitShaper extends ModelShaperBase {
    get single() {
        throw Error('Not implemented'); // TODO
    }
}

module.exports = QuantityUnitShaper;