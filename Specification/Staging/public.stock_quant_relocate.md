# stock_quant_relocate

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence-based default value for the `id` column, which is characteristic of the Odoo ORM.

## Functional process 
This table supports the inventory management and warehouse logistics process, specifically tracking the relocation of stock quantities between locations or packages. It acts as a ledger or audit trail for movements of inventory items within the warehouse structure.

## Description
One row in this table represents a single relocation event or request for a stock quantity, detailing the destination location and package. As a staging table, it serves as a raw, landed copy of the relocation transaction history, capturing the user who initiated or modified the record and the associated timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_quant_relocate_id_seq` sequence. |
| dest_location_id | INTEGER | true | Foreign key to the destination location | References the warehouse location hierarchy. |
| dest_package_id | INTEGER | true | Foreign key to the destination package | References a specific shipping or storage package. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| message | TEXT | true | Descriptive note or reason for relocation | Often contains free-text audit information. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dest_location_id` → `stock_location.id` (Guess: standard Odoo inventory schema).
    - `dest_package_id` → `stock_quant_package.id` (Guess: standard Odoo inventory schema).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit fields (`create_uid`, `write_uid`) which are useful for tracking data lineage but may require joining to the `res_users` table to resolve human-readable names.
- The `message` field may contain unstructured data; ensure proper sanitization if used in downstream reporting or UI components.
- This is a staging table; verify if the source system performs soft deletes (often indicated by an `active` boolean column, which is absent here) or hard deletes.