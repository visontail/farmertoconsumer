# Direct farmer to customer market backend

- [Setup](#setup)
- [Sequelize](#sequelize)
    - [Creating models](#creating-models)
    - [Migrating and seeding the database](#seeding-the-database)
- [Endpoints](#endpoints)
    - [Routes](#routes)
    - [Middlewares](#middlewares)
    - [Validation](#validation)
- [Useful tools](#useful-tools)

## Setup

Create a copy from the `.env.example` file and rename it to `env.`. For development purposes you can leave the values unchanged.

Run the following commands

```bash
npm i # installing node modules
npm run db-reset # initializing an empty db.sqlite file
```

Everything is set up. To start the application in development mode (changes in source code are detected **automatically and the server restarts itself**), run

```bash
npm run dev
```

_Note: `npm run [command]` commands are defined in `package.json` under `scripts`_

## Sequelize

[Sequelize](https://sequelize.org/) is an ORM for database management systems. For simplicity, behind the abstraction we'll use SQLite database. Sequelize will mainly help us to create **models**, **relations**, **seeders** and to run **queries** and **mutations**. 

The functionalities we definitely or probably use will be discussed in this short README, but for details it is useful to check the [docs](https://sequelize.org/docs/v6/).

### Creating models

For creating models, you can use the `npx sequelize model:generate` command provided by the Sequelize CLI. For example:

```bash
npx sequelize model:generate --name Task --attributes title:string,priority:number,deadline:Date

# Note that no ' or " is used when providing name and attributes
```

The command above obviously creates the following model:
```bash
Task
----------------
title: string
priority: number
deadline: Date
```

2 new files are generated with some code, `models/task.js` and `migrations/[datetime]-create-task.js`. Keeping it simple, the migration file contains information that is relevant to the database, the model file is relevant from the point of 

- sequelize command
- modify migration
- setup associations

### Migrating and seeding the database

## Endpoints

### Routes

### Middlewares

### Validation

## Useful tools

- VS extension: **SQLite Viewer** (publisher: Florian Klampfer)
- Chrome extension: **Firecamp** for HTTP requests