# sale_order_discount

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for primary keys, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the sales order management process by tracking specific discount applications associated with sales orders. It captures the business logic for price reductions, allowing for both fixed-amount discounts and percentage-based adjustments within the order-to-cash pipeline.

## Description
One row in this table represents a single discount record applied to a specific sales order. It serves as a raw landed copy of the source system's discount entity, providing the granular details of how and when a discount was applied to an order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sale_order_discount_id_seq` sequence. |
| sale_order_id | INTEGER | false | Foreign key to the parent sales order | Links to the primary sales order entity. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| discount_type | VARCHAR | true | Categorization of the discount | E.g., 'fixed', 'percentage', or 'promotional'. |
| discount_amount | NUMERIC | true | Fixed monetary value of the discount | Currency units depend on the parent order. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| discount_percentage | DOUBLE PRECISION | true | Percentage value of the discount | Represented as a decimal (e.g., 0.10 for 10%). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sale_order_id` → `sale_order.id` (Inferred from the standard Odoo naming convention linking child records to parent orders).
    - `create_uid` → `res_users.id` (Inferred from standard Odoo audit column patterns).
    - `write_uid` → `res_users.id` (Inferred from standard Odoo audit column patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit fields (`create_uid`, `write_uid`) which refer to internal system user IDs; these may not be meaningful without joining to the corresponding user dimension table.
- The `discount_amount` and `discount_percentage` columns are both nullable; ensure logic handles cases where only one or neither is populated.
- This is a staging table; it may contain raw data that has not yet been cleaned or validated for business reporting.