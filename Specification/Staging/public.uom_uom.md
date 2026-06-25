# uom_uom

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`uom_uom`), the use of `create_uid`/`write_uid` for audit tracking, and the `JSONB` data type for multi-language field support (`name`).

## Functional process 
This table supports the inventory and product management process by defining Units of Measure (UoM) used across the platform. It manages conversion factors and rounding precision for various units, ensuring consistency when calculating quantities for stock movements, sales orders, and purchase orders.

## Description
One row represents a single unit of measure definition, such as "Kilogram" or "Piece," within the system. This is a raw staging table containing the direct landing of UoM records, serving as the foundation for downstream dimension tables that normalize unit conversions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `uom_uom_id_seq`. |
| category_id | INTEGER | false | Foreign key to UoM category | Links to the category grouping (e.g., Weight, Length). |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| uom_type | VARCHAR | false | Type of unit | Indicates if it is a reference, bigger, or smaller unit. |
| name | JSONB | false | Unit name | Multi-language string stored as JSON. |
| factor | NUMERIC | false | Conversion factor | Ratio used to convert this unit to the reference unit. |
| rounding | NUMERIC | false | Rounding precision | Defines the decimal precision for this unit. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the unit is currently available for use. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `category_id` → `uom_category.id`: This column groups units of measure into logical categories.
    - `create_uid` → `res_users.id`: References the system user who performed the creation.
    - `write_uid` → `res_users.id`: References the system user who performed the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to internal employee records.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if local time conversion is required.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only currently valid units.
- **Data Structure:** The `name` column is `JSONB`; use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract specific language values.