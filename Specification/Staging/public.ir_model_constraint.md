# ir_model_constraint

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_constraint` (Internal Registry model constraint) is a standard component of the Odoo framework's metadata layer, used to track database-level constraints associated with ORM models.

## Functional process 
This table supports the Odoo framework's internal schema management and metadata tracking. It records the constraints (such as unique, check, or foreign key constraints) defined on ORM models, ensuring that the application layer remains synchronized with the underlying database schema.

## Description
One row in this table represents a single database constraint definition associated with a specific Odoo model. As a staging table, it serves as a raw landed copy of the system's internal metadata, capturing the constraint's name, type, and the associated module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_model_constraint_id_seq`. |
| model | INTEGER | false | Foreign key to `ir_model` | References the model this constraint belongs to. |
| module | INTEGER | false | Foreign key to `ir_module_module` | References the module that defines this constraint. |
| create_uid | INTEGER | true | Creator user ID | References `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users`. |
| name | VARCHAR | false | Constraint name | The identifier of the constraint in the database. |
| definition | VARCHAR | true | SQL definition | The raw SQL definition of the constraint. |
| type | VARCHAR(1) | false | Constraint type | e.g., 'u' for unique, 'f' for foreign key, 'c' for check. |
| message | JSONB | true | Error message | Localized error messages stored as JSON. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last modification. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model` → `ir_model.id`: Links the constraint to the specific ORM model definition.
    - `module` → `ir_module_module.id`: Links the constraint to the Odoo module that introduced it.
    - `create_uid` / `write_uid` → `res_users.id`: Links to the user who performed the action (guesses).
- **Natural keys (inferred):** 
    - `name`: In Odoo, constraint names are typically unique within the database schema.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains no PII, but `create_uid` and `write_uid` link to internal system users.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the current state of the Odoo metadata registry.
- **JSONB:** The `message` column contains structured data; ensure your SQL dialect supports JSONB operators if parsing this field.