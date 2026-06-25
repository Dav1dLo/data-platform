# mrp_production

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming conventions (e.g., `mrp_production`, `bom_id`, `picking_type_id`, `product_uom_id`) and the use of Odoo-standard audit fields (`create_uid`, `write_uid`, `create_date`) are characteristic of the Odoo database schema.

## Functional process 
This table supports the manufacturing execution process, tracking the lifecycle of production orders from planning to completion. It manages the conversion of raw materials into finished goods by linking Bills of Materials (`bom_id`) to specific production quantities, tracking inventory movements between locations (`location_src_id`, `location_dest_id`), and managing production scheduling and state transitions.

## Description
One row in this table represents a single manufacturing order (MO) within the production system. It captures the planned quantities, status, and timeline for a specific product, serving as the primary record for tracking work-in-progress and production output. This is a raw landed copy of the Odoo `mrp.production` model in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| backorder_sequence | INTEGER | true | Sequence number for backorders | Used when a production order is split. |
| product_id | INTEGER | false | Product identifier | Foreign key to product master. |
| product_uom_id | INTEGER | false | Unit of measure identifier | Defines the unit for `product_qty`. |
| lot_producing_id | INTEGER | true | Lot/Serial number identifier | The lot being produced in this order. |
| picking_type_id | INTEGER | false | Operation type identifier | Defines the warehouse operation type. |
| location_src_id | INTEGER | false | Source location | Where raw materials are consumed from. |
| location_dest_id | INTEGER | false | Destination location | Where finished goods are moved to. |
| location_final_id | INTEGER | true | Final destination location | Optional override for final storage. |
| bom_id | INTEGER | true | Bill of Materials identifier | Defines the recipe/components for production. |
| user_id | INTEGER | true | Responsible user identifier | The person assigned to the order. |
| company_id | INTEGER | false | Company identifier | Multi-company support. |
| procurement_group_id | INTEGER | true | Procurement group identifier | Links to related supply chain documents. |
| orderpoint_id | INTEGER | true