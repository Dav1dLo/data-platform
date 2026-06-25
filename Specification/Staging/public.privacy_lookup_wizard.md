# privacy_lookup_wizard

## Source system
The table appears to originate from an Odoo ERP or a similar Python-based framework, evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in Odoo models. The `nextval` sequence pattern further confirms a PostgreSQL-backed application environment.

## Functional process 
This table supports a data privacy or compliance workflow, likely a "Right to be Forgotten" or "Subject Access Request" (SAR) lookup tool. It tracks the execution of privacy-related queries or data retrieval tasks, linking specific users (`create_uid`) to the execution of these lookups against customer records identified by `email`.

## Description
One row represents a single execution instance of a privacy lookup or data audit request. It serves as a raw landing record in the staging layer, capturing the identity of the requester, the target email address, and the resulting execution metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `privacy_lookup_wizard_id_seq`. |
| log_id | INTEGER | true | Reference to an external log entry | Likely links to a broader system audit log. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's internal user table. |
| name | VARCHAR | false | Name of the lookup request | Descriptive label for the privacy task. |
| email | VARCHAR | false | Target email address for the lookup | The PII subject of the privacy request. |
| execution_details | TEXT | true | JSON or text blob of lookup results | Contains the output or status of the privacy search. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** 
    - None. The table appears to be a transactional log of requests rather than a master entity.

## Caveats for downstream consumers

- **PII Sensitivity:** The `email` column contains direct PII and should be masked or restricted in downstream reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL application practices.
- **Data Integrity:** `log_id` is nullable, suggesting that not all lookup requests are successfully tied to a parent system log.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by business logic.