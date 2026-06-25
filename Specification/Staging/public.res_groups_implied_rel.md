# res_groups_implied_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups_implied_rel` is a standard pattern used by Odoo to manage many-to-many relationship tables (specifically "rel" tables) for implied group hierarchies within the `res_groups` module.

## Functional process 
This table supports the Access Control List (ACL) and security group management process. It defines the hierarchical relationship between security groups, where one group (the "implied" group) automatically inherits the permissions or membership of another group.

## Description
One row in this table represents a single directed relationship where the group identified by `gid` implies the permissions of the group identified by `hid`. This is a raw landing of a join table used to resolve nested security group assignments within the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | Group ID | The parent group that inherits permissions. |
| hid | INTEGER | false | Implied Group ID | The child group whose permissions are being inherited. |

## Keys

- **Primary key (inferred):** The composite key `(gid, hid)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `gid` → `res_groups.id`: This column references the primary group record.
    - `hid` → `res_groups.id`: This column references the group being implied.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only foreign key references.
- There are no timestamps or soft-delete flags; assume this represents the current state of group hierarchies.
- Queries involving this table will almost certainly require a `JOIN` back to the `res_groups` table to retrieve human-readable group names.