# mrp_unbuild

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`mrp_unbuild`, `product_uom_id`, `bom_id`, `mo_id`) and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Manufacturing (MRP) module, specifically the "unbuild" process where finished goods are disassembled back into their component parts. It tracks the reversal of manufacturing orders, linking the product being unbuilt to its original Bill of Materials (`bom_id`) and the specific manufacturing order (`mo_id`) from which it originated.

## Description
One row represents a single unbuild order event, documenting the disassembly of a specific quantity of a product. As a staging table, it serves as a raw, landed copy of the Odoo `mrp.unbuild` model, capturing the state of the unbuild process and the associated inventory movements between locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_unbuild_id_seq`. |
| product_id | INTEGER | false | ID of the product being unbuilt | Foreign key to `product.product`. |
| company_id | INTEGER | false | ID of the associated company | Multi-tenant identifier. |
| product_uom_id | INTEGER | false | Unit of measure ID | Defines the quantity unit. |
| bom_id | INTEGER | true | Bill of Materials ID | The BOM used for the original assembly. |
| mo_id | INTEGER | true | Manufacturing Order ID | The source MO being reversed. |
| lot_id | INTEGER | true | Lot/Serial number ID | Identifies the specific batch being unbuilt. |
| location_id | INTEGER | false | Source inventory location | Where the product was taken from. |
| location_dest_id | INTEGER | false | Destination inventory location | Where components are returned. |
| create_uid | INTEGER | true | User ID who created the record | Audit field. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field. |
| name | VARCHAR | true | Unbuild order reference number | Human-readable identifier (e.g., UBU/0001). |
| state | VARCHAR | true | Current status of the unbuild | e.g., 'draft', 'done'. |
| product_qty | NUMERIC | false | Quantity of product unbuilt | Numeric value. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Likely target: `product_product`)
    - `bom_id` → `mrp_bom.id` (Likely target: `mrp_bom`)
    - `mo_id` → `mrp_production.id` (Likely target: `mrp_production`)
    - `location_id` / `location_dest_id` → `stock_location.id` (Likely target: `stock_location`)
- **Natural keys (inferred):** `name` (Odoo sequence-based reference number).

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **State transitions:** The `state` column is a string; consumers should expect values like 'draft' or 'done' and handle potential custom states if the Odoo instance is heavily modified.
- **Data Integrity:** As a staging table, this may contain multiple versions of the same `id` if the ingestion process performs full dumps; check for `write_date` to identify the latest record if necessary.