class ModelExtender {
    async ensureAssociationIncluded(model, propertyName) {
        if (!model[propertyName]) {
            const value = await model[`get${propertyName}`]()
            model[propertyName] = value;
        }
        return model;
    }
};

module.exports = ModelExtender