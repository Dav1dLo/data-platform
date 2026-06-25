# res_groups_report_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `res_groups_report_rel` follows the standard Odoo pattern for many-to-many relationship tables, specifically linking user groups (`res_groups`) to report definitions.

## Functional process 
This table supports the security and access control module within the ERP. It defines the many-to-many relationship between user groups and specific reports, determining which user groups have permission to access or generate specific reports.

## Description
One row in this table represents a single association between a user group and a report. It acts as a join table in the staging layer, providing a raw mapping of group-to-report permissions as extracted directly from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| uid | INTEGER | false | Foreign key to the user group identifier | Represents the group ID from the `res_groups` table. |
| gid | INTEGER | false | Foreign key to the report identifier | Represents the report ID from the `ir_act_report_xml` or similar report definition table. |

## Keys

- **Primary key (inferred):** The combination of `(uid, gid)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `uid` → `res_groups.id`: Links to the group definition table.
    - `gid` → `ir_act_report_xml.id` (or similar): Links to the report definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to indicate when these relationships were created or modified.
- Ensure referential integrity checks are performed against the parent tables (`res_groups` and the report definition table) as this staging table may contain orphaned records if the source system's cleanup processes are incomplete.