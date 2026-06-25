# product_category

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `complete_name`, `parent_path`, and the extensive use of `JSONB` for property fields) is characteristic of Odoo's internal ORM structure for managing hierarchical product categories and their associated accounting/valuation rules.

## Functional process 
This table supports the product catalog management and inventory accounting configuration process. It defines the hierarchical structure of product categories, which dictates how products are grouped, how their costs are calculated, and which general ledger accounts are automatically triggered during inventory movements or sales/purchases.

## Description
One row represents a single category within the product hierarchy, which may contain sub-categories or be a leaf node. This is a raw landed staging table containing the full configuration state, including recursive pathing and complex JSONB-encoded accounting properties. It serves as the primary source for mapping products to their respective financial and operational behaviors.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_category_id_seq`. |
| parent_id | INTEGER | true | Self-referencing foreign key to parent category | Null if top-level category. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| name | VARCHAR | false | Display name of the category | |
| complete_name | VARCHAR | true | Full hierarchical path name | e.g., "All / Saleable / Office Furniture". |
| parent_path | VARCHAR | true | Materialized path for tree traversal | Used for efficient recursive queries. |
| product_properties_definition | JSONB | true | Custom attribute definitions | Schema for dynamic product fields. |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last modification timestamp | |
| property_account_income_categ_id | JSONB | true | Default income account for category | JSONB likely stores a reference ID. |
| property_account_expense_categ_id | JSONB | true | Default expense account for category | |
| removal_strategy_id | INTEGER | true | Inventory removal strategy ID | References `product_removal_strategy`. |
| packaging_reserve_method | VARCHAR | true | Strategy for packaging reservation | |
| property_valuation | JSONB | true | Inventory valuation method | |
| property_cost_method | JSONB | true | Costing method (e.g., FIFO, AVCO) | |
| property_stock_journal | JSONB | true | Default stock journal | |
| property_stock_account_input_categ_id | JSONB | true | Stock input account | |
| property_stock_account_output_categ_id | JSONB | true | Stock output account | |
| property_stock_valuation_account_id | JSONB | true | Stock valuation account | |
| property_stock_account_production_cost_id | JSONB | true | Production cost account | |
| property_account_creditor_price_difference_categ | JSONB | true | Price difference account | |
| property_account_downpayment_categ_id | JSONB | true | Downpayment account | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `product_category.id`: Defines the tree structure of the categories.
    - `create_uid` / `write_uid` → `res_users.id`: Tracks administrative ownership of the record.
    - `removal_strategy_id` → `product_removal_strategy.id`: Links to inventory logic configurations.
- **Natural keys (inferred):** 
    - `complete_name`: In Odoo, the full path name is typically unique and used as a business identifier.

## Caveats for downstream consumers

- **JSONB Complexity:** Many columns (prefixed `property_`) store references as JSONB objects. These often contain a list or a dictionary where the actual ID is nested (e.g., `[id, name]`). You will likely need to use `->>` or `jsonb_extract_path_text` to extract the underlying integer IDs for joins.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., "1/5/12"). Use this for efficient hierarchical filtering (e.g., `WHERE parent_path LIKE '1/%'`) rather than recursive CTEs if performance is a concern.
- **Soft Deletes:** This table does not appear to use a `deleted_at` flag; records are typically hard-deleted in the source system.