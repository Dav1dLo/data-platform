# snailmail_letter_format_error

## Source system
The table likely originates from an Odoo ERP system, indicated by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework. The `snailmail` prefix suggests integration with a postal service or document mailing module.

## Functional process 
This table supports the error handling and logging process for the automated postal mailing pipeline. It tracks formatting issues encountered when attempting to generate or process snail mail letters, linking specific error events to the underlying message or document record.

## Description
One row in this table represents a single formatting error event associated with a snail mail letter generation attempt. It serves as a raw landing record in the staging layer, capturing the audit trail and status of failed letter formatting tasks for further investigation or retry logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `snailmail_letter_format_error_id_seq`. |
| message_id | INTEGER | true | Foreign key to the parent message | Likely links to a `mail.message` or similar entity. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| snailmail_cover | BOOLEAN | true | Flag indicating if a cover page was included | Used to determine if the error occurred during cover page generation. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id` (guess based on Odoo standard naming patterns).
    - `create_uid` → `res_users.id` (standard Odoo audit field).
    - `write_uid` → `res_users.id` (standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit user IDs (`create_uid`, `write_uid`) which may require mapping to a user dimension table to resolve actual usernames.
- There is no explicit "error_message" or "error_code" column provided in the schema; downstream users should verify if this table is intended to be joined with a log or detail table to understand the nature of the format error.
- The table does not implement soft-delete flags; records are assumed to be hard-deleted if removed from the source.