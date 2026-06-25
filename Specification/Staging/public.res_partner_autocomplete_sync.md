# res_partner_autocomplete_sync

## Source system
This table originates from an Odoo ERP system, as evidenced by the `res_partner` naming convention, the use of `create_uid`/`write_uid` audit columns, and the specific sequence naming pattern `res_partner_autocomplete_sync_id_seq`.

## Functional process 
This table supports the synchronization process for partner (customer/vendor) data enrichment or autocomplete services. It tracks which partner records have been processed or synchronized with external autocomplete providers to ensure data consistency and avoid redundant API calls.

## Description
One row represents the synchronization status of a specific partner record within the autocomplete service. This is a raw staging table containing metadata about the sync state, intended to track whether a partner has been successfully processed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing values. |
| partner_id | INTEGER | true | Foreign key to the partner record | References the main partner entity being synced. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the sync entry. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the sync state. |
| synched | BOOLEAN | true | Synchronization status flag | Indicates if the partner data has been successfully synced. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job in local server time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job in local server time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id`: This column is the standard Odoo naming convention for linking to the primary partner table.
    - `create_uid` → `res_users.id`: Standard Odoo audit column referencing the user who created the record.
    - `write_uid` → `res_users.id`: Standard Odoo audit column referencing the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** While this table contains only IDs and status flags, it is linked to `partner_id`, which likely contains PII. Ensure access controls on the parent `res_partner` table are respected.
- **Timestamps:** Timestamps are assumed to be in the Odoo server's local time; verify if the application layer performs UTC conversion.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Nullability:** `partner_id` is nullable, which may indicate orphaned sync records or system-level entries not tied to a specific partner.