'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ProducerData extends Model {
    static associate(models) {
      this.belongsTo(models.User, { as: "User", foreignKey: "UserId" });
      this.hasMany(models.Product, { as: "Products", foreignKey: "ProducerDataId" });
    }
  }
  ProducerData.init({
    description: DataTypes.STRING,
    contact: DataTypes.STRING,
    UserId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'ProducerData',
  });
  return ProducerData;
};