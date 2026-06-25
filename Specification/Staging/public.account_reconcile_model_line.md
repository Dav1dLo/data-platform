# account_reconcile_model_line

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (e.g., `account_reconcile_model_line`, `create_uid`, `write_date`, `analytic_distribution`) and the use of PostgreSQL sequences for primary keys.

## Functional process 
This table supports the automated bank reconciliation process within the accounting module. It defines the specific line-item rules or templates used to match bank statement lines against general ledger entries, including how amounts are calculated, which accounts are impacted, and how analytic distributions are applied.

## Description
One row in this table represents a single rule or line configuration associated with a reconciliation model. It acts as a raw landed copy of the Odoo configuration entity, capturing the logic for how specific financial amounts or labels should be processed during bank statement reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_reconcile_model_line_id_seq`. |
| model_id | INTEGER | true | Foreign key to the parent reconciliation model | Links to the header configuration. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization owning this rule. |
| sequence | INTEGER | false | Sort order for rule application | Determines priority when multiple rules match. |
| account_id | INTEGER | true | Foreign key to the general ledger account | The account to be posted to. |
| journal_id | INTEGER | true | Foreign key to the accounting journal | The journal associated with this line. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| amount_type | VARCHAR | false | Type of amount calculation | e.g., 'fixed', 'percentage', 'regex'. |
| amount_string | VARCHAR | false | Expression or value for the amount | Used in conjunction with `amount_type`. |
| analytic_distribution | JSONB | true | Analytic accounting distribution | Stores JSON mapping for cost centers/projects. |
| label | JSONB | true | Label configuration | JSON structure for matching or generating labels. |
| force_tax_included | BOOLEAN | true | Tax inclusion flag | Indicates if tax is forced as included. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| amount | DOUBLE PRECISION | true | Fixed amount value | Used if `amount_type` is fixed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `model_id` → `account_reconcile_model.id` (Links to the parent reconciliation model definition).
    - `company_id` → `res_company.id` (Links to the owning entity).
    - `account_id` → `account_account.id` (Links to the target ledger account).
    - `journal_id` → `account_journal.id` (Links to the target journal).
    - `create_uid` / `write_uid` → `res_users.id` (Links to the system users).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Sensitivity:** The `analytic_distribution` and `label` columns contain JSONB data which may include internal business logic or references to sensitive cost centers.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **JSONB Usage:** Queries filtering on `analytic_distribution` or `label` will require PostgreSQL JSONB operators (e.g., `->>`, `@>`).