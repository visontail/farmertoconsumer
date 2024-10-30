'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class ProducerData extends Model {
    static associate(models) {
      this.belongsTo(models.User);
      this.hasMany(models.Product);
    }
  }
  ProducerData.init({
    description: DataTypes.STRING,
    UserId: DataTypes.INTEGER,
  }, {
    sequelize,
    modelName: 'ProducerData',
  });
  return ProducerData;
};