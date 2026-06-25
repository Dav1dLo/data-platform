# sale_order_mass_cancel_wizard_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with `wizard` and `sale_order` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link wizard session objects to specific sale order records during bulk processing operations.

## Functional process 
This table supports the "Bulk Order Cancellation" business process. It acts as a join table that tracks which specific sale orders have been selected or queued for cancellation within a mass-action wizard interface before the final commit of the cancellation process.

## Description
One row in this table represents a single association between a mass cancellation wizard session and a specific sale order. It serves as a raw landing copy of the relationship state, allowing the system to track the scope of a bulk cancellation request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_mass_cancel_orders_id | INTEGER | false | Foreign key to the mass cancellation wizard session. | Represents the parent wizard instance. |
| sale_order_id | INTEGER | false | Foreign key to the sale order being cancelled. | Represents the child record targeted for cancellation. |

## Keys

- **Primary key (inferred):** The combination of `(sale_mass_cancel_orders_id, sale_order_id)`.
- **Foreign keys (inferred):** 
    - `sale_mass_cancel_orders_id` → `sale_mass_cancel_orders.id`: This column links to the wizard session header record.
    - `sale_order_id` → `sale_order.id`: This column links to the actual sales order record in the system.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a transient relationship table; records are likely purged or cleared once the wizard session is completed or closed.
- There is no audit timestamp or status flag in this table; it only represents the existence of a link at the time of ingestion.
- As a join table, it does not contain business logic or order details; join with `sale_order` to retrieve order-specific attributes.