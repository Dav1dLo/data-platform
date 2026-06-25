# change_password_user

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework.

## Functional process 
This table supports the user security and authentication management process, specifically tracking password change requests or history. It links specific user accounts to password change events, likely managed through an administrative or self-service "wizard" interface.

## Description
One row in this table represents a single password change event or request associated with a specific user. It serves as a raw landed staging record capturing the state of a password change transaction, including the user involved and the administrative context of the change.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `change_password_user_id_seq`. |
| wizard_id | INTEGER | false | Identifier for the wizard session | Likely links to a parent wizard configuration table. |
| user_id | INTEGER | false | Foreign key to the user | References the system user account. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field for record creation. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Audit field for record modification. |
| user_login | VARCHAR | true | User login identifier | Denormalized copy of the user's login name. |
| new_passwd | VARCHAR | true | New password value | Sensitive data; likely hashed or masked. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the creator).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the modifier).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `new_passwd` column contains sensitive authentication information and should be masked or excluded from non-privileged reporting.
- **Timestamps:** All `_date` fields are assumed to be in UTC.
- **Data Integrity:** As a staging table, this may contain transient data from incomplete wizard sessions; ensure queries filter for valid or completed states if a status column is identified in related tables.
- **Soft Deletes:** This table does not appear to implement soft deletes; assume standard CRUD operations.