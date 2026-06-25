# pos_daily_sales_reports_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`pos_daily_sales_reports_wizard_id_seq`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the "wizard" suffix, which is characteristic of Odoo's transient model architecture used for user-driven reporting interfaces.

## Functional process 
This table supports the Point of Sale (POS) reporting process. It acts as a transient configuration store for a wizard interface that allows users to generate daily sales summaries, specifically controlling whether reports should be segmented by individual employees.

## Description
One row in this table represents a single configuration instance for a POS daily sales report generation task. It is a staging-layer record that captures the user's preferences (such as employee-level granularity) before the report is processed. This table is likely a transient model used to pass parameters between the UI and the backend reporting engine.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing. |
| pos_session_id | INTEGER | false | Foreign key to the POS session | Identifies the specific session being reported on. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the report. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the wizard settings. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |
| add_report_per_employee | BOOLEAN | true | Toggle for employee-level reporting | If true, the generated report will break down sales by staff member. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_session_id` → `pos_session.id` (Guess: Standard Odoo naming convention for POS session linkage).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column for user tracking).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Transient Nature:** As a "wizard" table, records here may be ephemeral and subject to periodic cleanup or truncation by the source system.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** There is no explicit soft-delete flag; however, Odoo transient models are often cleared automatically after the wizard task completes.
- **Sensitivity:** `create_uid` and `write_uid` link to user identity tables; ensure appropriate access controls are applied if joining with user metadata.