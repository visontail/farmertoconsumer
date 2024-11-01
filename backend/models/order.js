'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Order extends Model {
    static associate(models) {
      this.belongsTo(models.QuantityUnit, { as: "QuantityUnit", foreignKey: "QuantityUnitId"});
      this.belongsTo(models.Product, { as: "Product", foreignKey: "ProductId"});
    }
  }
  Order.init({
    price: DataTypes.NUMBER,
    quantity: DataTypes.NUMBER,
    approved: DataTypes.BOOLEAN,
    QuantityUnitId: DataTypes.INTEGER,
    ProductId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'Order',
  });
  return Order;
};