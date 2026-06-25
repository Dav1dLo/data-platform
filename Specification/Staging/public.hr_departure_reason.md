# hr_departure_reason

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for the `name` field are characteristic of Odoo's ORM-based PostgreSQL schema structure.

## Functional process 
This table supports the Human Resources management process, specifically tracking the categorization of employee departures. It provides a lookup list of reasons for termination or resignation, which are likely referenced by employee records to facilitate turnover reporting and analytics.

## Description
One row in this table represents a single defined reason for an employee's departure from the organization. This is a staging-layer reference table, containing raw, un-transformed configuration data used to standardize exit interview or offboarding documentation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_departure_reason_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to control the sort order in UI dropdowns. |
| reason_code | INTEGER | true | Business-level reason identifier | Likely a legacy or external system mapping code. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated this record. |
| name | JSONB | false | Departure reason label | Multi-language string stored as JSON; requires extraction for reporting. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the Odoo framework. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo framework. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column for user tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`. To query the English label, you will likely need to use the `->>` operator (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are stored in UTC.
- This table acts as a configuration/lookup table; it is unlikely to contain PII, but `create_uid` and `write_uid` link to user identity records.
- There is no explicit soft-delete flag; assume records are active unless otherwise specified by business logic.