# account_tax_filiation_rel

## Source system
The source system is likely an ERP or accounting platform (such as Odoo or a similar modular business suite), given the naming convention `filiation_rel` which typically denotes a recursive relationship or hierarchy table used to manage tax structures or parent-child tax groupings.

## Functional process 
This table supports the tax configuration and reporting process by defining hierarchical relationships between tax entities. It is used to map how specific tax components (child taxes) roll up into or are associated with a parent tax structure, facilitating complex tax calculations or consolidated reporting.

## Description
One row in this table represents a single directed relationship between a parent tax entity and a child tax entity. As a staging table, it serves as a raw, normalized link table representing the structural hierarchy of the tax system as extracted from the source application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| parent_tax | INTEGER | false | The identifier of the parent tax entity. | Likely a foreign key to a master tax table. |
| child_tax | INTEGER | false | The identifier of the child tax entity. | Likely a foreign key to a master tax table. |

## Keys

- **Primary key (inferred):** The composite of (`parent_tax`, `child_tax`).
- **Foreign keys (inferred):** 
    - `parent_tax` → `account_tax.id` (guess: represents the parent node in the tax hierarchy).
    - `child_tax` → `account_tax.id` (guess: represents the child node in the tax hierarchy).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table represents a recursive relationship; ensure queries handle potential circular references if the source data is not strictly validated.
- There are no timestamps or audit columns provided; it is impossible to determine the temporal validity or ingestion sequence of these relationships.
- The table is purely structural; it contains no descriptive attributes, only identifiers.