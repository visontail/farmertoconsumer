'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class QuantityUnit extends Model {
    static associate(models) {
      this.hasMany(models.Product);
      this.hasMany(models.Order);
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