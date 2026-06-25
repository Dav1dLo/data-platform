# sms_resend

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of the Odoo ORM framework's standard audit fields.

## Functional process 
This table supports the communication management process, specifically tracking the re-transmission of SMS messages. It appears to act as a link or log table for identifying which mail messages were subject to a resend operation, likely used to manage retry logic or audit communication history.

## Description
One row in this table represents a single instance of an SMS resend event associated with a specific mail message. As a staging table, it serves as a raw, landed copy of the source system's transaction log, capturing the audit trail of who performed the resend and when it occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_resend_id_seq` sequence. |
| mail_message_id | INTEGER | false | Foreign key to the parent mail message | Links to the original message being resent. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the resend. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Inferred based on standard Odoo naming conventions for linking to the core mail message entity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `create_uid` and `write_uid` columns reference internal system user IDs; ensure these are joined against the appropriate user dimension table to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain duplicates or partial records depending on the frequency and logic of the ingestion pipeline.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records are current unless otherwise specified by the source system's business logic.