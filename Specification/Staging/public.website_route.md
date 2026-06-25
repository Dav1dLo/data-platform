# website_route

## Source system
This table likely originates from an Odoo ERP or a similar Python-based web framework application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns is a standard pattern for Odoo's ORM audit fields, which track record creation and modification metadata.

## Functional process 
This table supports the web content management or routing process, mapping URL paths to specific website resources. It is used to manage the navigation structure or URL aliases within the application's web module.

## Description
One row in this table represents a single defined route or URL path within the website's navigation system. As a staging table, it serves as a raw, landed copy of the source system's routing configuration, intended for downstream transformation into a more structured navigation dimension.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.website_route_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| path | VARCHAR | true | The URL path string | The relative path (e.g., '/home' or '/products'). |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit field pattern).
- **Natural keys (inferred):** 
    - `path` (assuming the application enforces unique URL paths).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC; verify against source system configuration if precision is required.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `is_deleted` flag; assume all rows are currently active unless otherwise specified by the source system logic.
- **Data Quality:** The `path` column is nullable; queries filtering by path should account for potential null values.