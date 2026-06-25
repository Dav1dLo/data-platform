# product_document

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`, `write_date`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's internal data model.

## Functional process 
This table supports the document management process within the product catalog, specifically linking attachments to product records. It defines the visibility and association of documents across different business modules, such as Manufacturing (MRP) and Sales, as indicated by the `attached_on_mrp` and `attached_on_sale` flags.

## Description
One row in this table represents a specific association between a product and an attachment record stored in the system's document repository. It serves as a staging entity, providing a raw, landed copy of the link between product-related metadata and the underlying file attachments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_document_id_seq` |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the `ir_attachment` table |
| sequence | INTEGER | true | Sort order for the document | Used for UI display ordering |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users` |
| active | BOOLEAN | true | Soft-delete flag | If false, the document link is inactive |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |
| attached_on_mrp | VARCHAR | false | Visibility flag for MRP module | Likely 'True'/'False' or status code |
| attached_on_sale | VARCHAR | false | Visibility flag for Sales module | Likely 'True'/'False' or status code |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `ir_attachment.id` (Inferred from Odoo naming convention for attachment links).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to retrieve current records.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Visibility Flags:** `attached_on_mrp` and `attached_on_sale` are `VARCHAR` types; ensure queries handle potential string-based boolean representations (e.g., 'True', 't', '1').
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system users and may not resolve to human-readable names without joining to the `res_users` table.