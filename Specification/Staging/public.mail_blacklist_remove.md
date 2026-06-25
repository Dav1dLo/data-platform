# mail_blacklist_remove

## Source system
This table likely originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default value for the primary key, which is characteristic of the Odoo ORM.

## Functional process 
This table supports the email marketing or communication management process by tracking the removal of email addresses from a blacklist. It records the audit trail of who initiated the removal and why, ensuring compliance with communication preferences and anti-spam regulations.

## Description
One row in this table represents a single event where an email address was removed from a blacklist. It serves as a raw landed staging entity, capturing the audit metadata and the specific reason provided for the removal action.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.mail_blacklist_remove_id_seq` |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` table |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` table |
| email | VARCHAR | false | The email address being removed from the blacklist | Likely contains PII |
| reason | VARCHAR | true | Text description of why the email was removed | Free-text field |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column pattern)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column pattern)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information and should be handled according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete audit trails depending on the upstream extraction logic.
- **Soft Deletes:** This table does not appear to implement soft deletes; it acts as an append-only log of removal events.