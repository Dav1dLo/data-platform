# mrp_production_mrp_production_backorder_rel

## Source system
This table originates from an Odoo ERP system, indicated by the naming convention `mrp_production_mrp_production_backorder_rel`. The `_rel` suffix is a standard pattern in Odoo for many-to-many relationship tables linking two core entities.

## Functional process 
This table supports the Manufacturing Resource Planning (MRP) process, specifically tracking the relationship between production orders and their associated backorders. It enables the system to maintain a link between a primary manufacturing order and subsequent backorders generated when production is split or partially fulfilled.

## Description
One row in this table represents a single association between a manufacturing production order and a backorder record. It serves as a junction table in the staging layer, providing a raw, normalized link between these two entities to facilitate downstream join operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_production_backorder_id | INTEGER | false | Foreign key to the backorder record | Represents the child or secondary production backorder. |
| mrp_production_id | INTEGER | false | Foreign key to the production order | Represents the parent or primary manufacturing production order. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`mrp_production_backorder_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `mrp_production_backorder_id` → `mrp_production_backorder.id` (Inferred from naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of (`mrp_production_backorder_id`, `mrp_production_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no other attributes besides the two foreign keys.
- Ensure inner joins are used when filtering for specific production order histories to avoid orphaned backorder references.
- As a staging table, this data reflects the raw state of the Odoo database; verify if the source system performs hard deletes on these relationships or if they persist historically.