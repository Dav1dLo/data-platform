# mrp_bom_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`product_tmpl_id`, `bom_id`, `create_uid`, `write_uid`) and the specific sequence-based default value pattern used for primary keys in Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing bill of materials (BOM) management process. It defines the individual components or raw materials required to produce a finished good, specifying the quantity (`product_qty`) and unit of measure (`product_uom_id`) for each line item associated with a specific BOM.

## Description
One row represents a single component line item within a manufacturing Bill of Materials. It captures the relationship between a parent BOM and a specific product, including consumption rules and cost allocation factors. This is a raw staging table representing a direct dump of the Odoo `mrp.bom.line` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_bom_line_id_seq`. |
| product_id | INTEGER | false | Foreign key to the product variant | The specific item required. |
| product_tmpl_id | INTEGER | true | Foreign key to the product template | Optional grouping for the product. |
| company_id | INTEGER | true | Foreign key to the owning company | Multi-company environment identifier. |
| product_uom_id | INTEGER | false | Foreign key to the unit of measure | Defines the unit for `product_qty`. |
| sequence | INTEGER | true | Display order | Used for UI sorting of BOM lines. |
| bom_id | INTEGER | false | Foreign key to the parent BOM | Links this line to the main BOM header. |
| operation_id | INTEGER | true | Foreign key to the manufacturing operation | Links component to a specific work step. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| product_qty | NUMERIC | false | Required quantity | The amount of the product needed. |
| manual_consumption | BOOLEAN | true | Manual consumption flag | Indicates if consumption is tracked manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| cost_share | NUMERIC | true | Cost allocation percentage | Used for by-product cost distribution. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product link)
    - `bom_id` → `mrp_bom.id` (Guess: links to the parent BOM header)
    - `product_uom_id` → `uom_uom.id` (Guess: standard Odoo unit of measure link)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains no PII, but `create_uid` and `write_uid` link to internal user records.
- No soft-delete flag is present; O