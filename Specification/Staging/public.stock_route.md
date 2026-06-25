# stock_route

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`), the use of `JSONB` for translatable fields like `name`, and the specific pattern of `_selectable` boolean flags are characteristic of Odoo's internal ORM structure for managing inventory routing rules.

## Functional process 
This table supports the inventory management and supply chain configuration process. It defines the paths or "routes" that products or warehouses follow during replenishment or fulfillment, determining how stock moves between locations (e.g., cross-docking, dropshipping, or internal transfers).

## Description
One row in this table represents a single inventory route configuration within the system. It acts as a raw landed copy of the Odoo `stock.route` model, capturing the sequence, scope, and applicability of specific stock movement rules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_route_id_seq` |
| sequence | INTEGER | true | Display order priority | Lower numbers usually indicate higher priority |
| supplied_wh_id | INTEGER | true | Destination warehouse ID | Foreign key to warehouse |
| supplier_wh_id | INTEGER | true | Source warehouse ID | Foreign key to warehouse |
| company_id | INTEGER | true | Owning company ID | Multi-tenant identifier |
| create_uid | INTEGER | true | User ID who created the record | Reference to res.users |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to res.users |
| name | JSONB | false | Route name | Often contains multi-language dictionary |
| active | BOOLEAN | true | Soft-delete flag | If false, the route is archived |
| product_selectable | BOOLEAN | true | Applicable to products | Flag for UI/logic filtering |
| product_categ_selectable | BOOLEAN | true | Applicable to categories | Flag for UI/logic filtering |
| warehouse_selectable | BOOLEAN | true | Applicable to warehouses | Flag for UI/logic filtering |
| packaging_selectable | BOOLEAN | true | Applicable to packaging | Flag for UI/logic filtering |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |
| sale_selectable | BOOLEAN | true | Applicable to sales orders | Flag for UI/logic filtering |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `supplied_wh_id` → `stock_warehouse.id` (Guess: links to the receiving warehouse)
    - `supplier_wh_id` → `stock_warehouse.id` (Guess: links to the supplying warehouse)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user tables which may contain PII; ensure appropriate access controls.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column should be used to filter out archived routes; do not assume all rows are currently in use.
- **JSONB:** The `name` column is a `JSONB` object; use PostgreSQL `->>` operator to extract the string value (e.g., `name->>'en_US'`).