# account_report_external_value

## Source system
The table likely originates from an Odoo ERP system, indicated by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework, as well as the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the financial reporting and tax compliance process, specifically managing external values or manual overrides used in report expressions. It facilitates the calculation of complex financial statements by allowing users to input or carry over specific values (e.g., VAT fiscal positions or carryover report lines) that are not automatically derived from standard ledger entries.

## Description
One row in this table represents a single external data point or manual adjustment associated with a specific financial report expression for a given company. It serves as a staging entity that captures supplemental data required to complete financial or tax reports. The grain of the table is one row per external value entry per report expression per company.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard PostgreSQL sequence. |
| target_report_expression_id | INTEGER | false | Foreign key to the report expression definition | Links to the specific line item or formula in a report. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity the value belongs to. |
| foreign_vat_fiscal_position_id | INTEGER | true | Foreign key to VAT fiscal position | Used for cross-border tax reporting adjustments. |
| carryover_origin_report_line_id | INTEGER | true | Foreign key to source report line | Tracks the origin of carried-over financial values. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Descriptive label for the value | Human-readable identifier for the entry. |
| text_value | VARCHAR | true | Text-based supplemental data | Used if the report value is non-numeric. |
| carryover_origin_expression_label | VARCHAR | true | Label of the source expression | Provides context for carryover values. |
| date | DATE | false | Effective date of the value | The business date for the report entry. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | In UTC. |
| value | DOUBLE PRECISION | true | Numeric value | The actual financial amount being reported. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `target_report_expression_id` → `account_report_expression.id` (Inferred from naming convention).
    - `company_id` → `res_company.id` (Standard Odoo pattern).
    - `foreign_vat_fiscal_position_id` → `account_fiscal_position.id` (Inferred from naming convention).
    - `carryover_origin_report_line_id` → `account_report_line.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `company_id` and potentially sensitive financial reporting values; ensure appropriate access controls.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all rows are active unless otherwise specified by the source system logic.
- **Data Quality:** The `value` column is nullable, as some entries may only contain `text_value` depending on the report expression type.