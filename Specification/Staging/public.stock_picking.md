# stock_picking

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `stock_picking`, `picking_type_id`, `move_type`, `create_uid`) and the presence of specific integration columns like `pos_session_id` and `sale_id` are characteristic of Odoo's Inventory and Warehouse management module.

## Functional process 
This table supports the "Order-to-Delivery" or "Inventory Fulfillment" business process. It tracks the movement of goods within the warehouse, managing the lifecycle of picking operations from scheduling and assignment to a user, through to final completion (`date_done`) and potential returns or backorders.

## Description
One row in this table represents a single inventory picking operation, which is a document authorizing the movement of products between two locations. This is a raw landed copy of the Odoo `stock.picking` model, capturing the state, scheduling, and relational links to sales orders, point-of-sale sessions, and warehouse locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| backorder_id | INTEGER | true | Reference to parent backorder | Links to another picking record. |
| return_id | INTEGER | true | Reference to original picking | Used for return merchandise authorizations. |
| group_id | INTEGER | true | Procurement group ID | Used for grouping related moves. |
| location_id | INTEGER | false | Source location ID | Where the goods are picked from. |
| location_dest_id | INTEGER | false | Destination location ID | Where the goods are moved to. |
| picking_type_id | INTEGER | false | Picking operation type | Defines the workflow (e.g., receipt, delivery). |
| partner_id | INTEGER | true | Customer or vendor ID | The entity associated with the movement. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| user_id | INTEGER | true | Assigned user ID | The employee responsible for the picking. |
| owner_id | INTEGER | true | Stock owner ID | Used for third-party logistics/consignment. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | VARCHAR | true | Picking reference number | Human-readable identifier (e.g., WH/OUT/0001). |
| origin | VARCHAR | true | Source document reference | Usually the sales order or purchase order number. |
| move_type | VARCHAR | false | Fulfillment strategy | e.g., 'direct' or 'one' (all at once). |
| state | VARCHAR | true | Current lifecycle state | e.g., 'draft', 'waiting', 'assigned', 'done'. |
| priority | VARCHAR | true | Urgency level | Often '0' (normal) or '1' (urgent). |
| picking_properties | JSONB | true | Dynamic attributes | Stores flexible metadata for the picking. |
| note | TEXT | true | Internal notes | Free-text field for warehouse staff. |
| has_deadline_issue | BOOLEAN | true | Deadline flag | Indicates if the picking is delayed. |
| printed | BOOLEAN | true | Print status | Indicates if the picking slip was generated. |
| is_locked | BOOLEAN | true | Lock status | Prevents modification if true. |
| scheduled_date | TIMESTAMP | true | Planned execution date | Target date for the operation. |
| date_deadline | TIMESTAMP | true | Hard deadline | The latest date to complete the operation. |
| date | TIMESTAMP | true | Effective date | Date the picking was confirmed. |
| date_done | TIMESTAMP | true | Completion date | Actual timestamp when the picking was finished. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Record modification timestamp | UTC timestamp. |
| project_id | INTEGER | true | Project link | Links to project management module. |
| pos_session_id | INTEGER | true | POS session link | Links to Point of Sale activity. |
| pos_order_id | INTEGER | true | POS order link | Links to specific POS transaction. |
| sale_id | INTEGER | true | Sales order link | Links to the originating sales order. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner link)
    - `sale_id` → `sale_order.id` (Guess: links to the source sales order)
    - `location_id` / `location_dest_id` → `stock_location.id` (Guess: standard Odoo location link)
- **Natural keys (inferred):**
    - `name` (The picking reference number is typically unique within an Odoo instance)

## Caveats for downstream consumers

- **Timestamps:** All `date` fields are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually updated in place or marked as 'cancelled' in the `state` column.
- **Sensitive Data:** `partner_id` may link to PII in the `res_partner` table; ensure appropriate access controls.
- **State Logic:** The `state` column is the most critical field for filtering active vs. completed operations.
- **JSONB:** The `picking_properties` column requires PostgreSQL-specific JSON operators (e.g., `->>`) for extraction.