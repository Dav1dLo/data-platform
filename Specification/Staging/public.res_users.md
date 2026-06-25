# res_users

## Source system
This table originates from Odoo ERP. The naming convention `res_users` (Resource Users) and specific columns like `odoobot_state`, `partner_id`, and `property_warehouse_id` are characteristic of the Odoo framework's core user management module.

## Functional process 
This table supports the Identity and Access Management (IAM) process within the ERP. It manages user authentication, system preferences, and sales-related performance tracking for internal employees and portal users.

## Description
One row in this table represents a single user account within the Odoo system. This is a raw landed staging table containing the primary user registry, including authentication credentials, system activity flags, and user-specific sales targets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Foreign key to the company | Links user to their primary organization. |
| partner_id | INTEGER | false | Foreign key to res_partner | Links user to their contact record. |
| active | BOOLEAN | true | Soft-delete flag | Defaults to true. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely UTC. |
| login | VARCHAR | false | Unique username/email | Used for authentication. |
| password | VARCHAR | true | Hashed password | Sensitive: do not expose. |
| action_id | INTEGER | true | Default action ID | Defines the landing view for the user. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| signature | TEXT | true | Email signature | HTML or plain text. |
| share | BOOLEAN | true | Portal user flag | Indicates if user is an external collaborator. |
| write_date | TIMESTAMP | true | Last update timestamp | Likely UTC. |
| totp_secret | VARCHAR | true | 2FA secret | Sensitive: do not expose. |
| tour_enabled | BOOLEAN | true | Onboarding tour status | Tracks if user has completed system tours. |
| notification_type | VARCHAR | false | Notification preference | e.g., 'email' or 'inbox'. |
| odoobot_state | VARCHAR | true | OdooBot interaction state | Tracks onboarding/chat bot progress. |
| odoobot_failed | BOOLEAN | true | OdooBot failure flag | Indicates if bot interaction failed. |
| sale_team_id | INTEGER | true | Default sales team | Links user to a specific sales department. |
| target_sales_won | INTEGER | true | Sales won target | Performance metric. |
| target_sales_done | INTEGER | true | Sales completed target | Performance metric. |
| website_id | INTEGER | true | Default website ID | Links user to a specific web portal. |
| target_sales_invoiced | INTEGER | true | Sales invoiced target | Performance metric. |
| property_warehouse_id | JSONB | true | Warehouse preferences | Stores complex/dynamic warehouse settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred from Odoo standard schema)
    - `partner_id` → `res_partner.id` (Inferred from Odoo standard schema)
    - `sale_team_id` → `crm_team.id` (Inferred from Odoo standard schema)
- **Natural keys (inferred):** 
    - `login` (The unique identifier for user authentication)

## Caveats for downstream consumers

- **Sensitive Data:** Columns `password` and `totp_secret` contain authentication credentials and must be masked or excluded from non-privileged reporting.
- **Timezones:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo, but verify against system configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical/inactive users are required.
- **JSONB:** The `property_warehouse_id` column contains semi-structured data; use PostgreSQL JSONB operators (e.g., `->>`) to extract values.