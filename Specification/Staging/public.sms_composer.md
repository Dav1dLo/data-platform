# sms_composer

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_id`, `create_uid`, `write_uid`, `res_model`) and the specific sequence-based primary key pattern are characteristic of Odoo's ORM layer, which manages SMS composition and dispatching workflows.

## Functional process 
This table supports the SMS marketing and communication module, specifically the "SMS Composer" wizard process. It acts as a staging area for drafting, configuring, and queuing SMS messages before they are sent to individual recipients or mass-mailing lists, tracking both single-recipient messages and bulk campaigns.

## Description
One row in this table represents a single SMS composition session or draft created by a user within the system. It captures the message content, the target model/record context, and the configuration settings for delivery (such as blacklist usage or forced sending). This is a raw staging table containing the state of the composer wizard before the final dispatch.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_composer_id_seq`. |
| res_id | INTEGER | true | ID of the related record | Links to the source object defined in `res_model`. |
| template_id | INTEGER | true | SMS template ID | Foreign key to an SMS template definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the composition. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| composition_mode | VARCHAR | false | Mode of operation | e.g., 'comment', 'mass'. |
| res_model | VARCHAR | true | Related model name | The technical name of the Odoo model (e.g., 'res.partner'). |
| res_ids | VARCHAR | true | List of related record IDs | Serialized list of IDs for mass operations. |
| recipient_single_number_itf | VARCHAR | true | Recipient phone number | Used for single-recipient messages. |
| number_field_name | VARCHAR | true | Field name for phone numbers | The field on the target model containing the phone number. |
| numbers | VARCHAR | true | List of phone numbers | Used for bulk/manual number entry. |
| body | TEXT | false | SMS message content | The actual text to be sent. |
| mass_keep_log | BOOLEAN | true | Log flag | Whether to keep a log of the mass mailing. |
| mass_force_send | BOOLEAN | true | Force send flag | Whether to bypass queueing and send immediately. |
| mass_use_blacklist | BOOLEAN | true | Blacklist check flag | Whether to filter recipients against the blacklist. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `template_id` → `sms_template.id` (Guess: standard Odoo template reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** The `body` column may contain PII or sensitive communication content.
- **Data Format:** `res_ids` and `numbers` are stored as `VARCHAR` but likely contain serialized lists (e.g., JSON or comma-separated strings) that require parsing for analysis.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.