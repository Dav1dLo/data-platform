# sms_resend_recipient

## Source system
This table likely originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` on a sequence for the primary key, is a standard pattern for Odoo's ORM-managed tables.

## Functional process 
This table supports the notification and communication management process, specifically tracking the recipients of SMS messages that require a resend attempt. It links specific notification events to individual partners and their contact numbers, allowing the system to manage retry logic for failed SMS deliveries.

## Description
One row in this table represents a single recipient associated with a specific SMS resend event. It serves as a raw landing copy of the recipient-level data for SMS resend operations, capturing the contact details and the status of the resend flag.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_resend_recipient_id_seq`. |
| sms_resend_id | INTEGER | false | Foreign key to the parent SMS resend batch | Links to the main resend request record. |
| notification_id | INTEGER | false | Foreign key to the notification system | Identifies the original notification being resent. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| partner_name | VARCHAR | true | Name of the recipient partner | Human-readable identifier for the recipient. |
| sms_number | VARCHAR | true | Phone number for the SMS | The target destination for the resend. |
| resend | BOOLEAN | true | Flag indicating if resend is enabled | Determines if this recipient is included in the retry. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_resend_id` → `sms_resend.id`: This column links the recipient to the specific resend batch header.
    - `notification_id` → `mail_notification.id`: This column links the recipient to the underlying notification event.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `sms_number` column contains PII (phone numbers) and should be handled according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; however, Odoo tables often use an `active` boolean column (not present here) to handle soft deletes. Assume all rows are currently active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records depending on the frequency and nature of the extraction process.