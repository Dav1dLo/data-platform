# stock_track_line

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based `id` and a `wizard_id` reference, is highly characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports inventory tracking and wizard-based stock management processes. It appears to capture transient or specific line-item data related to stock tracking operations initiated through an Odoo "wizard" (a temporary UI-driven workflow), linking products to these specific tracking sessions.

## Description
One row in this table represents a single line item within a stock tracking wizard session. As a staging table, it serves as a raw, landed copy of the operational data before any business logic or transformation is applied. It tracks which product was involved in a specific wizard-driven stock operation and maintains the audit trail of who created or modified the record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.stock_track_line_id_seq` |
| product_id | INTEGER | true | Reference to the product being tracked | Foreign key to a product master table |
| wizard_id | INTEGER | true | Reference to the parent wizard session | Links to the specific tracking operation |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Inferred from Odoo naming conventions)
    - `wizard_id` → `stock_track_wizard.id` (Inferred from Odoo naming conventions)
    - `create_uid` → `res_users.id` (Standard Odoo audit column)
    - `write_uid` → `res_users.id` (Standard Odoo audit column)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table contains audit columns (`create_uid`, `write_uid`) which refer to internal system user IDs; these may not be meaningful without joining to the `res_users` table.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This is a staging table; it may contain transient data from wizard sessions that are not persisted in long-term inventory history.
- No explicit soft-delete flag is present; assume records are either hard-deleted or represent immutable event logs.