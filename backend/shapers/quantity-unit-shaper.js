const ModelShape = require("./model-shape");
const ModelShaperBase = require("./model-shaper-base");

class QuantityUnitShaper extends ModelShaperBase {
    get single() {
        return new ModelShape((quantityUnit) => ({
            id: quantityUnit.id,
            name: quantityUnit.name
        }));
    }
}

module.exports = QuantityUnitShaper;