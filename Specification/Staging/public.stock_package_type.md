# stock_package_type

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of `company_id` are characteristic of Odoo's internal ORM structure for managing master data entities.

## Functional process 
This table supports the logistics and inventory management process by defining the physical specifications of packaging types used for shipping or storage. It is used to standardize container dimensions and weight capacities, which are likely referenced during the picking and packing stages of the order fulfillment pipeline.

## Description
One row in this table represents a specific type of packaging (e.g., "Box Small", "Pallet", "Envelope") available for use within the inventory system. This is a raw landed staging table containing the master definitions of package dimensions and weight constraints, intended to be used for downstream logistics calculations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| sequence | INTEGER | true | Display order index | Used for sorting in UI dropdowns. |
| company_id | INTEGER | true | Foreign key to company | Links the package type to a specific business unit. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | VARCHAR | false | Package type name | The descriptive label for the packaging. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning the package type in a warehouse. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| height | DOUBLE PRECISION | true | Height dimension | Unit of measure is typically defined in system settings. |
| width | DOUBLE PRECISION | true | Width dimension | Unit of measure is typically defined in system settings. |
| packaging_length | DOUBLE PRECISION | true | Length dimension | Unit of measure is typically defined in system settings. |
| base_weight | DOUBLE PRECISION | true | Empty package weight | The weight of the packaging material itself. |
| max_weight | DOUBLE PRECISION | true | Maximum weight capacity | The weight limit for the package. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** 
    - `name` (Assuming unique package names within a company context).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Units of Measure:** The dimensions (height, width, length) and weights do not have explicit units in this table; check the corresponding Odoo `uom` tables or system parameters for the global configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Data Quality:** As a staging table, ensure that `name` is trimmed of whitespace before joining to other entities.