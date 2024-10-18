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
npm run db-clear # initializing an empty db.sqlite file
```

Everything is set up. To start the application in development mode (changes in source code are detected **automatically and the server restarts itself**), run

```bash
npm run dev
```

_Note: `npm run [command]` commands are defined in `package.json` under `scripts`_

## _(Will finish and upload the rest)_


## Useful tools

- VS extension: **SQLite Viewer** (publisher: Florian Klampfer)
- Chrome extension: **Firecamp** for HTTP requests