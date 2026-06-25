# quotation_document

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based primary key are highly characteristic of the Odoo framework's internal object-relational mapping.

## Functional process 
This table supports the document management process associated with sales quotations. It acts as a link between quotation records and their associated binary attachments (such as PDFs or signed contracts), tracking the lifecycle and metadata of these documents within the sales pipeline.

## Description
One row in this table represents a single document association linked to a quotation, identified by its attachment ID. It serves as a raw landing copy of the Odoo `quotation.document` model, capturing the relationship between business entities and their file-based attachments at the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `quotation_document_id_seq`. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment registry | Links to the core Odoo `ir_attachment` table. |
| sequence | INTEGER | true | Display order index | Used for sorting documents in the UI. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| document_type | VARCHAR | false | Category of the document | Defines the nature of the attachment. |
| active | BOOLEAN | true | Soft-delete status | If false, the document is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `ir_attachment.id`: This column is a standard Odoo pattern for linking to the system-wide attachment registry.
    - `create_uid` → `res_users.id`: Standard Odoo audit field for user tracking.
    - `write_uid` → `res_users.id`: Standard Odoo audit field for user tracking.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column suggests a soft-delete pattern; queries should filter by `WHERE active = TRUE` to retrieve only current records.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs and may not map to human-readable names without joining to the `res_users` table.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the ingestion process is not idempotent.