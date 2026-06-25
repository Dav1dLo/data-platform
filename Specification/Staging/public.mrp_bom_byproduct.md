# mrp_bom_byproduct

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_bom_byproduct`), the use of `create_uid`/`write_uid` audit columns, and the standard Odoo sequence-based primary key generation pattern.

## Functional process 
This table supports the manufacturing bill of materials (BOM) process, specifically tracking secondary outputs or "byproducts" generated during the production of a primary product. It links specific products to a BOM and defines the quantity and cost allocation for items produced alongside the main output.

## Description
One row represents a single byproduct configuration associated with a specific manufacturing Bill of Materials. It defines the quantity and cost share of a secondary product produced during a manufacturing operation. This is a raw staging table representing a direct copy of the Odoo `mrp.bom.byproduct` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_bom_byproduct_id_seq`. |
| product_id | INTEGER | false | Foreign key to the product | The byproduct item being produced. |
| company_id | INTEGER | true | Foreign key to the company | Multi-company context identifier. |
| product_uom_id | INTEGER | false | Foreign key to the unit of measure | The unit of measure for the byproduct quantity. |
| bom_id | INTEGER | true | Foreign key to the parent BOM | The Bill of Materials this byproduct belongs to. |
| operation_id | INTEGER | true | Foreign key to the manufacturing operation | The specific step in the routing where this byproduct is created. |
| sequence | INTEGER | true | Display order | Used for sorting byproducts in the UI. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| product_qty | NUMERIC | false | Quantity of byproduct | The amount produced per unit of the parent product. |
| cost_share | NUMERIC | true | Cost allocation percentage | The percentage of the total manufacturing cost assigned to this byproduct. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: links to the product catalog)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `product_uom_id` → `uom_uom.id` (Guess: standard Odoo unit of measure link)
    - `bom_id` → `mrp_bom.id` (Guess: links to the parent manufacturing BOM)
    - `operation_id` → `mrp_routing_workcenter.id` (Guess: links to the specific manufacturing step)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage.
- This table contains no explicit soft-delete flag; assume records are hard-deleted if removed from the source.
- `cost_share` may be null if no specific cost allocation has been defined for the byproduct.
- This is a staging table; join with caution as it may contain historical versions or incomplete data depending on the ingestion frequency.