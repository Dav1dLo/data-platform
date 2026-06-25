# mail_guest

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM layer.

## Functional process 
This table supports the "Communication and Collaboration" module, specifically managing guest users in the mail/messaging system. It tracks external or unauthenticated users who participate in discussions or channels, storing their preferences like language and timezone to facilitate personalized communication.

## Description
One row represents a single guest user within the messaging system. It serves as a raw landed copy of the guest entity, capturing identity tokens and localization settings. This table is used to maintain the state of non-registered participants across messaging threads.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_guest_id_seq`. |
| country_id | INTEGER | true | Foreign key to country | Links to the guest's geographic location. |
| create_uid | INTEGER | true | Creator user ID | ID of the internal user who created this record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the internal user who last modified this record. |
| name | VARCHAR | false | Display name | The name associated with the guest. |
| access_token | VARCHAR | false | Security token | Unique token used for guest authentication/access. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| timezone | VARCHAR | true | Timezone string | IANA timezone identifier (e.g., 'UTC'). |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id` (Guess: standard Odoo naming for country references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field for record modification).
- **Natural keys (inferred):** 
    - `access_token` (Likely used as the unique identifier for guest session validation).

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` column should be treated as a credential and masked in non-production environments.
- **Timestamps:** Timestamps are typically stored in UTC in Odoo; verify against system configuration if local time conversion is required.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Data Integrity:** `country_id` may be null for guests whose location is not captured or provided.