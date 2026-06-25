# picking_label_type

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the warehouse management and logistics process by defining the available categories or formats for picking labels. It acts as a configuration or lookup table that dictates how labels are generated or classified during the order fulfillment and picking workflow.

## Description
One row in this table represents a specific type of picking label available for use within the warehouse system. As a staging table, it serves as a raw, direct copy of the source system's configuration entity, intended to provide downstream processes with the definitions required to categorize picking documentation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence-based default. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| label_type | VARCHAR | false | Descriptive name of the label type | The business-facing label category. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `label_type` (Assuming the label type name is unique within the system).

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no PII, but `create_uid` and `write_uid` link to internal user identities which may be considered sensitive in some contexts.
- There is no explicit soft-delete flag; records are likely managed via direct updates or deletions in the source system.