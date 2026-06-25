# mrp_production_split

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework, and the `mrp_` prefix indicating the Manufacturing Resource Planning module.

## Functional process 
This table supports the manufacturing production splitting process, which allows a single production order to be divided into smaller batches or sub-orders. It tracks the relationship between a parent production order and its split components, likely used to manage partial completions or parallel processing of manufacturing tasks.

## Description
One row in this table represents a single split instance or segment of a manufacturing production order. It serves as a raw landed copy of the Odoo `mrp.production.split` model, capturing the association between the split record and the original production order at the grain of one row per split event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_production_split_id_seq`. |
| production_split_multi_id | INTEGER | true | Foreign key to the multi-split parent | Likely links to a grouping entity for multiple splits. |
| production_id | INTEGER | true | Foreign key to the production order | Links to the parent `mrp.production` record. |
| counter | INTEGER | true | Sequence or iteration counter | Represents the index or count of the split. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id` (Evidence: standard Odoo naming convention for production order links).
    - `create_uid` → `res_users.id` (Evidence: standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (Evidence: standard Odoo audit field pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no PII, but `create_uid` and `write_uid` link to user identity tables which may be sensitive.
- The table represents a raw staging state; check for potential duplicates or partial updates if the ingestion process is not idempotent.
- Soft deletes are not explicitly implemented via a flag; assume records are hard-deleted if they disappear from the source.