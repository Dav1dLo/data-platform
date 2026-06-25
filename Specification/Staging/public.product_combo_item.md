# product_combo_item

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the product configuration and bundling process, specifically managing the relationship between product combos and their constituent items. It tracks which individual products are included in a specific combo and any associated price adjustments (`extra_price`) applied when that item is selected.

## Description
One row represents a single product component assigned to a specific product combo. This is a raw landed staging table, serving as a direct reflection of the source system's relational link between combo headers and product items.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :---