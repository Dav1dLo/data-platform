# mail_alias_domain

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the email routing and domain configuration process within the Odoo mail module. It manages the mapping of domain-specific email aliases, such as bounce handling addresses and catch-all configurations, which are essential for processing incoming mail and managing domain-level email identity.

## Description
One row in this table represents a single mail alias domain configuration linked to the system's email server settings. It serves as a raw landing copy of the Odoo `mail.alias.domain` model, capturing the domain name and its associated routing aliases.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_alias_domain_id_seq` |
| sequence | INTEGER | true | Display order or priority | Used for sorting in UI |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id` |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id` |
| name | VARCHAR | false | The domain name | e.g., "example.com" |
| bounce_alias | VARCHAR | false | Email alias for bounce handling | Used for automated bounce processing |
| catchall_alias | VARCHAR | false | Email alias for catch-all routing | Captures emails sent to non-existent aliases |
| default_from | VARCHAR | true | Default sender address | Used when sending outgoing mail |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming convention for creator tracking)
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming convention for updater tracking)
- **Natural keys (inferred):** 
    - `name` (The domain name is unique within the context of the mail server configuration)

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in UTC, consistent with standard Odoo database configurations.
- This table contains no PII, but it does contain configuration data that dictates how the mail server routes traffic.
- There is no explicit soft-delete flag; assume records are hard-deleted if they disappear from the source.
- The `sequence` column may be null if no specific ordering has been defined by the user.