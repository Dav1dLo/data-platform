# procurement_group

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is highly characteristic of the Odoo ORM framework.

## Functional process 
This table supports the procurement and supply chain management process, specifically tracking the grouping of supply requirements. It links procurement activities to specific business entities such as partners (`partner_id`), point-of-sale orders (`pos_order_id`), and sales orders (`sale_id`), facilitating the consolidation of demand across different sales channels.

## Description
One row in this table represents a single procurement group, which acts as a container for related supply requirements or stock moves. It serves as a raw landed copy of the procurement group entity from the source ERP, capturing the audit trail of creation and modification alongside its association with upstream sales or POS transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `procurement_group_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the partner/customer | Likely references a `res_partner` table. |
| create_uid | INTEGER | true | User ID who created the record | References a user in the system. |
| write_uid | INTEGER | true | User ID who last modified the record | References a user in the system. |
| name | VARCHAR | false | Unique identifier or reference code | The business-facing name of the group. |
| move_type | VARCHAR | true | Classification of the procurement move | Defines the nature of the grouping logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| pos_order_id | INTEGER | true | Associated Point of Sale order | References a `pos_order` table. |
| sale_id | INTEGER | true | Associated Sales order | References a `sale_order` table. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming convention for partner associations).
    - `pos_order_id` → `pos_order.id` (Direct association with POS order records).
    - `sale_id` → `sale_order.id` (Direct association with sales order records).
- **Natural keys (inferred):** 
    - `name` (In Odoo, the `name` field on procurement groups is typically a unique sequence-generated string).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit columns:** `create_uid` and `write_uid` refer to internal system user IDs; these will not resolve to human-readable names without joining to the system's user table.
- **Data Integrity:** As a staging table, this data is a direct reflection of the source; expect potential nulls in foreign key fields (`partner_id`, `sale_id`, `pos_order_id`) depending on whether the procurement group was triggered by a sales order or an internal replenishment.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically removed if deleted in the source system.