'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class UserUpgradeRequest extends Model {
    static associate(models) {
      this.belongsTo(models.User);
    }
  }
  UserUpgradeRequest.init({
    description: DataTypes.STRING,
    approved: DataTypes.BOOLEAN,
    UserId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'UserUpgradeRequest',
  });
  return UserUpgradeRequest;
};