'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ProductCategory extends Model {
    static associate(models) {
      this.hasMany(models.Product)
    }
  }
  ProductCategory.init({
    name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'ProductCategory',
  });
  return ProductCategory;
};