'use strict';
const { faker } = require('@faker-js/faker')
const {
  User,
  ProducerData,
  UserUpgradeRequest,
  ProductCategory,
  QuantityUnit,
  Product,
  Order,
} = require('./../models')
const bcrypt = require('bcrypt')

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    const capitalize = str => str.length > 0 ? str.charAt(0).toUpperCase() + str.slice(1) : "";
    const password = await bcrypt.hash("password123", 10)

    console.log("Seeding customers")
    const customers = [];
    for (let i = 0; i < 5; i++) {
      customers.push(await User.create({
        email: `customer${i}@elte.hu`,
        name: faker.person.fullName(),
        password
      }))
    }

    console.log("Seeding producers")
    const producers = [];
    for (let i = 0; i < 5; i++) {
      const producer = await User.create({
        email: `producer${i}@elte.hu`,
        name: faker.person.fullName(),
        password
      });
      await UserUpgradeRequest.create({
        UserId: producer.id,
        description: faker.lorem.paragraph(),
        approved: true,
      });
      await ProducerData.create({
        UserId: producer.id,
        description: faker.lorem.paragraph(),
      });
      producers.push(producer);
    }


    console.log("Seeding quantity units");
    const quantityUnits = [];
    for (const name of ["kg", "pc", "bag", "tray"]) {
      quantityUnits.push(await QuantityUnit.create({ name }));
    }
  
    console.log("Seeding product categories");
    const productCategories = [];
    for (const name of ["apple", "peach", "melon", "wheat", "potato", "carrot"]) {
      productCategories.push(await ProductCategory.create({ name }));
    }
    
    console.log("Seeding products")
    const products = [];
    for (const producer of producers) {
      const ProducerDataId = (await producer.getProducerData()).id;
      for (const category of faker.helpers.arrayElements(productCategories, { min: 1, max: 4 })) {
        products.push(await Product.create({
          name: `${capitalize(faker.lorem.word())} ${capitalize(category.name)}`,
          quantity: faker.helpers.rangeToNumber({ min: 5, max: 40 }),
          price: faker.helpers.rangeToNumber({ min: 300, max: 2000 }),
          ProducerDataId,
          QuantityUnitId: faker.helpers.arrayElement(quantityUnits).id,
          ProductCategoryId: category.id,
        }))
      }
    };

    console.log("Seeding orders")
    const orders = [];
    for (const customer of customers) {
      for (const product of faker.helpers.arrayElements(products, { min: 0, max: 3 })) {
        orders.push(await Order.create({
          approved: faker.helpers.arrayElement([true, false, null]),
          quantity: faker.helpers.rangeToNumber({ min: 1, max: 20 }),
          price: product.price,
          QuantityUnitId: product.QuantityUnitId,
          ProductId: product.id,
          UserId: customer.id
        }));
      }
    }
  },

  async down(queryInterface, Sequelize) { }
};
