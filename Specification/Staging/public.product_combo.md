# product_combo

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` on a `_seq` sequence for the primary key, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports product catalog management, specifically defining groupings or "combos" of products. The presence of `company_id` suggests it supports multi-tenant or multi-company configurations within the ERP, allowing product combinations to be scoped to specific business entities.

## Description
One row in this table represents a single product combination definition within the catalog. It serves as a raw landed copy of the source system's product configuration data, capturing the metadata and audit trails for each combo record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.product_combo_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting combos in UI/reports. |
| company_id | INTEGER | true | Foreign key to company | Scopes the record to a specific business unit. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | false | Combo name | The descriptive label for the product combination. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company scoping).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit user IDs (`create_uid`, `write_uid`) which may need to be joined against a user dimension table to resolve human-readable names.
- There is no explicit "active" or "deleted" flag; assume all records are current unless a separate status column is introduced in future schema versions.
- The `name` column is mandatory, but there are no constraints preventing duplicate names across different `company_id` scopes.