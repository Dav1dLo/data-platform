# ir_embedded_actions_res_groups_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_embedded_actions_res_groups_rel` follows the standard Odoo pattern for a many-to-many join table linking "embedded actions" (often related to UI/UX configurations or dashboard widgets) to "res_groups" (the security groups that define user access permissions).

## Functional process 
This table supports the Access Control List (ACL) management process within the application. It defines which user security groups are authorized to view or interact with specific embedded actions, ensuring that UI components or automated actions are only visible to the appropriate roles.

## Description
One row in this table represents a single association between an embedded action and a security group, effectively granting the group access to that action. As a staging table, it provides a raw, normalized link between these two entities, serving as the foundation for downstream security filtering logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_embedded_actions_id | INTEGER | false | Foreign key to the embedded action definition. | Links to the primary key of the action table. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition. | Links to the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The combination of `(ir_embedded_actions_id, res_groups_id)` is the composite primary key.
- **Foreign keys (inferred):** 
    - `ir_embedded_actions_id` → `ir_embedded_actions.id`: This column references the specific action being restricted.
    - `res_groups_id` → `res_groups.id`: This column references the security group receiving the permission.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between actions and groups.
- There are no audit timestamps (e.g., `created_at`) available in this table, so tracking the history of permission changes is not possible from this source alone.
- Ensure that joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.