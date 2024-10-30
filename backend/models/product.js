'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Product extends Model {
    static associate(models) {
      this.belongsTo(models.ProducerData);
      this.belongsTo(models.ProductCategory);
      this.belongsTo(models.QuantityUnit);
      this.hasMany(models.Order);
    }
  }
  Product.init({
    name: DataTypes.STRING,
    quantity: DataTypes.NUMBER,
    price: DataTypes.NUMBER,
    ProducerDataId: DataTypes.INTEGER,
    ProductCategoryId: DataTypes.INTEGER,
    QuantityUnitId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'Product',
  });
  return Product;
};