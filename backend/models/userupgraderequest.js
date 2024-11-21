'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class UserUpgradeRequest extends Model {
    static associate(models) {
      this.belongsTo(models.User, { as: "User", foreignKey: "UserId" });
    }
  }
  UserUpgradeRequest.init({
    description: DataTypes.STRING,
    contact: DataTypes.STRING,
    profileDescription: DataTypes.STRING,
    approved: DataTypes.BOOLEAN,
    UserId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'UserUpgradeRequest',
  });
  return UserUpgradeRequest;
};