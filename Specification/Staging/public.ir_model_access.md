# ir_model_access

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_access` is a standard internal Odoo table used to manage the Access Control List (ACL) for the platform's ORM layer.

## Functional process 
This table supports the security and authorization framework of the application. It defines which user groups have specific CRUD (Create, Read, Update, Delete) permissions on individual data models within the system, ensuring that access control is enforced at the database-backed object level.

## Description
One row in this table represents a specific access rule assigned to a user group for a particular data model. It acts as a raw landed copy of the system's security configuration, capturing the boolean permission flags and audit metadata for each access entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_model_access_id_seq`. |
| model_id | INTEGER | false | Foreign key to the model definition | Links to the model being governed. |
| group_id | INTEGER | true | Foreign key to the user group | If null, the rule may apply globally or to all users. |
| create_uid | INTEGER | true | ID of the user who created the rule | Links to `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the rule | Links to `res_users`. |
| name | VARCHAR | false | Descriptive name of the access rule | Often a human-readable label for the rule. |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the system. |
| perm_read | BOOLEAN | true | Read permission flag | Allows viewing records of the model. |
| perm_write | BOOLEAN | true | Write permission flag | Allows updating records of the model. |
| perm_create | BOOLEAN | true | Create permission flag | Allows creating new records of the model. |
| perm_unlink | BOOLEAN | true | Unlink (delete) permission flag | Allows deleting records of the model. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id`: This column references the system's internal model registry.
    - `group_id` → `res_groups.id`: This column references the security groups defined in the system.
    - `create_uid` / `write_uid` → `res_users.id`: These columns reference the system's user directory.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` to see current effective rules.
- **Nullability:** Many permission flags (`perm_*`) may be null; in Odoo logic, these are typically treated as `FALSE` if not explicitly set.
- **Sensitivity:** This table contains security configuration data; while it does not contain PII, it defines the security posture of the entire application.