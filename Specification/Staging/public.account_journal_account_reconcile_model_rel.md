# account_journal_account_reconcile_model_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_journal` and `account_reconcile_model` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link journals to reconciliation models.

## Functional process 
This table supports the accounting reconciliation process. It defines the many-to-many relationship between accounting journals (where transactions are recorded) and reconciliation models (which provide rules for automating the matching of bank statement lines to journal items).

## Description
Each row represents a single association between an accounting journal and a reconciliation model, enabling the application of specific reconciliation rules to specific journals. This is a raw landing of a join table in the staging layer, representing the link between the two entities at the time of extraction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model definition. | Links to the primary key of the reconciliation model table. |
| account_journal_id | INTEGER | false | Foreign key to the accounting journal definition. | Links to the primary key of the journal table. |

## Keys

- **Primary key (inferred):** The composite key `(account_reconcile_model_id, account_journal_id)`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: This column references the definition of the reconciliation model.
    - `account_journal_id` → `account_journal.id`: This column references the specific accounting journal.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the history of these relationships from this table alone.
- Ensure that joins to the parent tables (`account_reconcile_model` and `account_journal`) are handled as inner joins if you only require active associations.