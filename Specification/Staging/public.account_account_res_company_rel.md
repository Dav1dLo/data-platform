# account_account_res_company_rel

## Source system
The table naming convention `account_account_res_company_rel` strongly indicates an Odoo ERP system. In Odoo, `_rel` tables are standard join tables used to manage many-to-many relationships between core entities, specifically linking accounting accounts to company entities.

## Functional process 
This table supports the multi-company accounting configuration process. It defines the scope of availability for specific general ledger accounts across different company entities within the ERP, ensuring that financial reporting and transaction posting are restricted to the correct organizational units.

## Description
One row in this table represents a single association between a specific general ledger account and a company entity. It serves as a raw landing copy of the many-to-many relationship mapping, facilitating the enforcement of company-specific accounting structures.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | Maps to the primary key of the account_account table. |
| res_company_id | INTEGER | false | Foreign key to the company definition | Maps to the primary key of the res_company table. |

## Keys

- **Primary key (inferred):** The composite of (`account_account_id`, `res_company_id`).
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: Links to the specific general ledger account definition.
    - `res_company_id` → `res_company.id`: Links to the specific company entity definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- There are no soft-delete flags; if a row is absent, the relationship is considered non-existent in the source system.
- Ensure joins to parent tables handle the integer IDs as standard primary keys.