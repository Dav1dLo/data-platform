# hr_employee_category

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values (`nextval` on `id`), which are characteristic of Odoo's ORM layer.

## Functional process 
This table supports the Human Resources management module, specifically the categorization of employees. It is used to define labels or tags (e.g., "Full-time", "Contractor", "Remote") that can be assigned to employee records to facilitate filtering, reporting, and organizational grouping.

## Description
One row in this table represents a single employee category definition. It serves as a raw landed lookup table in the staging layer, providing the master list of available categories that can be associated with employee profiles.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_employee_category_id_seq`. |
| color | INTEGER | true | UI color index | Represents the color code used in the Odoo web interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | VARCHAR | false | Category name | The human-readable label for the category. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone is typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone is typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `name` (Assuming category names are unique within the system).

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not implement soft deletes; it is a simple lookup table.
- The `color` column contains integer values that map to specific CSS classes or color palettes in the source application; they have no inherent semantic meaning outside the application UI.
- `create_uid` and `write_uid` refer to internal system users and may not be resolvable if the `res_users` table is not present in the staging environment.