# sms_template_reset

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework that utilizes the `create_uid`, `write_uid`, `create_date`, and `write_date` audit pattern. The naming convention `sms_template_reset` suggests it is part of an SMS communication or notification module within that system.

## Functional process 
This table supports the management of SMS template reset configurations, likely tracking the history or state of templates that have been reverted to default settings. It functions as an audit or configuration log for template lifecycle management within the communication module.

## Description
One row in this table represents a single reset event or configuration record for an SMS template. It serves as a raw landed copy of the source system's audit trail, capturing the user and timestamp associated with the creation or modification of a template reset record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References a user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References a user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo/ERP pattern for user tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo/ERP pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard ERP database practices.
- This table contains audit metadata; it does not appear to contain PII, but `create_uid` and `write_uid` link to internal system users.
- There is no explicit soft-delete flag; assume records are hard-deleted if they disappear from the source.