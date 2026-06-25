# stock_return_picking

## Source system
This table originates from an Odoo ERP system. The naming convention (`stock_return_picking`), the use of `create_uid`/`write_uid` for audit trails, and the sequence-based `id` are characteristic patterns found in Odoo's PostgreSQL database schema for inventory management modules.

## Functional process 
This table supports the inventory return process, specifically tracking the association between a return request and the original picking (warehouse movement) operation. It acts as a link between a customer or vendor return and the corresponding stock movement record, facilitating the reversal of inventory transactions.

## Description
One row in this table represents a single return operation linked to a specific warehouse picking event. As a staging table, it provides a raw, landed copy of the Odoo `stock_return_picking` model, capturing the audit metadata and the relationship between the return and the original picking document.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_return_picking_id_seq`. |
| picking_id | INTEGER | true | Foreign key to the original picking | References the `stock_picking` table. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id`: This column links the return record to the specific warehouse movement being reversed.
    - `create_uid` → `res_users.id`: Tracks the system user who initiated the return record.
    - `write_uid` → `res_users.id`: Tracks the system user who last updated the return record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains audit fields (`create_uid`, `write_uid`) which are internal to the ERP and may require joining against a user dimension table for meaningful reporting.
- The table represents a staging layer; ensure that downstream models handle potential duplicates or late-arriving data if the ingestion process is incremental.
- No PII is explicitly present, but `create_uid` and `write_uid` link to user identities.