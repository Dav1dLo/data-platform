# account_move_account_resequence_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific module-related entities `account_resequence_wizard` and `account_move` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link wizard session data with specific accounting entries.

## Functional process 
This table supports the "Accounting Resequencing" process, which allows users to re-number or re-sequence accounting entries (moves) in bulk. It acts as a join table to track which specific accounting moves are currently associated with a particular resequencing wizard session.

## Description
One row in this table represents a single association between an accounting resequence wizard instance and an accounting move. It is a raw landing copy of the join table used to maintain the many-to-many relationship between the wizard session and the target records during the resequencing workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_resequence_wizard_id | INTEGER | false | Foreign key to the resequence wizard session | Links to the parent wizard record. |
| account_move_id | INTEGER | false | Foreign key to the accounting move | Links to the specific ledger entry being resequenced. |

## Keys

- **Primary key (inferred):** The combination of `account_resequence_wizard_id` and `account_move_id`.
- **Foreign keys (inferred):** 
    - `account_resequence_wizard_id` → `account_resequence_wizard.id`: This column references the wizard session configuration.
    - `account_move_id` → `account_move.id`: This column references the specific accounting entry record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns; this table is purely structural.
- Expect high churn in this table as wizard sessions are typically short-lived and records are likely deleted once the resequencing process is completed or the wizard is closed.