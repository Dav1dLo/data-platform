# stock_rule

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `create_uid`, `write_date`, `picking_type_id`, `procure_method`) and the use of `JSONB` for translatable fields are characteristic of the Odoo framework's internal data structure for inventory and supply chain management.

## Functional process 
This table supports the inventory replenishment and supply chain routing process. It defines the rules that dictate how stock moves between locations, how procurement is triggered (e.g., "make to order" vs. "make to stock"), and how warehouse operations are sequenced based on routes and picking types.

## Description
One row represents a single inventory rule that governs the movement or procurement of stock within the warehouse system. It acts as a configuration entity in the staging layer, capturing the logic for how items flow from a source location to a destination location under specific conditions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_rule_id_seq` |
| group_id | INTEGER | true | Procurement group identifier | Links to grouping logic for replenishment |
| sequence | INTEGER | true | Execution priority | Lower numbers usually indicate higher priority |
| company_id | INTEGER | true | Owning company ID | Multi-company context |
| location_dest_id | INTEGER | false | Destination location ID | Mandatory target for the rule |
| location_src_id | INTEGER | true | Source location ID | Optional; null implies procurement/production |
| route_id | INTEGER | false | Parent route ID | Links to the master route definition |
| route_sequence | INTEGER | true | Sequence within the route | Ordering of rules within a specific route |
| picking_type_id | INTEGER | false | Picking operation type | Defines the warehouse operation type |
| delay | INTEGER | true | Lead time in days | Expected duration for the rule execution |
| partner_address_id | INTEGER | true | Partner/Vendor address ID | Used for drop-shipping or specific routing |
| warehouse_id | INTEGER | true | Warehouse ID | Associated warehouse context |
| propagate_warehouse_id | INTEGER | true | Propagate warehouse ID | Used for cross-warehouse replenishment |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates |
| group_propagation_option | VARCHAR | true | Group propagation strategy | e.g., 'propagate', 'fixed', 'none' |
| action | VARCHAR | false | Rule action type | e.g., 'pull', 'push', 'pull_push' |
| procure_method | VARCHAR | false | Procurement method | e.g., 'make_to_stock', 'make_to_order' |
| auto | VARCHAR | false | Automation trigger | e.g., 'manual', 'transparent' |
| push_domain | VARCHAR | true | Domain filter for push rules | Used to restrict rule applicability |
| name | JSONB | false | Rule name/description | Translatable field stored as JSON |
| active | BOOLEAN | true | Soft-delete flag | True if the rule is currently enabled |
| location_dest_from_rule | BOOLEAN | true | Destination source flag | Indicates if dest is derived from rule |
| propagate_cancel | BOOLEAN | true | Cancel propagation flag | Whether to propagate cancellations |
| propagate_carrier | BOOLEAN | true | Carrier propagation flag | Whether to propagate carrier info |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `location_dest_id` → `stock_location.id` (Guess: mandatory location reference)
    - `route_id` → `stock_location_route.id` (Guess: mandatory route reference)
    - `picking_type_id` → `stock_picking_type.id` (Guess: mandatory operation type reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** The `active` column should be filtered (`WHERE active = true`) to retrieve only currently valid rules.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Data Integrity:** This is a staging table; ensure joins to master data tables (like `stock_location`) handle potential missing references if the ETL process is not fully synchronized.