# stock_picking_sms_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, and `stock_picking` is the standard internal identifier for inventory movement documents in that platform.

## Functional process 
This table supports the inventory management and notification process. It acts as a join table linking specific stock picking operations (warehouse movements) to SMS confirmation records, facilitating the tracking of which SMS notifications have been triggered or associated with specific inventory movements.

## Description
One row in this table represents a single association between a stock picking record and an SMS confirmation record. It is a raw landing copy of a many-to-many relationship table, used to resolve the link between inventory movements and their corresponding notification logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| confirm_stock_sms_id | INTEGER | false | Foreign key to the SMS confirmation record | Represents the ID of the notification event. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Represents the ID of the inventory movement. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`confirm_stock_sms_id`, `stock_picking_id`).
- **Foreign keys (inferred):** 
    - `confirm_stock_sms_id` → `confirm_stock_sms.id` (guess: links to the SMS notification entity).
    - `stock_picking_id` → `stock_picking.id` (guess: links to the core inventory movement entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Expect no timestamps or status flags; these must be retrieved by joining to the parent tables.
- Ensure inner joins are used if you only require records where both the SMS and the stock picking exist.