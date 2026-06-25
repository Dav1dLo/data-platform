# product_attribute_custom_value

## Source system
The table originates from an Odoo ERP system. This is evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`), which are standard audit fields in Odoo, and the specific reference to `pos_order_line_id` and `sale_order_line_id` which are core modules within the Odoo framework.

## Functional process 
This table supports the product configuration and sales order customization process. It captures user-defined values for product attributes that are specific to individual line items within Point of Sale (POS) or Sales orders, allowing for dynamic product customization (e.g., custom engraving text or specific user-selected options) that falls outside standard product variants.

## Description
One row in this table represents a single custom attribute value assigned to a specific line item in a sales or POS order. It serves as a raw landing copy of the Odoo database table, maintaining the link between custom attribute definitions and the transactional order lines they modify.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `product_attribute_custom_value_id_seq`. |
| custom_product_template_attribute_value_id | INTEGER | false | Reference to the attribute definition | Links to the template attribute value configuration. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| custom_value | VARCHAR | true | The custom input string | The actual text or value provided by the user. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| pos_order_line_id | INTEGER | true | POS order line reference | Foreign key to the POS order line. |
| sale_order_line_id | INTEGER | true | Sales order line reference | Foreign key to the Sales order line. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_order_line_id` → `pos_order_line.id` (Guess: links to POS transaction line)
    - `sale_order_line_id` → `sale_order_line.id` (Guess: links to Sales transaction line)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are generally stored in UTC by Odoo, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs, which may not be present in the `res_users` table if that table was not also ingested.
- **Data Integrity:** A row will typically have either a `pos_order_line_id` or a `sale_order_line_id` populated, but rarely both, depending on the sales channel.