# ir_ui_view_group_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_ui_view_group_rel` naming convention, which is the standard technical name for the many-to-many relationship table linking user interface views to security groups in the Odoo framework.

## Functional process 
This table supports the access control and security management process. It defines which user groups have permission to access or view specific UI elements, ensuring that interface components are rendered only for authorized users based on their assigned security roles.

## Description
One row in this table represents a single association between a specific UI view and a security group. It serves as a raw landing copy of the join table used by the Odoo ORM to manage many-to-many relationships between the `ir_ui_view` and `res_groups` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| view_id | INTEGER | false | Foreign key to the UI view definition | References the primary key of the view table. |
| group_id | INTEGER | false | Foreign key to the security group definition | References the primary key of the group table. |

## Keys

- **Primary key (inferred):** The combination of `(view_id, group_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id`: This column links to the view definition table.
    - `group_id` → `res_groups.id`: This column links to the security group definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship between two entities.
- There are no timestamps or audit columns present in this staging table.
- Ensure that joins to the target tables (`ir_ui_view` and `res_groups`) are handled as inner joins if you only require active associations.