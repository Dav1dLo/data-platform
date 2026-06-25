# res_country_state

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_country_state` (a standard Odoo model name), the use of `res_country_state_id_seq` for primary key generation, and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the master data management process for geographic hierarchies, specifically mapping states, provinces, or regions to their respective countries. It is used to populate address forms, validate shipping/billing locations, and provide lookup values for regional reporting across the platform.

## Description
One row in this table represents a single administrative subdivision (such as a state, province, or prefecture) within a country. This is a raw landed staging table containing the master definition of these regions, intended to be used for dimension building or reference lookups in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_country_state_id_seq`. |
| country_id | INTEGER | false | Foreign key to the parent country | References the `res_country` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| name | VARCHAR | false | Full name of the state or province | Human-readable label. |
| code | VARCHAR | false | Short code or abbreviation | Often ISO-3166-2 or local postal code. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id`: Links the state to its parent country record.
    - `create_uid` → `res_users.id`: Identifies the user who performed the initial creation (guess).
    - `write_uid` → `res_users.id`: Identifies the user who performed the last update (guess).
- **Natural keys (inferred):** 
    - `(country_id, code)`: The combination of country and state code is typically unique within the source system.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, ensure joins to `res_country` handle potential missing parent records if the ETL process is not strictly synchronized.