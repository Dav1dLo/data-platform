# base_enable_profiling_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (`base_enable_profiling_wizard`), the use of `create_uid` and `write_uid` for audit tracking, and the reliance on `nextval` sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the administrative profiling or diagnostic configuration process within the application. It tracks the lifecycle of "profiling wizard" sessions, which are likely used to enable performance monitoring or feature-specific diagnostic tools for specific users over a defined duration.

## Description
One row in this table represents a single instance of a profiling wizard session initiated within the system. It acts as a raw landing record in the staging layer, capturing the metadata, duration, and expiration settings for diagnostic tasks. The table tracks who created or modified the session and when these actions occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_enable_profiling_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| duration | VARCHAR | true | Duration of the profiling session | Likely stores a string representation of time or a configuration interval. |
| expiration | TIMESTAMP | true | Expiration timestamp of the session | Indicates when the profiling session is no longer valid. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`, `expiration`) are assumed to be in UTC, consistent with standard Odoo deployments.
- The `duration` column is a `VARCHAR`, which may require casting or parsing if used for mathematical operations (e.g., calculating remaining time).
- This table does not appear to implement soft deletes; it follows standard Odoo audit patterns where `write_date` tracks the latest update.
- No PII is immediately obvious, but `create_uid` and `write_uid` link to user identities which should be handled according to internal data privacy policies.