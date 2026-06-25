# mrp_bom_byproduct_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_bom_byproduct_..._rel`. The structure is characteristic of a many-to-many join table used by the Odoo ORM to link Bill of Materials (BOM) byproduct definitions with specific product template attribute values.

## Functional process 
This table supports the Manufacturing (MRP) module, specifically managing the relationship between byproduct configurations and product variants. It enables the system to associate specific attribute values (e.g., color, size) with byproducts generated during the production of a BOM.

## Description
One row in this table represents a single association between a specific MRP BOM byproduct record and a product template attribute value. It serves as a raw landing of a many-to-many join table, facilitating the resolution of complex product variant dependencies within the manufacturing process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_byproduct_id | INTEGER | false | Foreign key to the MRP BOM byproduct definition. | Links to the parent byproduct record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product template attribute value. | Identifies the specific variant attribute applied. |

## Keys

- **Primary key (inferred):** The combination of `mrp_bom_byproduct_id` and `product_template_attribute_value_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_bom_byproduct_id` → `mrp_bom_byproduct.id`: This column references the primary key of the byproduct definition table.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the primary key of the attribute value definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive data other than the two foreign key identifiers.
- As a staging table, it reflects the raw state of the Odoo database; expect no soft-delete flags or audit timestamps within this specific table.
- Ensure that joins to the target tables handle the composite nature of the primary key to avoid fan-out issues.