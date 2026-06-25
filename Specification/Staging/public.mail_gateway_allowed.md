# mail_gateway_allowed

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in Odoo's ORM, alongside the use of `nextval` sequences for primary keys.

## Functional process 
This table supports an email allow-list or whitelist process for a mail gateway. It manages the list of authorized email addresses permitted to interact with the system's mail server or automated email processing workflows, ensuring that incoming or outgoing communications are restricted to verified or approved contacts.

## Description
One row in this table represents a single authorized email address entry within the mail gateway's whitelist. This is a raw staging table containing the current configuration state of allowed email identities, used to validate or filter email traffic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_gateway_allowed_id_seq` sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system's internal user table. |
| email | VARCHAR | false | The raw email address | The primary identifier for the allowed contact. |
| email_normalized | VARCHAR | true | Standardized email address | Usually lowercase and stripped of whitespace for consistent matching. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit field pattern).
- **Natural keys (inferred):** 
    - `email`

## Caveats for downstream consumers

- **PII:** The `email` and `email_normalized` columns contain PII and should be masked or restricted according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in the application's configured timezone (typically UTC), but verify against the source system settings.
- **Data Quality:** `email_normalized` may be null if the ingestion process or the source system failed to perform the normalization step.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume records are hard-deleted if they disappear from the source.