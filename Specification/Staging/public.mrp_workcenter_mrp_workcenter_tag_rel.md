# mrp_workcenter_mrp_workcenter_tag_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `mrp_workcenter_mrp_workcenter_tag_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link manufacturing resource planning (MRP) work centers to their associated tags.

## Functional process 
This table supports the manufacturing and production management process by enabling a many-to-many relationship between work centers and descriptive tags. These tags are used to categorize or filter work centers based on capabilities, location, or maintenance requirements within the production floor.

## Description
One row in this table represents a single association between a specific work center and a specific tag. It serves as a raw junction table in the staging layer, facilitating the mapping of multiple tags to a single work center and vice versa.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workcenter_id | INTEGER | false | Foreign key to the work center definition | References the primary work center entity. |
| mrp_workcenter_tag_id | INTEGER | false | Foreign key to the tag definition | References the specific tag applied to the work center. |

## Keys

- **Primary key (inferred):** The composite of (`mrp_workcenter_id`, `mrp_workcenter_tag_id`).
- **Foreign keys (inferred):** 
    - `mrp_workcenter_id` → `mrp_workcenter.id`: Links to the parent work center record.
    - `mrp_workcenter_tag_id` → `mrp_workcenter_tag.id`: Links to the parent tag record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes other than the two foreign keys.
- Expect no soft-delete flags; relationships in Odoo junction tables are typically created or destroyed directly.
- Ensure joins to parent tables handle potential missing records if referential integrity is not strictly enforced in the source system.