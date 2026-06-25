# pos_bill

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM-based audit tracking, and the table name `pos_bill` suggests it is part of the Point of Sale (POS) module.

## Functional process 
This table supports the Point of Sale billing configuration process. It appears to manage specific bill or receipt configurations, potentially defining custom bill templates or settings that can be applied globally (`for_all_config`) or to specific POS instances.

## Description
One row in this table represents a single bill configuration record within the POS system. It serves as a raw landed copy of the source system's configuration entity, capturing the metadata, value, and scope of each bill definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_bill_id_seq` sequence. |
| create_uid | INTEGER | true | ID of the user who created the record | References a user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References a user table. |
| name | VARCHAR | true | Descriptive name of the bill configuration | Human-readable identifier. |
| value | NUMERIC | false | Monetary or configuration value | Precision/scale not specified. |
| for_all_config | BOOLEAN | true | Flag indicating if this applies to all POS configs | If true, overrides specific settings. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely in UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `value` column is `NUMERIC` and does not specify currency; verify if this represents a fixed amount or a configuration parameter.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database practices.
- This table does not appear to implement soft deletes; standard Odoo behavior is to update `write_date` on modification.
- The `name` column may contain non-unique labels depending on the source system's configuration constraints.