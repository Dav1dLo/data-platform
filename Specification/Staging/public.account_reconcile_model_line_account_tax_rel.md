# account_reconcile_model_line_account_tax_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_reconcile_model_line` and `account_tax` is characteristic of Odoo's many-to-many relationship tables, which are used to link reconciliation model lines to applicable tax definitions.

## Functional process 
This table supports the automated bank reconciliation process. It defines the many-to-many relationship between reconciliation model lines (which dictate how to handle specific bank statement items) and the tax accounts that should be applied to those transactions during the reconciliation workflow.

## Description
One row in this table represents a single association between a specific reconciliation model line and a tax record. It acts as a join table in the staging layer, providing a raw, un-transformed link between the reconciliation logic and tax configuration entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_line_id | INTEGER | false | Foreign key to the reconciliation model line | Links to the parent configuration line. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Identifies the specific tax applied. |

## Keys

- **Primary key (inferred):** The combination of `account_reconcile_model_line_id` and `account_tax_id`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_line_id` → `account_reconcile_model_line.id`: This column references the configuration line governing reconciliation rules.
    - `account_tax_id` → `account_tax.id`: This column references the master tax definition table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; assume this table reflects the current state of relationships as extracted from the source.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.