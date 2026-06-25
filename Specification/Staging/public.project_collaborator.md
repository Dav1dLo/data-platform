# project_collaborator

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence for the primary key, is highly characteristic of the Odoo ORM framework.

## Functional process 
This table supports the project management and partner relationship modules by defining the association between specific projects and external partners. It manages access control and audit trails for collaborators, determining which partners are linked to which projects and whether their access is restricted.

## Description
One row in this table represents a single association between a project and a partner, defining the scope of their collaboration. This is a raw landed staging table, serving as a direct reflection of the source system's link table before any business logic or data cleaning is applied.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence `project_collaborator_id_seq`. |
| project_id | INTEGER | false | Foreign key to the project | Links to the project entity. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the partner/contact entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| limited_access | BOOLEAN | true | Access restriction flag | Indicates if the collaborator has restricted permissions. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `project.id` (Inferred from standard naming conventions in Odoo-like systems).
    - `partner_id` → `res_partner.id` (Inferred from standard naming conventions in Odoo-like systems).
- **Natural keys (inferred):** 
    - `(project_id, partner_id)`: The combination of project and partner is expected to be unique for a single collaboration record.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, as is standard for Odoo-based systems, but verify against the source system configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs and may not be resolvable without access to the corresponding user dimension table.
- **Data Integrity:** As a staging table, this may contain orphaned records if the source system does not enforce strict referential integrity at the database level.