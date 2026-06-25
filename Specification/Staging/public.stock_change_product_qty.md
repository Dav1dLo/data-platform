# stock_change_product_qty

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `product_tmpl_id`, `create_uid`, `write_uid`) and the use of sequence-based primary keys are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the inventory management and stock adjustment process. It tracks specific quantity updates for products, likely linked to the "Update Quantity" wizard or stock adjustment workflows within the inventory module, capturing both the product reference and the resulting new quantity state.

## Description
One row in this table represents a single recorded change or adjustment to a product's stock quantity. As a staging table, it serves as a raw, landed copy of the Odoo database record, capturing the state of a quantity update event at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_change_product_qty_id_seq`. |
| product_id | INTEGER | false | Unique identifier for the specific product variant | Foreign key to the product variant table. |
| product_tmpl_id | INTEGER | false | Unique identifier for the product template | Links to the base product definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| new_quantity | NUMERIC | false | The updated stock quantity value | Represents the absolute quantity after the change. |
| create_date | TIMESTAMP | true | Timestamp of record creation | In UTC, per standard Odoo behavior. |
| write_date | TIMESTAMP | true | Timestamp of last modification | In UTC, per standard Odoo behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo link to product variant).
    - `product_tmpl_id` → `product_template.id` (Guess: standard Odoo link to product template).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo link to user accounts).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in UTC.
- This table contains audit fields (`create_uid`, `write_uid`) which are standard in Odoo for tracking record provenance.
- The `new_quantity` column represents the state at the time of the record; it is not a delta (change amount), but the resulting total.
- No explicit soft-delete flag is present; standard Odoo behavior usually involves `active` columns, which are absent here.