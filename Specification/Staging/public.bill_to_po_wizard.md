# bill_to_po_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `_id`, `_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the "Procure-to-Pay" or "Vendor Bill" business process. It acts as a transient wizard or helper object used within the application interface to facilitate the association of vendor bills or invoices with existing purchase orders, likely during the reconciliation or payment matching workflow.

## Description
One row in this table represents a single execution or state of the "Bill to Purchase Order" wizard session. It serves as a raw landing copy of the wizard's temporary data, capturing the linkage between a specific partner and a purchase order as defined by a user during the billing process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `bill_to_po_wizard_id_seq`. |
| purchase_order_id | INTEGER | true | Foreign key to the purchase order | Links to the target PO being billed. |
| partner_id | INTEGER | true | Foreign key to the partner/vendor | The vendor associated with the bill. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id` (Likely target based on Odoo standard schema).
    - `partner_id` → `res_partner.id` (Likely target based on Odoo standard schema).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit columns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table represents a "wizard" state, meaning it is likely transient and may contain incomplete or short-lived data compared to core transactional tables.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- No explicit soft-delete flag is present; however, Odoo tables often rely on the existence of the record itself rather than a flag.
- `create_uid` and `write_uid` refer to internal system user IDs; ensure you join against the appropriate user dimension table to resolve names.