# decimal_precision

## Source system
This table likely originates from an Odoo ERP system. The column naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based default values for the `id` column are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the configuration of numerical precision settings across the application. It defines how many decimal places should be stored or displayed for various business entities (such as currency amounts, unit prices, or quantities) to ensure consistent rounding behavior throughout the system.

## Description
One row in this table represents a specific decimal precision configuration rule identified by a name. It serves as a raw landing copy of the system's precision settings, allowing downstream processes to look up the required scale for specific data fields.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `decimal_precision_id_seq` for auto-increment. |
| digits | INTEGER | false | Number of decimal places | Defines the precision scale for the associated rule. |
| create_uid | INTEGER | true | User ID who created the record | References the user table; null if system-generated. |
| write_uid | INTEGER | true | User ID who last updated the record | References the user table. |
| name | VARCHAR | false | Name of the precision rule | Descriptive label for the precision configuration. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `name` (assuming precision rule names are unique within the system).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system logic.
- **Audit Columns:** `create_uid` and `write_uid` are likely internal system IDs and may not resolve if the `res_users` table is not available in the staging layer.