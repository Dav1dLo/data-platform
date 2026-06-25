# mail_template_reset

## Source system
This table likely originates from an Odoo ERP instance, as indicated by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence pattern used for the primary key (`nextval('"public".mail_template_reset_id_seq'::regclass)`).

## Functional process 
This table supports the management of email template resets or configuration overrides within the system's communication module. It tracks the audit trail of who created or modified specific template reset records, facilitating administrative oversight of automated email behavior.

## Description
One row in this table represents a single configuration record for an email template reset event. It serves as a raw landing copy of the source system's audit-tracked entity, capturing the lifecycle metadata of these reset definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by a database sequence. |
| create_uid | INTEGER | true | User ID who created the record | Foreign key to the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | Foreign key to the users table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table contains audit metadata (`create_uid`, `write_uid`) which may link to sensitive user identity information in other tables.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table appears to be a system-level audit or configuration table; it does not contain the actual content of the email templates, only the reset metadata.
- No soft-delete flag is present; assume records are either hard-deleted or maintained indefinitely.