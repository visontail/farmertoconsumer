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
  }
  User.init({
    name: DataTypes.STRING,
    email: DataTypes.STRING,
    password: DataTypes.STRING,
    isAdmin: DataTypes.BOOLEAN,
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};