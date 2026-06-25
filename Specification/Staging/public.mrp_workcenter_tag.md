# mrp_workcenter_tag

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_workcenter_tag` (Manufacturing Resource Planning module) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing resource management process by providing a categorization or tagging system for work centers. These tags allow production managers to group work centers by specific attributes, such as capability, location, or maintenance requirements, to facilitate scheduling and resource allocation.

## Description
One row in this table represents a single tag definition used to classify work centers within the manufacturing module. This is a raw landing table in the staging layer, containing the base configuration for tags before they are associated with specific work center entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_workcenter_tag_id_seq`. |
| color | INTEGER | true | UI color index | Represents the color code assigned to the tag in the Odoo interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the tag. |
| name | VARCHAR | false | Tag name | The human-readable label for the work center tag. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `name` (Assuming tag names are unique within the system).

## Caveats for downstream consumers

- The `create_date` and `write_date` columns are system-generated timestamps; assume UTC unless otherwise specified by the Odoo instance configuration.
- This table contains no PII, but `create_uid` and `write_uid` link to internal user records which may be considered sensitive in some environments.
- There is no explicit soft-delete flag; records are likely hard-deleted from the source system if removed.
- The `color` column is an integer index used by the frontend and does not map to a standard hex code without a lookup table.