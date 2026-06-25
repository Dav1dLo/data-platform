# stock_location

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `parent_path`, and the specific pattern of `_id` foreign key references common to the Odoo ORM.

## Functional process 
This table supports the Warehouse Management System (WMS) inventory process, specifically managing the physical or logical structure of stock locations. It tracks the hierarchy of storage areas, inventory counting schedules, and accounting integration for stock valuation.

## Description
One row represents a single storage location within a warehouse, which can be a physical shelf, a bin, or a logical location like a transit or scrap area. This table serves as a raw staging copy of the Odoo `stock.location` model, capturing the configuration, spatial coordinates, and inventory management settings for each location.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| location_id | INTEGER | true | Parent location reference | Self-referencing FK to create hierarchy. |
| posx | INTEGER | true | X-coordinate in warehouse | Used for spatial mapping. |
| posy | INTEGER | true | Y-coordinate in warehouse | Used for spatial mapping. |
| posz | INTEGER | true | Z-coordinate in warehouse | Used for spatial mapping. |
| company_id | INTEGER | true | Owning company ID | Links location to a specific entity. |
| removal_strategy_id | INTEGER | true | Inventory removal strategy | Defines FIFO/LIFO/FEFO logic. |
| cyclic_inventory_frequency | INTEGER | true | Inventory cycle count interval | Days between inventory checks. |
| warehouse_id | INTEGER | true | Parent warehouse ID | Links location to a physical warehouse. |
| storage_category_id | INTEGER | true | Storage category ID | Classification for storage rules. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for last update. |
| name | VARCHAR | false | Location name | Short identifier for the location. |
| complete_name | VARCHAR | true | Full hierarchical path name | Denormalized path (e.g., WH/Stock/Shelf1). |
| usage | VARCHAR | false | Location type | e.g., internal, transit, supplier, customer. |
| parent_path | VARCHAR | true | Materialized path | Used for efficient tree traversal. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning operations. |
| last_inventory_date | DATE | true | Last inventory count date | Date of the most recent audit. |
| next_inventory_date | DATE | true | Scheduled inventory date | Date for the next planned audit. |
| comment | TEXT | true | Internal notes | Free-text description. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the location is archived. |
| scrap_location | BOOLEAN | true | Scrap location indicator | If true, items here are considered lost/scrapped. |
| replenish_location | BOOLEAN | true | Replenishment indicator | If true, location is used for replenishment. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |
| valuation_in_account_id | INTEGER | true | Stock input account ID | Accounting integration for incoming stock. |
| valuation_out_account_id | INTEGER | true | Stock output account ID | Accounting integration for outgoing stock. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `location_id` → `stock_location.id` (Self-referencing parent-child relationship).
    - `company_id` → `res_company.id` (Likely target based on Odoo standard schema).
    - `warehouse_id` → `stock_warehouse.id` (Likely target based on Odoo standard schema).
- **Natural keys (inferred):**
    - `complete_name` (In Odoo, the full path is typically unique within a company).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Hierarchy:** The `parent_path` column is a materialized path string (e.g., "1/5/12") intended for fast recursive queries; use this instead of self-joining on `location_id` for performance.
- **Data Sensitivity:** No direct PII is present, but `comment` fields may contain internal business information.