# account_move_line_account_tax_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `account_move_line_account_tax_rel` is a standard pattern used by Odoo to represent many-to-many relationship tables (often suffixed with `_rel`) between accounting journal items (`account_move_line`) and tax definitions (`account_tax`).

## Functional process 
This table supports the financial accounting and tax reporting process. It acts as a junction table to associate specific tax rates or tax groups with individual line items in a journal entry, ensuring that tax calculations are correctly linked to the underlying accounting transactions.

## Description
One row in this table represents a single association between a specific journal line item and a tax record. It serves as a raw landed link table in the staging layer, enabling the reconstruction of tax applications for financial reporting and audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the journal line item | Links to the specific accounting transaction line. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the specific tax rule applied to the line. |

## Keys

- **Primary key (inferred):** The combination of `(account_move_line_id, account_tax_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_move_line_id` → `account_move_line.id`: This column references the primary key of the journal line items table.
    - `account_tax_id` → `account_tax.id`: This column references the primary key of the tax definitions table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect multiple rows per `account_move_line_id` if a single line item is subject to multiple taxes.
- There is no surrogate primary key; always join or filter using the composite key.
- As a staging table, this represents a raw snapshot of the relationship; ensure referential integrity is validated against the source system if performing complex joins.