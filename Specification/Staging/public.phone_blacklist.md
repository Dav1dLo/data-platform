# phone_blacklist

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of `create_uid`, `write_uid`, and `write_date` columns, which are standard audit fields in Odoo models.

## Functional process 
This table supports communication compliance and contact management processes, specifically the "Do Not Contact" or "Opt-out" list. It tracks phone numbers that have been explicitly blacklisted to prevent automated marketing or outreach activities.

## Description
One row in this table represents a single phone number that has been flagged for exclusion from outbound communications. It serves as a raw landing copy of the blacklist entity, capturing the identity of the user who created or modified the record and the current active status of the entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.phone_blacklist_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| number | VARCHAR | false | The blacklisted phone number | Likely stored in E.164 format. |
| active | BOOLEAN | true | Soft-delete flag | If false, the number is no longer blacklisted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** 
    - `number`: The phone number itself acts as the business identifier for the blacklist.

## Caveats for downstream consumers

- **Sensitive Data:** The `number` column contains PII (phone numbers) and should be handled according to data privacy policies (GDPR/CCPA).
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless auditing historical changes.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL configurations.
- **Audit Fields:** `create_uid` and `write_uid` are internal system IDs and may not be resolvable without access to the corresponding `res_users` table in the source system.