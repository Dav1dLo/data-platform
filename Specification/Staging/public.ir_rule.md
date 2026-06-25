# ir_rule

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_rule` (Internal Record Rule) and the presence of columns like `model_id`, `create_uid`, and `domain_force` are characteristic of Odoo's security and access control framework.

## Functional process 
This table supports the platform's security and access control management. It defines row-level security (RLS) rules that restrict which records a user can access or modify based on specific domain filters (`domain_force`) applied to particular data models.

## Description
One row in this table represents a single security rule definition applied to a specific data model within the Odoo environment. It serves as a raw landed copy of the system's access configuration, defining the conditions and permissions (read, write, create, unlink) that govern data visibility and manipulation for users.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_rule_id_seq`. |
| model_id | INTEGER | false | Foreign key to the target model | References the model to which the rule applies. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the rule. |
| name | VARCHAR | true | Rule name | Descriptive label for the security rule. |
| domain_force | TEXT | true | Filter domain | The Odoo domain expression used to filter records. |
| active | BOOLEAN | true | Active status | Indicates if the rule is currently enabled. |
| perm_read | BOOLEAN | true | Read permission | Flag for read access. |
| perm_write | BOOLEAN | true | Write permission | Flag for update access. |
| perm_create | BOOLEAN | true | Create permission | Flag for insert access. |
| perm_unlink | BOOLEAN | true | Delete permission | Flag for delete access. |
| global | BOOLEAN | true | Global scope flag | If true, the rule applies to all users. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the rule was created. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp when the rule was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id` (guess: standard Odoo schema linking rules to model definitions).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit trail linking to user records).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit trail linking to user records).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in UTC in Odoo; verify against system configuration.
- **Data Sensitivity:** While this table contains no PII, it defines the security posture of the entire application. Access to this table should be restricted to administrative roles.
- **Soft Deletes:** Odoo often uses the `active` column to manage logical deletion; rows with `active = false` should generally be excluded from standard reporting.
- **Domain Syntax:** The `domain_force` column contains Odoo-specific domain syntax (e.g., `[('company_id', '=', user.company_id.id)]`), which is not directly executable as standard SQL.