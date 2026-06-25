# mail_push

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, evidenced by the standard naming conventions `create_uid`, `write_uid`, `create_date`, and `write_date`, which are characteristic of Odoo's ORM audit fields.

## Functional process 
This table supports a notification or messaging service, specifically managing the dispatch of push notifications to mobile or web devices. It tracks the association between specific device identifiers and the message content (payload) being sent.

## Description
One row represents a single push notification event or message queue entry destined for a specific device. As a staging table, it serves as a raw, landed copy of the notification logs, capturing the state of the message payload and the audit trail of its creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.mail_push_id_seq`. |
| mail_push_device_id | INTEGER | false | Foreign key to the target device | Identifies the recipient device. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| payload | TEXT | true | Notification content | Likely contains JSON or serialized message data. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_push_device_id` → `mail_push_device.id` (Guess: standard naming convention for device association).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `payload` column may contain PII or sensitive notification content; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Retention:** This table appears to be an append-only or update-in-place log; there is no explicit soft-delete flag, so assume all records are active unless otherwise specified by business logic.
- **Payload Format:** The `payload` column is stored as `TEXT`; query writers should expect to parse this as JSON or a similar serialized format.