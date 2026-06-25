# account_tax_sale_order_discount_rel

## Source system
The table appears to originate from an ERP or accounting system, likely Odoo or a similar modular business management platform. The naming convention `_rel` is characteristic of join tables used to manage many-to-many relationships between tax configurations and discount applications within sales order processing modules.

## Functional process 
This table supports the tax calculation and discount application logic within the order-to-cash pipeline. It explicitly maps specific tax rules (represented by `account_tax_id`) to discount records (represented by `sale_order_discount_id`) associated with sales orders, ensuring that tax liabilities are correctly calculated based on the net value after discounts.

## Description
One row in this table represents a single association between a tax definition and a discount applied to a sales order. It serves as a raw, junction-table copy from the source system, facilitating the resolution of many-to-many relationships between tax entities and discount entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_discount_id | INTEGER | false | Foreign key to the sales order discount record | Represents the specific discount instance applied to an order. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition record | Represents the tax rule or rate applied to the discounted line. |

## Keys

- **Primary key (inferred):** The combination of `(sale_order_discount_id, account_tax_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `sale_order_discount_id` → `sale_order_discount.id`: Guessed based on the column name prefix matching a standard discount entity.
    - `account_tax_id` → `account_tax.id`: Guessed based on the column name matching standard accounting tax configuration tables.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect high cardinality and frequent joins to parent entities.
- There are no audit timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure referential integrity is validated during transformation, as staging tables may contain orphaned records if the source system's extraction logic is not perfectly synchronized.