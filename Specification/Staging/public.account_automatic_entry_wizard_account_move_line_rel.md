# account_automatic_entry_wizard_account_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific prefix `account_automatic_entry_wizard` is characteristic of Odoo's many-to-many relationship tables, which link wizard-based automation tools to specific ledger entries.

## Functional process 
This table supports the "Automatic Entry" wizard process in the accounting module, which allows users to automate the creation of adjusting entries (such as deferrals or accruals) across multiple existing journal items. It acts as a join table to associate specific journal lines with a particular execution instance of the automation wizard.

## Description
One row in this table represents a single link between an automatic entry wizard instance and a specific accounting move line. It serves as a raw landing copy of the relationship mapping used during the execution of automated accounting adjustments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_automatic_entry_wizard_id | INTEGER | false | Foreign key to the wizard instance | Links to the configuration/execution record of the wizard. |
| account_move_line_id | INTEGER | false | Foreign key to the journal line | Identifies the specific ledger entry being processed. |

## Keys

- **Primary key (inferred):** The combination of `(account_automatic_entry_wizard_id, account_move_line_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_automatic_entry_wizard_id` → `account_automatic_entry_wizard.id`: This column references the parent wizard record.
    - `account_move_line_id` → `account_move_line.id`: This column references the specific accounting journal entry line.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table; it is strictly a structural mapping.
- As a staging table, it should be joined with the corresponding master tables (`account_automatic_entry_wizard` and `account_move_line`) to derive meaningful business context.