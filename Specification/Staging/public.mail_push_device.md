# mail_push_device

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `partner_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` on a sequence named `mail_push_device_id_seq` are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the push notification infrastructure for mobile or browser-based clients. It manages the registration of device endpoints and associated security keys required to deliver push messages to specific partners (users) within the system.

## Description
One row in this table represents a single registered push notification device associated with a specific partner. It serves as a raw landing copy of device registration data, capturing the endpoint URL and encryption keys necessary for external notification services to communicate with the user's device.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_push_device_id_seq`. |
| partner_id | INTEGER | false | Foreign key to the partner/user | Links to the owner of the device. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who registered the device. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the device info. |
| endpoint | VARCHAR | false | Push service endpoint URL | The destination URL for push notifications. |
| keys | VARCHAR | false | Encryption keys for push payload | Contains security credentials for message decryption. |
| expiration_time | TIMESTAMP | true | Token expiration timestamp | When the push subscription is no longer valid. |
| create_date | TIMESTAMP | true | Record creation timestamp | Typically in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Typically in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: Standard Odoo naming convention for user/partner entities).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column for record creation).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `keys` column contains cryptographic material used for push notifications; ensure access is restricted.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume rows are hard-deleted if removed from the source.
- **Data Integrity:** The `endpoint` and `keys` columns are mandatory, but their format is dependent on the specific push service provider (e.g., VAPID keys for Web Push).