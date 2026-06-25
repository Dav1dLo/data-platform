# crm_iap_lead_industry

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields like `name`, which is characteristic of Odoo's internal data storage.

## Functional process 
This table supports the Lead-to-Cash pipeline, specifically managing industry classifications for leads generated via Odoo's "IAP" (In-App Purchase) lead enrichment services. It categorizes leads by industry, likely used for segmentation and targeting within the CRM module.

## Description
One row represents a single industry classification record used to tag or filter leads. The grain is one row per industry definition. This table serves as a raw landed staging entity, capturing the configuration state of lead industry categories from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| color | INTEGER | true | UI display color index | Used for visual categorization in the CRM interface. |
| sequence | INTEGER | true | Sort order index | Determines the display order in dropdowns or lists. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system users table. |
| reveal_ids | VARCHAR | false | IAP integration mapping IDs | Likely a comma-separated list of external IAP service identifiers. |
| name | JSONB | false | Industry name | Multilingual/localized name stored as a JSON object. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data format:** The `name` column is `JSONB`; ensure your query logic handles JSON extraction (e.g., `name->>'en_US'`) to retrieve readable text.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft deletes:** This table does not appear to have an explicit `active` boolean flag, which is common in Odoo; verify if records are physically deleted or if they simply stop being referenced.
- **Sensitive data:** No PII is immediately obvious, but `reveal_ids` may contain internal system identifiers that should be treated as opaque.