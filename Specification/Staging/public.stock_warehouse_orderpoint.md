# stock_warehouse_orderpoint

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `write_uid`, `create_uid`, `write_date`, and the specific pattern of `orderpoint` (reordering rules) associated with `warehouse_id` and `product_id`.

## Functional process 
This table supports the inventory replenishment and procurement process. It defines the "reordering rules" (or min-max rules) that trigger automatic stock replenishment requests (purchase orders or manufacturing orders) when the inventory level of a specific product at a specific location falls below the defined minimum quantity.

## Description
One row in this table represents a single reordering rule for a specific product within a designated warehouse location. It acts as a raw landed copy of the Odoo `stock.warehouse.orderpoint` model, capturing the thresholds and triggers used by the automated replenishment engine to maintain stock levels.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_warehouse_orderpoint_id_seq` |
| warehouse_id | INTEGER | false | Foreign key to the warehouse | |
| location_id | INTEGER | false | Foreign key to the stock location | |
| product_id | INTEGER | false | Foreign key to the product | |
| product_category_id | INTEGER | true | Foreign key to product category | |
| group_id | INTEGER | true | Foreign key to procurement group | |
| company_id | INTEGER | false | Foreign key to the owning company | |
| route_id | INTEGER | true | Foreign key to the replenishment route | |
| create_uid | INTEGER | true | User ID who created the record | |
| write_uid | INTEGER | true | User ID who last modified the record | |
| name | VARCHAR | false | Rule name or reference code | |
| trigger | VARCHAR | false | Trigger type (e.g., 'auto', 'manual') | |
| snoozed_until | DATE | true | Date until which the rule is ignored | |
| product_min_qty | NUMERIC | false | Minimum stock threshold | |
| product_max_qty | NUMERIC | false | Maximum stock threshold | |
| qty_multiple | NUMERIC | false | Quantity multiple for replenishment | |
| qty_to_order_manual | NUMERIC | true | Manual override for order quantity | |
| active | BOOLEAN | true | Soft-delete flag | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last modification timestamp | |
| bom_id | INTEGER | true | Foreign key to Bill of Materials | |
| manufacturing_visibility_days | DOUBLE PRECISION | true | Days to look ahead for manufacturing | |
| supplier_id | INTEGER | true | Foreign key to the supplier | |
| vendor_id | INTEGER | true | Foreign key to the vendor | |
| product_supplier_id | INTEGER | true | Foreign key to product-supplier link | |
| purchase_visibility_days | DOUBLE PRECISION | true | Days to look ahead for purchasing | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `warehouse_id` → `stock_warehouse.id` (Inferred from Odoo standard schema)
    - `location_id` → `stock_location.id` (Inferred from Odoo standard schema)
    - `product_id` → `product_product.id` (Inferred from Odoo standard schema)
    - `company_id` → `res_company.id` (Inferred from Odoo standard schema)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical audits.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo environments.
- **Sensitivity:** This table contains operational configuration data; while not containing PII, it reflects internal supply chain logic and procurement strategies.
- **Data Grain:** This is a configuration table; changes to these values directly impact automated procurement behavior. Ensure joins to transaction tables account for the `write_date` if point-in-time analysis is required.