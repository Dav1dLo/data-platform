# stock_storage_category

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the inventory management and warehouse configuration process. It defines categories for storage locations, allowing the system to enforce constraints such as weight limits and product placement rules (e.g., `allow_new_product`) within specific storage areas.

## Description
One row in this table represents a single storage category definition used to classify warehouse locations. This is a raw landed copy of the configuration entity, intended to provide metadata for inventory optimization and storage capacity planning.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_storage_category_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to a multi-tenant company entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Name of the storage category | Human-readable label. |
| allow_new_product | VARCHAR | false | Flag for product placement policy | Likely stores 'all', 'empty', or 'none'. |
| max_weight | NUMERIC | true | Maximum weight capacity | Unit of measure is typically defined by system settings. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** 
    - `name` (Assuming storage category names are unique within a company context).

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- The `allow_new_product` column uses a `VARCHAR` type; check for specific string values (e.g., 'all', 'empty') as these are likely constrained by application logic rather than database enums.
- This table contains no PII, but `create_uid` and `write_uid` link to user identity data which may be considered sensitive in some compliance contexts.
- No soft-delete flag is present; records are likely hard-deleted or maintained indefinitely.