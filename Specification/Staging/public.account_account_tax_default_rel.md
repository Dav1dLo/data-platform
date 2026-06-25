# account_account_tax_default_rel

## Source system
This table likely originates from an Odoo or similar ERP system, as indicated by the `_rel` suffix and the naming convention `account_account_tax_default_rel`, which is characteristic of many-to-many relationship tables in Odoo's PostgreSQL schema.

## Functional process 
This table supports the financial configuration and tax automation process. It defines the default tax rates that should be automatically applied to specific general ledger accounts, ensuring that when a journal entry is created for a given account, the associated tax is suggested or applied by default.

## Description
One row in this table represents a single association between a general ledger account and a default tax rate. It acts as a bridge table to resolve a many-to-many relationship, allowing multiple default taxes to be assigned to an account or a single tax to be associated with multiple accounts. This is a raw landed copy of the relationship mapping from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_id | INTEGER | false | Foreign key to the account definition | References the primary key of the account table. |
| tax_id | INTEGER | false | Foreign key to the tax definition | References the primary key of the tax table. |

## Keys

- **Primary key (inferred):** The composite of (`account_id`, `tax_id`).
- **Foreign keys (inferred):** 
    - `account_id` → `account_account.id`: This column links to the master list of general ledger accounts.
    - `tax_id` → `account_tax.id`: This column links to the master list of tax definitions.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should join on the composite key (`account_id`, `tax_id`).
- There are no timestamps or audit columns; it is impossible to determine the history of these relationships or when they were created/modified.
- This is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure that joins to the `account` or `tax` tables handle potential missing records if the source system has referential integrity gaps.