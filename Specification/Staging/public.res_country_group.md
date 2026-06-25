# res_country_group

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_country_group` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the management of geographical groupings of countries, often used in ERP systems to apply specific tax rules, shipping zones, or pricing policies to a collection of countries simultaneously. It acts as a reference data entity for regional configuration.

## Description
One row in this table represents a single country group entity, which serves as a logical container for multiple countries. This is a raw landing copy of the Odoo `res.country.group` model, intended for use in downstream staging or transformation pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the users table. |
| name | JSONB | false | Name of the country group | Stored as JSONB, likely for multi-language support. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; queries will need to extract the specific language key (e.g., `name->>'en_US'`) to retrieve a readable string.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag (e.g., `active`), so assume all rows are currently active unless otherwise specified by business logic.
- The `create_uid` and `write_uid` columns are nullable, which may occur if records were migrated or created via system processes without an associated user ID.