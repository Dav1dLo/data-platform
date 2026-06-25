# quotation_document_sale_pdf_form_field_rel

## Source system
The table likely originates from a custom-built document management or sales automation system. The naming convention suggests a relational mapping table used to link specific quotation documents to the dynamic form fields contained within their corresponding PDF templates.

## Functional process 
This table supports the document generation and sales quoting process. It acts as a bridge to track which specific form fields are populated or associated with a particular quotation document, ensuring that data mapped from the CRM or ERP system is correctly injected into the final PDF output.

## Description
This table represents a many-to-many relationship between quotation documents and PDF form fields. Each row defines a single association, indicating that a specific form field is present or required for a given quotation document. As a staging table, it serves as a raw, normalized link between the document entity and the form field definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document | Links to the parent document record. |
| sale_pdf_form_field_id | INTEGER | false | Foreign key to the PDF form field definition | Identifies the specific field within the PDF template. |

## Keys

- **Primary key (inferred):** The composite of (`quotation_document_id`, `sale_pdf_form_field_id`).
- **Foreign keys (inferred):**
    - `quotation_document_id` → `quotation_document.id` (Inferred based on naming convention).
    - `sale_pdf_form_field_id` → `sale_pdf_form_field.id` (Inferred based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns, so incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- The table assumes referential integrity is managed at the source; ensure that downstream joins handle potential orphaned records if the source system does not enforce strict foreign key constraints.