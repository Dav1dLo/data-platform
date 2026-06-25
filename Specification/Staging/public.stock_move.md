# stock_move

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `picking_id`, `product_uom`, `procure_method`, `create_uid`), the specific sequence-based ID generation, and the comprehensive set of manufacturing and inventory-related foreign keys are characteristic of the Odoo `stock.move` model.

## Functional process 
This table supports the inventory and logistics management process, specifically tracking the movement of goods between locations. It records the lifecycle of stock transfers, including internal transfers, incoming receipts, outgoing deliveries, and manufacturing consumption or production outputs.

## Description
One row in this table represents a single stock movement operation, defining the transfer of a specific quantity of a product from a source location to a destination location. As a staging table, it provides a raw, granular record of inventory transactions, serving as the foundation for calculating stock levels, lead times, and traceability across the supply chain.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display sequence | Used for ordering moves. |
| company_id | INTEGER | false | Company identifier | Links to the multi-company entity. |
| product_id | INTEGER | false | Product identifier | Reference to the product master. |
| product_uom | INTEGER | false | Unit of measure ID | The unit used for this movement. |
| location_id | INTEGER | false | Source location ID | Where the stock is moving from. |
| location_dest_id | INTEGER | false | Destination location ID | Where the stock is moving to. |
| location_final_id | INTEGER | true | Final destination ID | Used for complex routing. |
| partner_id | INTEGER | true | Partner identifier | Customer or vendor involved. |
| picking_id | INTEGER | true | Picking identifier | Links to the parent picking document. |
| scrap_id | INTEGER | true | Scrap identifier | Links to a scrap record if applicable. |
| group_id | INTEGER | true | Procurement group ID | Groups related moves. |
| rule_id | INTEGER | true | Procurement rule ID | The rule that triggered this move. |
| picking_type_id | INTEGER | true | Picking type ID | Defines the operation type (e.g., Receipt). |
| origin_returned_move_id | INTEGER | true | Return move ID | Links to the original move if this is a return. |
| restrict_partner_id | INTEGER | true | Restricted partner ID | Limits stock to a specific partner. |
| warehouse_id | INTEGER | true | Warehouse identifier | The warehouse associated with the move. |
| package_level_id | INTEGER | true | Package level ID | Links to the physical packaging. |
| next_serial_count | INTEGER | true | Serial count | Number of serials to generate. |
| orderpoint_id | INTEGER | true | Reordering rule ID | Links to the replenishment rule. |
| product_packaging_id | INTEGER | true | Packaging ID | The specific packaging type used. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last updater user ID | User who last modified the record. |
| name | VARCHAR | false | Move description | Descriptive label for the move. |
| priority | VARCHAR | true | Priority level | e.g., '0' (normal), '1' (urgent). |
| state | VARCHAR | true | Status | e.g., 'draft', 'confirmed', 'done'. |
| origin | VARCHAR | true | Source document | Reference to the originating order. |
| procure_method | VARCHAR | false | Procurement method | e.g., 'make_to_stock', 'make_to_order'. |
| reference | VARCHAR | true | Internal reference | Unique identifier for the move. |
| next_serial | VARCHAR | true | Next serial number | Serial number for tracking. |
| reservation_date | DATE | true | Reservation date | When stock was reserved. |
| description_picking | TEXT | true | Picking description | Notes for the warehouse team. |
| product_qty | NUMERIC | true | Product quantity | Quantity in base units. |
| product_uom_qty | NUMERIC | false | UoM quantity | Quantity in the specified UoM. |
| quantity | NUMERIC | true | Actual quantity done | The quantity actually moved. |
| picked | BOOLEAN | true | Picked status | Flag indicating if picked. |
| scrapped | BOOLEAN | true | Scrapped status | Flag indicating if scrapped. |
| propagate_cancel | BOOLEAN | true | Propagate cancel | Whether to cancel linked moves. |
| is_inventory | BOOLEAN | true | Inventory flag | True if part of an inventory adjustment. |
| additional | BOOLEAN | true | Additional flag | True if added manually to a picking. |
| date | TIMESTAMP | false | Scheduled date | When the move is expected. |
| date_deadline | TIMESTAMP | true | Deadline date | The latest date for the move. |
| delay_alert_date | TIMESTAMP | true | Delay alert date | Date to trigger a delay notification. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| price_unit | DOUBLE PRECISION | true | Unit price | Cost or value per unit. |
| is_done | BOOLEAN | true | Done status | Indicates if the move is completed. |
| unit_factor | DOUBLE PRECISION | true | Unit factor | Conversion factor for UoM. |
| manual_consumption | BOOLEAN | true | Manual consumption | Flag for manual material usage. |
| created_production_id | INTEGER | true | Created production ID | Links to a production order. |
| production_id | INTEGER | true | Production ID | Links to the manufacturing order. |
| raw_material_production_id | INTEGER | true | Raw material prod ID | Links to raw material consumption. |
| unbuild_id | INTEGER | true | Unbuild ID | Links to an unbuild order. |
| consume_unbuild_id | INTEGER | true | Consume unbuild ID | Links to unbuild consumption. |
| operation_id | INTEGER | true | Operation ID | Links to a manufacturing operation. |
| workorder_id | INTEGER | true | Workorder ID | Links to a specific work order. |
| bom_line_id | INTEGER | true | BoM line ID | Links to the Bill of Materials line. |
| byproduct_id | INTEGER | true | Byproduct ID | Links to a manufacturing byproduct. |
| order_finished_lot_id | INTEGER | true | Finished lot ID | Links to the lot/serial number. |
| cost_share | NUMERIC | true | Cost share | Allocation of cost for byproducts. |
| to_refund | BOOLEAN | true | To refund flag | Indicates if the move needs a refund. |
| purchase_line_id | INTEGER | true | Purchase line ID | Links to the purchase order line. |
| sale_line_id | INTEGER | true | Sale line ID | Links to the sales order line. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Links to the product being moved)
    - `location_id` → `stock_location.id` (Source location of the stock)
    - `location_dest_id` → `stock_location.id` (Destination location of the stock)
    - `picking_id` → `stock_picking.id` (Parent document for the movement)
    - `purchase_line_id` → `purchase_order_line.id` (Source purchase order line)
    - `sale_line_id` → `sale_order_line.id` (Source sales order line)
- **Natural keys (inferred):** 
    - `reference` (The business-level identifier for the stock move)

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns (e.g., `date`, `create_date`) are assumed to be in UTC, consistent with Odoo's standard behavior.
- **Soft Deletes:** This table typically does not use soft deletes; records are usually immutable once marked as `done`.
- **Quantity Fields:** Use `quantity` for the actual moved amount and `product_uom_qty` for the initial demand.
- **State:** Filter by `state = 'done'` to analyze completed inventory movements.
- **Sensitivity:** Contains `partner_id` which may link to customer/vendor PII in other tables.