# header_footer_quotation_template_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is characteristic of many-to-many relationship tables in Odoo's ORM, and the column names suggest a link between quotation document configurations and sales order templates.

## Functional process 
This table supports the "Quote-to-Order" configuration process. It manages the association between specific quotation document layouts (headers/footers) and predefined sales order templates, ensuring that the correct branding or legal boilerplate is applied when generating sales documentation.

## Description
One row in this table represents a single association between a quotation document and a sales order template. It serves as a raw landing join table in the staging layer, facilitating the resolution of many-to-many relationships between document definitions and order templates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document definition. | Part of the composite primary key. |
| sale_order_template_id | INTEGER | false | Foreign key to the sales order template. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(quotation_document_id, sale_order_template_id)`
- **Foreign keys (inferred):** 
    - `quotation_document_id` → `quotation_document.id` (Inferred from naming convention).
    - `sale_order_template_id` → `sale_order_template.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure joins to parent tables handle potential orphans if the source system does not enforce strict referential integrity at the database level.