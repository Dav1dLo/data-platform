# crm_iap_lead_role

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention (`crm_iap_lead_role`), the use of `create_uid` and `write_uid` audit columns, and the `JSONB` data type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the Lead-to-Cash pipeline by managing the classification or role definitions for leads acquired via In-App Purchasing (IAP) services. It defines the categories or roles that can be assigned to incoming leads to facilitate automated routing and prioritization within the CRM module.

## Description
One row in this table represents a single lead role definition used to categorize CRM leads. It serves as a raw landed staging entity, capturing the configuration metadata for lead roles as defined in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_role_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual representation in the CRM dashboard. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| reveal_id | VARCHAR | false | External IAP identifier | The unique identifier provided by the IAP service. |
| name | JSONB | false | Role name | Multi-language string stored as a JSON object. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `reveal_id` (The unique identifier assigned by the IAP service).

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; query writers must use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC.
- This table contains no explicit soft-delete flag; assume all records are active unless otherwise specified by business logic.
- `create_uid` and `write_uid` refer to internal system users and may not be resolvable if the `res_users` table is not available in the target schema.