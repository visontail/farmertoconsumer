'use strict';
const { faker } = require('@faker-js/faker')
const { User, ProducerData } = require('./../models')
const bcrypt = require('bcrypt')

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    const customers = [];
    const producers = [];

    const password = await bcrypt.hash("password123", 10)

    for (let i = 0; i < 10; i++) {
      customers.push(await User.create({
        email: `customer${i}@elte.hu`,
        name: faker.person.fullName(),
        password
      }));
    }

    for (let i = 0; i < 10; i++) {
      const producer = await User.create({
        email: `producer${i}@elte.hu`,
        name: faker.person.fullName(),
        password
      })
      await ProducerData.create({
        UserId: producer.id,
        description: faker.lorem.paragraph(),
      })
    }
  },

  async down(queryInterface, Sequelize) { }
};
