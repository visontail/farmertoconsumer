'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate(models) {
      this.hasOne(models.UserUpgradeRequest, { as: "UserUpgradeRequest", foreignKey: "UserId" });
      this.hasOne(models.ProducerData, { as: "ProducerData", foreignKey: "UserId" });
      this.hasMany(models.Order, { as: "Orders", foreignKey: "UserId" })
    }

    isProducer() {
      return this.getProducerData() !== null
    }
  }
  User.init({
    name: DataTypes.STRING,
    email: DataTypes.STRING,
    password: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};