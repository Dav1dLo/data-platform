# stock_quant_stock_quant_relocate_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_quant` and `stock_quant_relocate` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link inventory quantification records with relocation events.

## Functional process 
This table supports the inventory management and warehouse logistics process. It acts as a join table to associate specific inventory stock quant records with relocation operations, enabling the system to track which physical stock items are involved in a specific warehouse movement or relocation task.

## Description
One row represents a single association between a stock quantity record and a relocation event. This is a raw landing table in the staging layer, serving as a link table to resolve the many-to-many relationship between inventory quants and relocation operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_quant_relocate_id | INTEGER | false | Foreign key to the relocation event | Links to the primary key of the relocation operation. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the primary key of the specific inventory quant. |

## Keys

- **Primary key (inferred):** The combination of `(stock_quant_relocate_id, stock_quant_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `stock_quant_relocate_id` → `stock_quant_relocate.id`: This column references the relocation operation header.
    - `stock_quant_id` → `stock_quant.id`: This column references the specific inventory quant record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to the parent tables (`stock_quant` and `stock_quant_relocate`) handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.