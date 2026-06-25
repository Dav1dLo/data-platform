# base_document_layout

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is highly characteristic of the Odoo framework's internal ORM structure.

## Functional process 
This table supports the document management and reporting configuration process. It tracks the association between specific document layouts and companies, likely used to determine which visual templates or report configurations are applied when generating documents like invoices or purchase orders.

## Description
One row in this table represents a specific document layout configuration assigned to a company entity. It serves as a raw landed copy of the Odoo `base.document.layout` model, capturing the metadata and audit trails for report layout settings within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `base_document_layout_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization owning this layout. |
| report_layout_id | INTEGER | true | Foreign key to report layout | Links to the specific report template definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unspecified. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unspecified. |
| from_invoice | BOOLEAN | true | Invoice source flag | Indicates if the layout is derived from or specific to invoices. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `report_layout_id` → `ir_actions_report.id` (Likely links to the report action definition).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail for user actions).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored as timestamps; assume UTC unless the source system configuration specifies otherwise.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless Odoo's internal `active` column (not present here) is missing.
- **Data Integrity:** `report_layout_id` is nullable, implying some layouts may be defined at a global level or are currently unassigned.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs and will require a join to the `res_users` table to resolve to human-readable names.