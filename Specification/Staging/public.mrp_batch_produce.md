# mrp_batch_produce

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework, and the `mrp_` prefix indicating the Manufacturing Resource Planning module.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the production of batches or lots. It manages the configuration of separators used for labeling components and lots during the production cycle, as well as linking specific production quantities to production identifiers.

## Description
One row in this table represents a configuration or record of a specific batch production event within the manufacturing module. It serves as a raw landed staging entity, capturing the metadata and formatting parameters for lot tracking associated with a production order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_batch_produce_id_seq` |
| production_id | INTEGER | true | Foreign key to the production order | Links to the parent manufacturing order |
| lot_qty | INTEGER | true | Quantity of the lot produced | Unit of measure depends on the product |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` |
| lot_name | VARCHAR | true | Identifier or name of the lot | Human-readable lot code |
| component_separator | VARCHAR | false | Delimiter for component strings | Used for formatting output |
| lots_separator | VARCHAR | false | Delimiter for lot strings | Used for formatting output |
| lots_quantity_separator | VARCHAR | false | Delimiter for lot quantity strings | Used for formatting output |
| production_text | TEXT | true | Descriptive text for the production batch | Free-form notes |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id` (Guess: standard Odoo naming convention for manufacturing orders)
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit fields (`create_uid`, `write_uid`) which should be joined against the `res_users` table to resolve human-readable names.
- The `_separator` columns are configuration parameters; ensure these are handled correctly if concatenating strings in downstream transformations.
- No explicit soft-delete flag is present; assume records are hard-deleted if missing from source exports.