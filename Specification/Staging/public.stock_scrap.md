# stock_scrap

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `product_uom_id`, `picking_id`, `scrap_location_id`, `create_uid`) and the specific structure of the fields are characteristic of Odoo's inventory management module, specifically the `stock.scrap` model.

## Functional process 
This table supports the inventory management and quality control process by tracking items removed from stock due to damage, expiration, or defects. It records the movement of goods from a functional storage location to a designated "scrap" location, often linked to production orders (`production_id`) or bills of materials (`bom_id`) to account for manufacturing waste.

## Description
One row represents a single scrap event, documenting the quantity of a specific product removed from inventory. It serves as a raw landed copy of the Odoo scrap record, capturing the state of the scrap request, the associated product, and the relevant logistical metadata at the time of the transaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Odoo company identifier | Multi-tenant identifier. |
| product_id | INTEGER | false | Product identifier | Foreign key to product master. |
| product_uom_id | INTEGER | false | Unit of measure identifier | Defines the unit for `scrap_qty`. |
| lot_id | INTEGER | true | Lot or serial number identifier | Optional; tracks specific batches. |
| package_id | INTEGER | true | Package identifier | Optional; tracks container/pallet. |
| owner_id | INTEGER | true | Stock owner identifier | Optional; for consignment stock. |
| picking_id | INTEGER | true | Picking identifier | Link to the source stock move. |
| location_id | INTEGER | false | Source location identifier | Where the item was scrapped from. |
| scrap_location_id | INTEGER | false | Destination scrap location | Where the item was moved to. |
| create_uid | INTEGER | true | User ID who created the record | Audit field. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field. |
| name | VARCHAR | false | Scrap reference number | Human-readable document code. |
| origin | VARCHAR | true | Source document reference | e.g., related order or picking. |
| state | VARCHAR | true | Lifecycle status | e.g., 'draft', 'done'. |
| scrap_qty | NUMERIC | false | Quantity scrapped | The amount removed. |
| should_replenish | BOOLEAN | true | Replenishment flag | Indicates if stock needs replacing. |
| date_done | TIMESTAMP | true | Completion timestamp | When the scrap was finalized. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| production_id | INTEGER | true | Manufacturing order identifier | Link to production waste. |
| workorder_id | INTEGER | true | Work order identifier | Link to specific production step. |
| bom_id | INTEGER | true | Bill of Materials identifier | Link to the recipe/BOM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Inferred from Odoo standard naming)
    - `location_id` → `stock_location.id` (Inferred from Odoo standard naming)
    - `production_id` → `mrp_production.id` (Inferred from Odoo standard naming)
- **Natural keys (inferred):** 
    - `name` (The scrap reference number is typically unique within an Odoo instance)

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`, `date_done`) are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to use a soft-delete flag; records are typically immutable once in the 'done' state.
- **Data Integrity:** `lot_id`, `package_id`, and `owner_id` are frequently null in standard warehouse operations where tracking is not required at that granularity.
- **Sensitive Data:** No direct PII is present, though `create_uid` and `write_uid` link to internal user records which may contain employee names in other tables.