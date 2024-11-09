'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Order extends Model {
    static associate(models) {
      this.belongsTo(models.QuantityUnit, { as: "QuantityUnit", foreignKey: "QuantityUnitId"});
      this.belongsTo(models.Product, { as: "Product", foreignKey: "ProductId"});
      this.belongsTo(models.User, { as: "User", foreignKey: "UserId"});
    }
  }
  Order.init({
    price: DataTypes.NUMBER,
    quantity: DataTypes.NUMBER,
    approved: DataTypes.BOOLEAN,
    QuantityUnitId: DataTypes.INTEGER,
    ProductId: DataTypes.INTEGER,
    UserId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'Order',
  });
  return Order;
};