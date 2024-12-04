'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Products', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        allowNull: false,
        type: Sequelize.STRING
      },
      quantity: {
        allowNull: false,
        type: Sequelize.NUMBER
      },
      price: {
        allowNull: false,
        type: Sequelize.NUMBER
      },
      description: {
        allowNull: false,
        type: Sequelize.STRING
      },
      ProducerDataId: {
        allowNull: false,
        type: Sequelize.NUMBER
      },
      ProductCategoryId: {
        allowNull: false,
        type: Sequelize.NUMBER
      },
      QuantityUnitId: {
        allowNull: false,
        type: Sequelize.NUMBER
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Products');
  }
};