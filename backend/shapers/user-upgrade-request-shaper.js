const ModelShaperBase = require("./model-shaper-base");

class UserUpgradeRequestShaper extends ModelShaperBase {
    get single() {
        throw Error('Not implemented'); // TODO
    }
}

module.exports = UserUpgradeRequestShaper;