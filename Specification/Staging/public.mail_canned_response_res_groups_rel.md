# mail_canned_response_res_groups_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific column pattern `mail_canned_response_id` and `res_groups_id` is characteristic of Odoo's automated many-to-many relationship tables, which link canned email responses to specific user security groups.

## Functional process 
This table supports the access control and permission management process for canned email responses. It defines which user groups are authorized to view or utilize specific canned responses within the communication module, ensuring that sensitive or role-specific templates are restricted to the appropriate personnel.

## Description
One row in this table represents a single association between a canned response and a user group, effectively acting as a junction table. It is a raw landed copy of the Odoo relational mapping, used to resolve many-to-many relationships during downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_canned_response_id | INTEGER | false | Foreign key to the canned response definition | Links to the primary canned response table. |
| res_groups_id | INTEGER | false | Foreign key to the user security group | Links to the Odoo groups definition table. |

## Keys

- **Primary key (inferred):** The combination of `mail_canned_response_id` and `res_groups_id`.
- **Foreign keys (inferred):** 
    - `mail_canned_response_id` → `mail_canned_response.id`: This column references the primary identifier of the canned response entity.
    - `res_groups_id` → `res_groups.id`: This column references the primary identifier of the security group entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when an association was created or deleted from this table alone.
- Queries should always join both columns to the respective parent tables to ensure referential integrity, as this table may contain orphaned IDs if the source system's cleanup processes are inconsistent.