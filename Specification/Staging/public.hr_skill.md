# hr_skill

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `JSONB` for translatable fields) is characteristic of Odoo's ORM-based PostgreSQL schema structure.

## Functional process 
This table supports the Human Resources management module, specifically tracking employee competency profiles or skill definitions. It serves as a lookup or configuration table for the types of skills that can be assigned to employees within the organization.

## Description
One row in this table represents a single skill definition available within the HR system. It acts as a raw landing copy of the skill master data, capturing the skill's identity, its ordering sequence, and audit metadata for tracking record creation and modifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_skill_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort skills in UI dropdowns. |
| skill_type_id | INTEGER | false | Foreign key to skill category | Links to the parent skill type/category. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | JSONB | false | Skill name | Multilingual field stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `skill_type_id` → `hr_skill_type.id` (Guess: links to a parent category table common in Odoo).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; you will likely need to extract the specific language key (e.g., `name->>'en_US'`) to use it in reports.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table does not appear to implement soft deletes; it follows standard Odoo audit patterns.
- `skill_type_id` is mandatory, implying every skill must belong to a defined category.