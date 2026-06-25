# crm_iap_lead_seniority

## Source system
This table originates from an Odoo-based CRM system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences for the primary key, is characteristic of the Odoo ORM framework's standard audit and tracking fields.

## Functional process 
This table supports the lead management and qualification process, specifically tracking seniority levels or attributes associated with leads identified via an "IAP" (In-App Purchase or Integrated Account Processing) service. It likely maps external lead identifiers to internal seniority classifications stored within the `name` JSONB field.

## Description
Each row represents a specific seniority classification or metadata record associated with a lead within the CRM. This is a raw staging table, serving as a direct landing of the underlying Odoo database table, intended for use in downstream transformation pipelines to extract structured lead attributes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard PostgreSQL sequence. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| reveal_id | VARCHAR | false | External identifier for the lead reveal | Likely a unique key from the IAP service provider. |
| name | JSONB | false | Seniority label or descriptive attributes | Stored as JSON; likely contains multi-language labels or nested metadata. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for creator).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for updater).
- **Natural keys (inferred):** 
    - `reveal_id` (This appears to be the unique business key provided by the external IAP service).

## Caveats for downstream consumers

- **Data Sensitivity:** The `name` column contains JSONB data which may include PII or sensitive lead attributes; inspect the content before exposing to non-privileged users.
- **Timestamps:** All `_date` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB Handling:** Queries against the `name` column will require PostgreSQL JSONB operators (e.g., `->>` or `@>`) to extract specific values.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by the source system logic.