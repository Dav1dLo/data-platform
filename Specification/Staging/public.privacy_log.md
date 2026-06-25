# privacy_log

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. This is inferred from the presence of standard Odoo-style audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are characteristic of the Odoo ORM's automatic tracking system.

## Functional process 
This table supports the data privacy and compliance process, specifically tracking anonymization or data masking requests. It logs actions taken to redact or anonymize user-identifiable information, likely in response to GDPR or CCPA "Right to be Forgotten" requests, providing an audit trail of who performed the action and what records were affected.

## Description
One row in this table represents a single privacy-related event or anonymization action performed on a specific user's data. It serves as a raw landing staging table, capturing the audit trail of data modifications intended to protect user privacy. The grain is one row per privacy log entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.privacy_log_id_seq`. |
| user_id | INTEGER | false | Target user identifier | The ID of the user whose data was processed. |
| create_uid | INTEGER | true | Creator user ID | The ID of the system user who initiated the log entry. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the system user who last updated the log entry. |
| anonymized_name | VARCHAR | false | Anonymized name value | The masked or placeholder name string. |
| anonymized_email | VARCHAR | false | Anonymized email value | The masked or placeholder email string. |
| execution_details | TEXT | true | Process execution logs | Technical details regarding the anonymization script execution. |
| records_description | TEXT | true | Affected records summary | Description of which records or modules were affected. |
| additional_note | TEXT | true | Contextual notes | Free-text field for manual comments on the privacy action. |
| date | TIMESTAMP | false | Event timestamp | The date and time the privacy action occurred. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when this log entry was first created. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp when this log entry was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (guess: standard Odoo user reference).
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** While the table contains `anonymized_name` and `anonymized_email`, these are intended to be non-PII placeholders; however, ensure `execution_details` and `additional_note` do not contain leaked PII.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** This is a staging table; expect raw, potentially unvalidated input in the `TEXT` fields.
- **Soft Deletes:** There is no explicit soft-delete flag; assume all rows are active unless otherwise specified by business logic.