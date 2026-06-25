# stock_scrap_reason_tag

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for the `name` column are characteristic patterns of Odoo's ORM-based database schema.

## Functional process 
This table supports the inventory management and quality control processes by defining tags used to categorize reasons for scrapping stock. It allows warehouse staff to label damaged or obsolete inventory items with specific, user-defined reasons for disposal.

## Description
One row in this table represents a single scrap reason tag definition available for selection in the inventory module. This is a raw landed copy of the Odoo configuration table, serving as the staging entity for downstream reporting on inventory loss and scrap analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_scrap_reason_tag_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort tags in the user interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| color | VARCHAR | true | UI color code | Represents the color associated with the tag. |
| name | JSONB | false | Tag name | Multilingual label stored as a JSON object. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; queries will need to extract the specific language key (e.g., `name->>'en_US'`) to retrieve a readable string.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC by the Odoo application.
- This table contains configuration data; it is unlikely to contain PII, but `create_uid` and `write_uid` link to internal user identities.
- The table does not implement soft deletes; records are typically hard-deleted in the source system.