# phone_blacklist_remove

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the primary key, which is characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the management of communication preferences, specifically tracking the removal of phone numbers from a blacklist. It facilitates compliance with communication regulations by maintaining a record of when and why a phone number was unblocked or removed from a restricted contact list.

## Description
One row in this table represents a single event where a phone number was removed from a blacklist. It serves as a raw landing copy of the removal history, capturing the identity of the user who performed the action and the timestamp of the event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `phone_blacklist_remove_id_seq` |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` |
| phone | VARCHAR | false | The phone number removed from the blacklist | Likely E.164 format |
| reason | VARCHAR | true | Textual explanation for the removal | Free-text field |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `phone` column may contain varying formats; ensure normalization before joining with other contact tables.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table tracks removal events; it does not necessarily represent the current state of the blacklist itself.
- `create_uid` and `write_uid` are internal system IDs and require a join to the `res_users` table to resolve to human-readable names.