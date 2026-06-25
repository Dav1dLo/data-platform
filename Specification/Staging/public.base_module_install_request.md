# base_module_install_request

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention `base_module_install_request` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the module management and installation workflow within the application. It tracks requests or logs associated with the installation of software modules, potentially capturing user-initiated actions or system-generated notifications related to module deployment.

## Description
One row represents a single module installation request or log entry initiated by a user. This is a raw landing table in the staging layer, containing a direct copy of the source system's transactional data without business logic transformations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_module_install_request_id_seq`. |
| module_id | INTEGER | false | Identifier of the module being installed | Foreign key to a modules definition table. |
| user_id | INTEGER | false | Identifier of the user requesting the install | Foreign key to a users table. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field for record provenance. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Audit field for record provenance. |
| body_html | TEXT | true | HTML content associated with the request | Likely contains logs or notification messages. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `base_module.id` (guess: standard Odoo module reference)
    - `user_id` → `res_users.id` (guess: standard Odoo user reference)
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference)
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `body_html` column may contain raw HTML tags; ensure proper sanitization if rendering this data in downstream reporting tools.
- This table represents a raw staging entity; verify if the source system performs soft deletes, as this table does not contain an explicit `active` or `deleted` flag.
- `create_uid` and `write_uid` are nullable, which may occur if records were migrated or created via system-level processes without a specific user context.