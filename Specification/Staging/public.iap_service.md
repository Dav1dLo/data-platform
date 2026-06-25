# iap_service

## Source system
This table likely originates from an Odoo ERP or a similar modular business application, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields, which is characteristic of Odoo's PostgreSQL-based architecture.

## Functional process 
This table supports the In-App Purchase (IAP) service management process. It acts as a registry for various external services or API integrations that the platform consumes, tracking their technical identifiers, display names, and configuration settings (such as whether they support integer-based credit balances).

## Description
One row in this table represents a single IAP service integration available within the system. It serves as a raw landed staging entity, capturing the metadata and configuration parameters required to interface with external service providers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.iap_service_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References a user in the system. |
| write_uid | INTEGER | true | User ID who last updated the record | References a user in the system. |
| name | VARCHAR | false | Display name of the service | Likely localized or human-readable. |
| technical_name | VARCHAR | false | Internal system identifier | Used for programmatic service calls. |
| description | JSONB | false | Service description details | Likely contains multi-language strings. |
| unit_name | JSONB | false | Unit of measure for the service | Likely defines currency or credit units. |
| integer_balance | BOOLEAN | false | Flag for balance type | Indicates if the service uses whole numbers. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `technical_name` (likely unique within the system to identify the service).

## Caveats for downstream consumers

- The `description` and `unit_name` columns are `JSONB` types; ensure your query logic handles JSON extraction (e.g., `->> 'en_US'`) if you need specific language values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard PostgreSQL staging practices.
- This table appears to be a configuration registry; it is unlikely to contain PII, but `create_uid` and `write_uid` link to user identity data.
- No explicit soft-delete flag is present; assume records are hard-deleted if they disappear from the source.