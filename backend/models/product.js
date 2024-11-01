'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Product extends Model {
    static associate(models) {
      this.belongsTo(models.ProducerData, { as: "ProducerData", foreignKey: "ProducerDataId"});
      this.belongsTo(models.ProductCategory, { as: "ProductCategory", foreignKey: "ProductCategoryId"});
      this.belongsTo(models.QuantityUnit, { as: "QuantityUnit", foreignKey: "QuantityUnitId"});
      this.hasMany(models.Order, { as: "Orders", foreignKey: "ProductId"});
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