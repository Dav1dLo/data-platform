# discuss_voice_metadata

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit columns in the Odoo framework. The `discuss_` prefix suggests it belongs to the Odoo Discuss module, which handles internal messaging and voice communications.

## Functional process 
This table supports the internal communication and collaboration module, specifically tracking metadata associated with voice attachments or audio messages. It acts as a link between raw file attachments and the users who created or modified them within the communication stream.

## Description
One row in this table represents the metadata record for a specific voice or audio attachment within the Odoo Discuss module. It tracks the lifecycle of the attachment, including its creation and modification history, at the grain of one row per attachment metadata entry. This is a raw staging table intended to provide a historical audit trail of voice-related communication artifacts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| attachment_id | INTEGER | true | Foreign key to the attachment record | Links to the actual file/blob storage record. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `attachment_id` → `ir_attachment.id` (guess: standard Odoo pattern for linking metadata to file storage).
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains references to user IDs; ensure join logic accounts for potential missing users if the `res_users` table has been purged.
- No explicit soft-delete flag is present; assume records are hard-deleted if they disappear from the source.
- The table is a staging entity; verify if `attachment_id` is unique per row to avoid fan-out issues during joins.