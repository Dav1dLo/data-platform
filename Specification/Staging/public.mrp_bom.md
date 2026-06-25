# mrp_bom

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_bom` (Manufacturing Resource Planning Bill of Materials) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing and production planning process by defining the Bill of Materials (BOM). It dictates the relationship between finished products (`product_tmpl_id`), their components, and the required quantities (`product_qty`) and units of measure (`product_uom_id`) needed to complete a manufacturing order.

## Description
One row in this table represents a single Bill of Materials definition or a specific BOM version for a product. It acts as a raw landed copy from the Odoo staging environment, capturing the structural requirements for production, including lead times (`produce_delay`) and operational dependencies.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_bom_id_seq`. |
| product_tmpl_id | INTEGER | false | Product template ID | Foreign key to the product template. |
| product_id | INTEGER | true | Specific product variant ID | Nullable if the BOM applies to all variants. |
| product_uom_id | INTEGER | false | Unit of measure ID | Defines the scale of `product_qty`. |
| sequence | INTEGER | true | Display sequence | Used for ordering in UI/reports. |
| picking_type_id | INTEGER | true | Picking type ID | Defines the warehouse operation type. |
| company_id | INTEGER | true | Company ID | Multi-company context identifier. |
| produce_delay | INTEGER | true | Production delay | Lead time in days. |
| days_to_prepare_mo | INTEGER | true | Preparation days | Buffer time before manufacturing. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | Audit: user who last modified the record. |
| code | VARCHAR | true | BOM reference code | Human-readable identifier. |
| type | VARCHAR | false | BOM type | e.g., 'normal', 'phantom'. |
| ready_to_produce | VARCHAR | false | Readiness status | Configuration for production start. |
| consumption | VARCHAR | false | Consumption policy | Rules for component usage. |
| product_qty | NUMERIC | false | Quantity | The amount of product produced by this BOM. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| allow_operation_dependencies | BOOLEAN | true | Dependency flag | Enables complex routing dependencies. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| project_id | INTEGER | true | Project ID | Link to project management module. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_tmpl_id` → `product_template.id` (Standard Odoo link to product definition).
    - `product_uom_id` → `uom_uom.id` (Standard Odoo link to units of measure).
    - `company_id` → `res_company.id` (Standard Odoo link to company).
- **Natural keys (inferred):** 
    - `code` (If unique constraints are enforced at the application level).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to retrieve current records.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with standard Odoo database practices.
- **Data Integrity:** `product_id` is nullable, implying that some BOMs are defined at the template level (applying to all variants) rather than the specific variant level.
- **Sensitive Data:** No PII is present, but internal operational logic (lead times, consumption policies) should be handled according to internal data governance policies.