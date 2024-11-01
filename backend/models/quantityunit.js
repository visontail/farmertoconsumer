'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class QuantityUnit extends Model {
    static associate(models) {
      this.hasMany(models.Product, { as: "Products", foreignKey: "QuantityUnitId" });
      this.hasMany(models.Order, { as: "Orders", foreignKey: "QuantityUnitId" });
    }
  }
  QuantityUnit.init({
    name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'QuantityUnit',
  });
  return QuantityUnit;
};