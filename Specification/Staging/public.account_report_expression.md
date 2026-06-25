# account_report_expression

## Source system
This table originates from Odoo (ERP), as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific structure of report-related configuration tables common in the Odoo financial reporting engine.

## Functional process 
This table supports the financial reporting configuration process, specifically defining the mathematical expressions and logic used to calculate lines within custom financial reports. It maps report line definitions to specific formulas, engines, and formatting rules (e.g., `green_on_positive`, `blank_if_zero`) used to generate balance sheets or profit and loss statements.

## Description
One row represents a single expression or calculation rule assigned to a specific report line. It serves as a raw landed copy of the configuration metadata from the source ERP, capturing the logic required to compute financial figures at the grain of an individual report expression.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_report_expression_id_seq`. |
| report_line_id | INTEGER | false | Foreign key to the parent report line | Links this expression to a specific line in a report. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| label | VARCHAR | false | Display label for the expression | Used as the description in the report. |
| engine | VARCHAR | false | Calculation engine identifier | Determines how the formula is parsed. |
| formula | VARCHAR | false | The mathematical expression | The core logic string for the calculation. |
| subformula | VARCHAR | true | Secondary formula logic | Optional modifier for the primary formula. |
| date_scope | VARCHAR | false | Temporal scope of the calculation | Defines the date range logic (e.g., 'to_date', 'from_date'). |
| figure_type | VARCHAR | true | Data type of the result | e.g., 'float', 'percentage', 'integer'. |
| carryover_target | VARCHAR | true | Target for carryover logic | Used for balance sheet carryover calculations. |
| green_on_positive | BOOLEAN | true | Conditional formatting flag | If true, positive values are displayed in green. |
| blank_if_zero | BOOLEAN | true | Display suppression flag | If true, hides the value if it equals zero. |
| auditable | BOOLEAN | true | Audit requirement flag | Indicates if this expression is subject to audit logs. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_line_id` → `account_report_line.id` (Guess: Standard Odoo naming convention for parent-child relationships in reporting modules).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains configuration logic rather than transactional financial data; changes here will alter how reports are calculated globally.
- No explicit soft-delete flag is present; records are likely hard-deleted or managed via status flags not present in this table.
- The `formula` column contains raw logic strings that may require specific parsing logic depending on the `engine` defined in the row.