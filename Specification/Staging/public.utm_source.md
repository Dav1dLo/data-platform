# utm_source

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a signature pattern for Odoo's ORM-managed tables, which track record creation and modification metadata consistently across the platform.

## Functional process 
This table supports marketing attribution and campaign tracking. It acts as a lookup or dimension table that stores unique identifiers for marketing sources (e.g., "google", "newsletter", "referral"), which are then referenced by other entities like leads, opportunities, or sales orders to track the origin of business traffic.

## Description
One row in this table represents a single marketing source entity used for attribution. It serves as a raw landed copy of the source system's configuration table, providing a standardized list of traffic origins for downstream analytical reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.utm_source_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| name | VARCHAR | false | The name of the marketing source | The human-readable label (e.g., 'cpc', 'email'). |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** 
    - `name`: In the context of UTM parameters, the source name is typically unique within the source system.

## Caveats for downstream consumers

- **PII/Sensitivity:** This table contains no PII.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by the source system logic.
- **Data Integrity:** The `name` column is the functional business key; ensure joins are performed on this if the surrogate `id` is not available in the target fact table.