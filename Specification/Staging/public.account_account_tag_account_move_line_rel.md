# account_account_tag_account_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific join table structure between `account_move_line` and `account_account_tag` is characteristic of Odoo's ORM-generated many-to-many relationship tables.

## Functional process 
This table supports the financial reporting and accounting categorization process. It maps specific accounting journal entries (`account_move_line`) to analytical or reporting tags (`account_account_tag`), allowing for multi-dimensional financial analysis beyond the standard chart of accounts.

## Description
One row in this table represents a single association between an accounting journal entry line and a specific account tag. It serves as a raw, junction table in the staging layer, facilitating the many-to-many relationship required to categorize financial transactions for reporting purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the journal entry line | References the specific line item in a ledger entry. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag | References the tag used for financial categorization. |

## Keys

- **Primary key (inferred):** The composite of `(account_move_line_id, account_account_tag_id)`.
- **Foreign keys (inferred):** 
    - `account_move_line_id` → `account_move_line.id`: This column links the relationship to the specific transaction line item.
    - `account_account_tag_id` → `account_account_tag.id`: This column links the relationship to the defined reporting tag.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables for temporal context.
- Ensure inner joins are used when filtering by tag, as this table only contains active associations.