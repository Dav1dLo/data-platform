# calendar_filters

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences, is characteristic of Odoo's ORM-generated audit and tracking columns.

## Functional process 
This table supports the user-specific configuration of calendar views or scheduling interfaces. It tracks which partners are selected or "checked" for display within a user's calendar view, facilitating a personalized scheduling experience across the platform.

## Description
Each row represents a specific filter configuration for a user, defining whether a particular partner is enabled or visible in their calendar interface. As a staging table, it serves as a raw, landed copy of the operational database's filter settings, preserving the state of user-partner visibility preferences.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a database sequence. |
| user_id | INTEGER | false | Foreign key to the user | The owner of the calendar filter. |
| partner_id | INTEGER | false | Foreign key to the partner | The entity being filtered in the calendar. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this filter record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| active | BOOLEAN | true | Soft-delete flag | If false, the filter is effectively disabled. |
| partner_checked | BOOLEAN | true | Visibility toggle | Indicates if the partner is currently selected/visible. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo naming for user references).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo naming for partner references).
- **Natural keys (inferred):** 
    - `(user_id, partner_id)`: Represents the unique business relationship between a user and a partner's visibility setting.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column suggests a soft-delete pattern; queries should filter by `WHERE active = TRUE` to retrieve only current, valid configurations.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **PII:** While this table contains no direct PII (like emails), it links users to partners, which may be sensitive in certain compliance contexts.
- **Data Integrity:** As a staging table, expect potential duplicates or orphaned records if the upstream system's referential integrity is not strictly enforced at the database level.