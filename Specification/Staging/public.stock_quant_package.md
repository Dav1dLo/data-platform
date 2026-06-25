# stock_quant_package

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_quant_package`), the use of `create_uid`/`write_uid` audit columns, and the sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the inventory management and logistics process, specifically tracking physical packaging units within a warehouse. It links inventory locations to specific packages, facilitating the grouping of stock items for shipping, storage, or internal movement.

## Description
One row in this table represents a single physical package or container used to group inventory items within the warehouse. It serves as a raw landed copy of the Odoo `stock.quant.package` model, capturing metadata such as the package type, current location, and shipping weight.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| package_type_id | INTEGER | true | Foreign key to package type | Defines the container category. |
| location_id | INTEGER | true | Foreign key to stock location | Current physical location of the package. |
| company_id | INTEGER | true | Foreign key to company | Multi-company isolation identifier. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | VARCHAR | false | Unique package reference | Human-readable identifier (e.g., barcode or label). |
| package_use | VARCHAR | false | Usage type | Indicates if the package is for shipping, internal, etc. |
| pack_date | DATE | true | Packaging date | The date the package was prepared. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time in UTC. |
| shipping_weight | DOUBLE PRECISION | true | Weight of the package | Units typically in kilograms. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `package_type_id` → `stock_package_type.id` (Guess: standard Odoo inventory relationship)
    - `location_id` → `stock_location.id` (Guess: standard Odoo inventory relationship)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company relationship)
- **Natural keys (inferred):** 
    - `name` (The unique package identifier/label)

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted if removed from the source.
- **Data Integrity:** `package_type_id`, `location_id`, and `company_id` are nullable, which may occur if the package is in transit or if the record is orphaned during system migration.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.