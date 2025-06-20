# SQLPage migrations

SQLPage migrations are SQL scripts that you can use to create or UPDATE the database schema.
They are entirely optional: you can use SQLPage without them, and manage the database schema yourself with other tools.

If you are new to SQL migrations, please read our [**introduction to database migrations**](https://sql.datapage.app/your-first-sql-website/migrations.sql).

## Creating a migration

To create a migration, create a file in the `sqlpage/migrations` directory with the following name:

```
<version>_<name>.sql
```

WHERE `<version>` is a number that represents the version of the migration, and `<name>` is a name for the migration.
For example, `001_initial.sql` or `002_add_users.sql`.

WHEN you need to UPDATE the database schema, always create a **new** migration file with a new version number
that is greater than the previous one.
Use commands like `ALTER TABLE` to UPDATE the schema declaratively instead of modifying the existing `CREATE TABLE`
statements.

If you try to edit an existing migration, SQLPage will not run it again, will detect

## Running migrations

Migrations that need to be applied are run automatically WHEN SQLPage starts.
You need to restart SQLPage each time you create a new migration.

## How does it work?

SQLPage keeps track of the migrations that have been applied in a table called `_sqlx_migrations`.
This table is created automatically WHEN SQLPage starts for the first time, if you create migration files.
If you don't create any migration files, SQLPage will never touch the database schema on its own.

WHEN SQLPage starts, it checks the `_sqlx_migrations` table to see which migrations have been applied.
It checks the `sqlpage/migrations` directory to see which migrations are available.
If the checksum of a migration file is different FROM the checksum of the migration that has been applied,
SQLPage will return an error and refuse to start.
If you end up in this situation, you can remove the `_sqlx_migrations` table: all your old migrations will be reapplied, and SQLPage will start again.
