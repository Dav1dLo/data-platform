# product_replenish

## Source system
The table likely originates from an Odoo ERP system. The naming conventions (e.g., `product_tmpl_id`, `product_uom_id`, `create_uid`, `write_uid`, `bom_id`) and the use of PostgreSQL sequences for primary keys are highly characteristic of Odoo's internal database schema.

## Functional process 
This table supports the inventory replenishment and supply chain planning process. It tracks planned stock movements or procurement requirements, linking specific products and product templates to warehouses, suppliers, and bills of materials (BOMs) to ensure inventory levels are maintained.

## Description
One row in this table represents a single planned replenishment event or requirement for a specific product at a designated warehouse. As a staging table, it serves as a raw, landed copy of the operational replenishment records, capturing the quantity, timing, and logistical parameters required for stock fulfillment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_replenish_id_seq`. |
| route_id | INTEGER | true | Inventory route identifier | Defines the path the product takes to reach the warehouse. |
| product_id | INTEGER | false | Product variant identifier | Reference to the specific product variant. |
| product_tmpl_id | INTEGER | false | Product template identifier | Reference to the base product definition. |
| product_uom_id | INTEGER | false | Unit of measure identifier | The unit in which the quantity is expressed. |
| warehouse_id | INTEGER | false | Warehouse identifier | The destination warehouse for the replenishment. |
| company_id | INTEGER | true | Company identifier | The organizational entity owning this record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| product_has_variants | BOOLEAN | false | Variant flag | Indicates if the product has multiple variants. |
| date_planned | TIMESTAMP | false | Planned date | The scheduled date for the replenishment. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp when the record was last updated. |
| quantity | DOUBLE PRECISION | false | Replenishment quantity | The amount of product to be replenished. |
| bom_id | INTEGER | true | Bill of Materials ID | Links to a BOM if the replenishment involves manufacturing. |
| supplier_id | INTEGER | true | Supplier identifier | The vendor responsible for the supply. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Likely links to the product master table).
    - `warehouse_id` → `stock_warehouse.id` (Likely links to the warehouse definition table).
    - `supplier_id` → `res_partner.id` (Likely links to the partner/vendor master table).
    - `bom_id` → `mrp_bom.id` (Likely links to the manufacturing bill of materials).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`date_planned`, `create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains no explicit soft-delete flag; assume all records are active unless filtered by business logic.
- The `quantity` column uses `DOUBLE PRECISION`, which may require rounding depending on the specific unit of measure precision.
- `create_uid` and `write_uid` refer to internal system user IDs and will require a join to the user/partner table for human-readable names.