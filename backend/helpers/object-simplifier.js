class ObjectSimplifier {
    simplify(obj, removeNulls = true) {
        return Object.fromEntries(
            Object.entries(obj)
                .filter(([_, value]) =>
                    value !== undefined &&
                    (!removeNulls || value !== null))
        );
    }
}

module.exports = ObjectSimplifier;