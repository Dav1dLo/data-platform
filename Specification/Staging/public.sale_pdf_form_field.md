# sale_pdf_form_field

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo models.

## Functional process 
This table supports the document management or sales automation process, specifically tracking the mapping or configuration of fields within PDF forms used for sales documentation. It likely facilitates the dynamic population of sales contracts or order confirmations by linking specific form fields to internal data paths.

## Description
One row represents a single configurable field within a PDF document template used by the sales department. This is a raw staging table containing metadata about form field definitions, including their location or identifier (`path`) and the document category they belong to (`document_type`).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.sale_pdf_form_field_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| name | VARCHAR | false | Name of the form field | The label or identifier for the field. |
| document_type | VARCHAR | false | Category of the PDF document | Used to group fields by document purpose. |
| path | VARCHAR | true | XPath or internal reference path | The technical location of the field within the PDF structure. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** 
    - `name` + `document_type` (likely unique combination for identifying a field within a specific document template).

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard PostgreSQL/Odoo practices.
- The `path` column may contain technical strings (e.g., XPath expressions) that require parsing before use in downstream reporting.
- There is no explicit soft-delete flag; assume records are hard-deleted if missing, or check for the absence of `write_date` updates.
- This table is in the Staging layer; expect raw data types and potential inconsistencies in string formatting for `name` and `document_type`.