# account_move_send_batch_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move_send_batch_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven batch processing of accounting entries.

## Functional process 
This table supports the accounting module's batch processing workflow, specifically the "Send" wizard used to dispatch multiple account moves (invoices or journal entries) simultaneously. It tracks the state and metadata of a batch operation initiated by a user within the Odoo interface.

## Description
One row represents a single instance of a batch sending operation triggered by a user. It serves as a transient staging record to manage the lifecycle of a batch dispatch process, capturing who initiated the action and when it was last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res.users`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a "wizard" model, meaning it is likely transient and intended for temporary state management during a UI session; data may be purged or irrelevant after the batch process completes.
- Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- No PII is explicitly present in these columns, but the table is linked to user IDs which may be associated with sensitive employee data in other tables.
- The table does not contain the actual business data (the account moves themselves), only the metadata for the batch operation.