# res_groups_spreadsheet_dashboard_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `res_groups_..._rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between security groups (`res_groups`) and other system entities, in this case, spreadsheet dashboards.

## Functional process 
This table supports the Access Control List (ACL) management process. It defines which user security groups have permission to access or view specific spreadsheet dashboards within the system, ensuring that sensitive reporting data is restricted to authorized roles.

## Description
This table represents a many-to-many join relationship between security groups and spreadsheet dashboards. Each row maps a single security group to a single dashboard, effectively granting the group access to that dashboard. It serves as a raw landing of the association table used by the application to enforce authorization logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard entity | Maps to the primary key of the dashboard table. |
| res_groups_id | INTEGER | false | Foreign key to the security group entity | Maps to the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** Composite key of (`spreadsheet_dashboard_id`, `res_groups_id`).
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Inferred from naming convention).
    - `res_groups_id` → `res_groups.id` (Inferred from Odoo standard schema).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag; assume this table reflects the current state of permissions as defined in the source application.
- Queries joining this table should be prepared for inner joins to filter for specific group access or outer joins to identify dashboards without assigned security groups.