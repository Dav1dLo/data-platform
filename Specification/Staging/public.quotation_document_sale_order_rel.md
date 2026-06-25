# quotation_document_sale_order_rel

## Source system
This table likely originates from an ERP or CRM system (such as Odoo or a custom-built sales management platform) that maintains a many-to-many relationship between sales orders and quotation documents. The naming convention `_rel` is highly characteristic of join tables in ORM-based database schemas.

## Functional process 
This table supports the sales-to-order lifecycle by mapping specific quotation documents to their resulting or associated sales orders. It facilitates the traceability of commercial proposals through to confirmed customer commitments.

## Description
One row in this table represents a single association between a quotation document and a sales order. It serves as a raw landing join table in the staging layer, enabling the reconstruction of relationships between sales documentation and transactional order records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_id | INTEGER | false | Foreign key to the sales order record | Represents the target order entity. |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document record | Represents the source quotation entity. |

## Keys

- **Primary key (inferred):** The composite of (`sale_order_id`, `quotation_document_id`).
- **Foreign keys (inferred):** 
    - `sale_order_id` → `sale_order.id` (Inferred from standard naming conventions for order entities).
    - `quotation_document_id` → `quotation_document.id` (Inferred from standard naming conventions for document entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- Ensure inner joins are used when filtering for specific relationships, as this table does not contain soft-delete flags or status indicators.
- As a staging table, it is expected to be truncated and reloaded during ingestion cycles; do not rely on this table for historical audit trails.