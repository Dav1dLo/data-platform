# ir_act_server_group_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_act_server_group_rel` naming convention, which follows the standard Odoo pattern for many-to-many relationship tables (linking server actions to server groups).

## Functional process 
This table supports the Odoo framework's internal configuration management, specifically the association between server actions (`ir_act_server`) and server groups (`ir_act_server_group`). It facilitates the grouping of automated server-side actions for administrative or permission-based management.

## Description
Each row represents a single association between a server action and a server group in a many-to-many relationship. As a staging table, it provides a raw, landed copy of the link table from the source database, intended for use in reconstructing the relationship graph between actions and groups.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the server action | Links to the primary key of the server action table. |
| gid | INTEGER | false | Foreign key to the server group | Links to the primary key of the server group table. |

## Keys

- **Primary key (inferred):** The combination of `(act_id, gid)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_server.id`: This column references the server action definition.
    - `gid` → `ir_act_server_group.id`: This column references the server group definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins to the parent tables (`ir_act_server` and `ir_act_server_group`) handle potential orphans if the source system's referential integrity is not strictly enforced.