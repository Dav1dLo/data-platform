# crm_lost_reason

## Source system
This table likely originates from an Odoo ERP or CRM system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a `JSONB` column for multi-language support in the `name` field, which is characteristic of Odoo's database schema.

## Functional process 
This table supports the sales pipeline management process by maintaining a lookup list of reasons why sales opportunities or leads were marked as "lost." It allows the business to categorize churn or lost-deal signals for reporting and performance analysis.

## Description
One row represents a single defined reason for losing a sales opportunity. This is a raw landed staging table containing the configuration data for lost-reason categories used within the CRM module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| name | JSONB | false | The label for the lost reason | Likely contains translations (e.g., {"en_US": "Price", "fr_FR": "Prix"}). |
| active | BOOLEAN | true | Soft-delete flag | If false, the reason is no longer available for selection. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is `JSONB`; ensure your SQL dialect handles JSON extraction (e.g., `name->>'en_US'`) when querying for human-readable labels.
- Timestamps are assumed to be in UTC, consistent with standard Odoo deployment practices.
- This table uses a soft-delete pattern via the `active` column; ensure your queries filter by `active = true` if you only want currently valid reasons.
- The `create_uid` and `write_uid` columns are nullable, which may occur if records were migrated or created via system processes without a specific user context.