# stock_move_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `picking_id`, `move_id`, `product_uom_id`, `create_uid`), the presence of Odoo-specific audit fields (`create_uid`, `write_uid`, `create_date`, `write_date`), and the functional focus on inventory movements are characteristic of Odoo's `stock.move.line` model.

## Functional process 
This table supports the inventory management and logistics process, specifically tracking the granular movement of individual stock items or lots between locations. It records the actual execution of stock transfers, linking products to specific source and destination locations, lot numbers, and packaging, often as part of a warehouse picking or manufacturing production workflow.

## Description
One row in this table represents a single line item of a stock movement, detailing the quantity of a specific product moved from a source location to a destination location. As a staging table, it provides a raw, landed copy of the Odoo inventory transaction logs, serving as the foundation for calculating current stock levels, traceability, and inventory valuation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| picking_id | INTEGER | true | Foreign key to the parent picking | Links to the overall transfer document. |
| move_id | INTEGER | true | Foreign key to the stock move | Links to the high-level stock move instruction. |
| company_id | INTEGER | false | Owning company ID | Multi-company identifier. |
| product_id | INTEGER | true | Product identifier | The item being moved. |
| product_uom_id | INTEGER | false | Unit of measure identifier | The unit in which the quantity is expressed. |
| package_id | INTEGER | true | Source package identifier | The container the product was in. |
| package_level_id | INTEGER | true | Package level identifier | Used for nested packaging structures. |
| lot_id | INTEGER | true | Lot/Serial number identifier | Specific batch or serial tracking. |
| result_package_id | INTEGER | true | Destination package identifier | The container the product is placed in. |
| owner_id | INTEGER | true | Owner identifier | Used for third-party stock ownership. |
| location_id | INTEGER | false | Source location identifier | Where the stock was taken from. |
| location_dest_id | INTEGER | false | Destination location identifier | Where the stock was moved to. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record updates. |
| lot_name | VARCHAR | true | Lot/Serial name | Human-readable lot identifier. |
| state | VARCHAR | true | Movement status | e.g., 'draft', 'confirmed', 'done'. |
| reference | VARCHAR | true | Document reference | External or internal reference string. |
| description_picking | TEXT | true | Picking description | Descriptive text for the movement. |
| quantity | NUMERIC | true | Quantity moved | The amount moved in the base unit. |
| quantity_product_uom | NUMERIC | true | Quantity in UoM | The amount moved in the specified UoM. |
| picked | BOOLEAN | true | Picked status | Flag indicating if the item was picked. |
| date | TIMESTAMP | false | Movement date | The effective date of the transaction. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingestion/creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Last modification time. |
| workorder_id | INTEGER | true | Work order identifier | Links to manufacturing work orders. |
| production_id | INTEGER | true | Production identifier | Links to manufacturing orders. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id` (Links to the parent picking document)
    - `move_id` → `stock_move.id` (Links to the parent stock move)
    - `product_id` → `product_product.id` (Identifies the product)
    - `location_id` / `location_dest_id` → `stock_location.id` (Identifies warehouse locations)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`date`, `create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are generally immutable once the state is 'done'.
- **Data Grain:** This is a transactional table; expect high volumes of data. Queries should be filtered by `date` or `state` to maintain performance.
- **Units:** `quantity` and `quantity_product_uom` may differ depending on the conversion factors defined in the product master data.