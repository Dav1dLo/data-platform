# product_label_layout

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based `id` and the specific functional domain of product labeling, is highly characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the product labeling and inventory documentation process. It stores configuration layouts for printing product labels, allowing users to define custom quantities, print formats, and additional HTML-based styling for label generation during warehouse or inventory operations.

## Description
One row in this table represents a single saved configuration layout for product label printing. It serves as a raw landed copy of the Odoo `product.label.layout` model, capturing the formatting and quantity settings used when generating labels for inventory items.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_label_layout_id_seq`. |
| custom_quantity | INTEGER | false | Number of labels to print | Used when the print quantity is manually specified. |
| pricelist_id | INTEGER | true | Foreign key to pricelist | Links the layout to a specific pricing configuration. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the layout. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the layout. |
| print_format | VARCHAR | false | Label template identifier | Defines the physical layout/template used for printing. |
| extra_html | TEXT | true | Custom HTML content | Optional field for injecting custom styling or data into the label. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |
| move_quantity | VARCHAR | false | Quantity source logic | Defines how the quantity is calculated (e.g., 'move', 'custom'). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pricelist_id` → `product_pricelist.id` (Guess: links to the standard Odoo pricelist table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`,