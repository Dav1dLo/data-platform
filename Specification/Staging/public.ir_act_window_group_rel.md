# ir_act_window_group_rel

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_act_window_group_rel` follows Odoo's internal naming pattern for many-to-many relationship tables, where `ir` stands for "Internal Resources" and `act_window` refers to window action definitions.

## Functional process 
This table supports the security and access control module of the ERP. It manages the many-to-many relationship between window actions (UI views/menus) and user groups, determining which user groups have permission to access specific window actions within the application interface.

## Description
One row in this table represents a single association between a specific window action and a user group. It is a raw landing copy of the join table used to enforce UI-level access permissions, mapping the `act_id` to the `gid`.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the window action definition. | References the primary key of the action table. |
| gid | INTEGER | false | Foreign key to the user group definition. | References the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The composite of (`act_id`, `gid`) is the primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_window.id`: This column links to the window action definition.
    - `gid` → `res_groups.id`: This column links to the user group definition.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this represents the current state of the relationship as landed from the source.
- Ensure joins to `ir_act_window` and `res_groups` are handled as inner joins if you only require active associations.