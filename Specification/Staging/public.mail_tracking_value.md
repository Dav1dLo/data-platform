# mail_tracking_value

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `mail_message_id`, `create_uid`, `write_uid`, `field_info` as `JSONB`) and the specific pattern of tracking field changes across multiple data types (integer, char, text, float, datetime) are characteristic of Odoo's `mail.tracking.value` model, which logs historical changes to records.

## Functional process 
This table supports the audit trail and communication history process. It records the specific "before" and "after" values of fields whenever a record is updated, allowing the system to display change logs within the chatter/discussion threads of business objects like sales orders, invoices, or CRM leads.

## Description
One row represents a single field-level change event associated with a specific mail message or activity log. It acts as a raw landed copy of the Odoo tracking history, capturing the delta for a specific field across various data types. The grain is one row per field change per update event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| field_id | INTEGER | true | Reference to the field definition | Links to the system's field metadata. |
| old_value_integer | INTEGER | true | Previous integer value | Used for integer-based fields. |
| new_value_integer | INTEGER | true | New integer value | Used for integer-based fields. |
| currency_id | INTEGER | true | Currency reference | Used if the tracked field is monetary. |
| mail_message_id | INTEGER | false | Parent message/log ID | Links to the main mail message record. |
| create_uid | INTEGER | true | Creator user ID | User who performed the update. |
| write_uid | INTEGER | true | Last updater user ID | User who last modified this log entry. |
| old_value_char | VARCHAR | true | Previous character value | Used for short string fields. |
| new_value_char | VARCHAR | true | New character value | Used for short string fields. |
| field_info | JSONB | true | Metadata about the field | Contains additional context for the change. |
| old_value_text | TEXT | true | Previous text value | Used for long text fields. |
| new_value_text | TEXT | true | New text value | Used for long text fields. |
| old_value_datetime | TIMESTAMP | true | Previous datetime value | Used for date/time fields. |
| new_value_datetime | TIMESTAMP | true | New datetime value | Used for date/time fields. |
| create_date | TIMESTAMP | true | Creation timestamp | When this log entry was created. |
| write_date | TIMESTAMP | true | Last update timestamp | When this log entry was last modified. |
| old_value_float | DOUBLE PRECISION | true | Previous float value | Used for numeric/decimal fields. |
| new_value_float | DOUBLE PRECISION | true | New float value | Used for numeric/decimal fields. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Evidence: Standard Odoo naming convention for parent-child relationships in the mail module).
    - `create_uid` / `write_uid` → `res_users.id` (Evidence: Standard Odoo naming for audit user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Data Sparsity:** This table uses a "wide" schema to handle multiple data types; for any given row, most `old_value_*` and `new_value_*` columns will be NULL.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** The `old_value_text` and `new_value_text` columns may contain PII or sensitive business information depending on which fields are being tracked in the source system.
- **Soft Deletes:** This table does not appear to implement soft deletes; it represents an immutable audit log of changes.