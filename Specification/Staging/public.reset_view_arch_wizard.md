# reset_view_arch_wizard

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM. The table name suggests it is part of a wizard or temporary configuration process for resetting view architectures.

## Functional process 
This table supports the "View Customization and Reset" process, likely used by the UI to track the state of a wizard that allows users to revert or compare view architecture changes. It captures the parameters of a reset operation, linking a primary view to a comparison view and defining the reset mode.

## Description
One row in this table represents a single execution or configuration state of a view architecture reset wizard. It serves as a staging record to track which views are being compared or reset and by which user, acting as a transient record for the duration of the wizard process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `reset_view_arch_wizard_id_seq`. |
| view_id | INTEGER | true | Target view identifier | Foreign key to the view being reset. |
| compare_view_id | INTEGER | true | Comparison view identifier | Foreign key to the view used for comparison. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the wizard record. |
| reset_mode | VARCHAR | false | Reset operation mode | Defines the logic applied during the reset. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (guess: standard Odoo view table).
    - `compare_view_id` → `ir_ui_view.id` (guess: standard Odoo view table).
    - `create_uid` → `res_users.id` (guess: standard Odoo user table).
    - `write_uid` → `res_users.id` (guess: standard Odoo user table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user directories to identify individuals.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** As a "wizard" table, records may be transient or intended for deletion after the reset process completes; check for high volumes of short-lived records.
- **Nullability:** Many fields are nullable, suggesting that not all wizard configurations require both a `view_id` and a `compare_view_id` depending on the `reset_mode`.