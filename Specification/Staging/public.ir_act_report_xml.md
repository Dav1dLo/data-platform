# ir_act_report_xml

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_act_*` is characteristic of Odoo's "Ir Actions" (Ir = Ir_actions_report_xml) framework, which manages report definitions, print templates, and their associated models within the Odoo metadata layer.

## Functional process 
This table supports the report configuration and generation pipeline. It stores the technical definitions for XML-based reports, including the target data models, file paths for report templates, paper format configurations, and visibility settings for the user interface.

## Description
One row in this table represents a single report definition or action configured within the Odoo system. It acts as a raw landing copy of the report metadata, defining how specific business objects (e.g., invoices, sales orders) are rendered into documents. The grain is one row per report action definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to target model | Links the report to a specific Odoo model ID. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the report record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| type | VARCHAR | false | Action type | Defines the Odoo action category. |
| path | VARCHAR | true | Template path | File system or module path to the report template. |
| binding_type | VARCHAR | false | Binding category | Determines where the report appears in the UI (e.g., 'action', 'report'). |
| binding_view_types | VARCHAR | true | View types | Comma-separated list of views where this report is available. |
| name | JSONB | false | Report display name | Multi-language label for the report. |
| help | JSONB | true | Help text | Multi-language tooltip or description. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| paperformat_id | INTEGER | true | Paper format ID | Links to a specific paper format configuration. |
| model | VARCHAR | false | Target model name | The technical name of the Odoo model (e.g., 'account.move'). |
| report_type | VARCHAR | false | Rendering engine | The type of report (e.g., 'qweb-pdf', 'qweb-html'). |
| report_name | VARCHAR | false | Internal report name | The technical identifier used to invoke the report. |
| report_file | VARCHAR | true | Template filename | The specific file used for rendering. |
| attachment | VARCHAR | true | Attachment expression | Python expression for naming generated attachments. |
| domain | VARCHAR | true | Filter domain | A string-encoded domain filter for report visibility. |
| print_report_name | JSONB | true | Print filename pattern | Multi-language expression for the generated file name. |
| multi | BOOLEAN | true | Multi-record flag | Indicates if the report can be run on multiple selected records. |
| attachment_use | BOOLEAN | true | Attachment storage flag | If true, generated reports are stored as attachments. |
| is_invoice_report | BOOLEAN | true | Invoice flag | Boolean indicator if this is specifically an invoice report. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id` (Guess: links to the Odoo model registry).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `paperformat_id` → `report_paperformat.id` (Guess: links to report layout settings).
- **Natural keys (inferred):** 
    - `report_name` (The technical identifier is typically unique within the Odoo system).

## Caveats for downstream consumers

- **JSONB Columns:** The `name`, `help`, and `print_report_name` columns contain JSONB data, likely storing translations (e.g., `{"en_US": "Invoice", "fr_FR": "Facture"}`). Use `->>` to extract values.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement soft deletes; it reflects the current state of the Odoo `ir_act_report_xml` table.
- **Sensitive Data:** No direct PII is stored, but the `domain` and `attachment` columns contain executable Python-like expressions which should be treated as code/logic rather than raw data.