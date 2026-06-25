# crm_team

## Source system
This table originates from an Odoo ERP environment, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `write_date`, and the use of `JSONB` for localized fields (e.g., `name`). The structure is typical of Odoo's `crm.team` model, which manages sales teams and their associated configuration.

## Functional process 
This table supports the Sales Management and Lead Assignment processes. It defines the organizational structure of sales teams, including their operational settings (`use_leads`, `use_opportunities`), performance targets (`invoiced_target`), and automated lead distribution logic (`assignment_domain`).

## Description
One row in this table represents a single sales team or department within the CRM module. It serves as a raw landed copy of the team configuration, capturing both identity metadata and functional business rules that dictate how leads and opportunities are routed and managed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order | Used for UI sorting. |
| company_id | INTEGER | true | Related company ID | Foreign key to a company table. |
| user_id | INTEGER | true | Team leader ID | Foreign key to a user/employee table. |
| color | INTEGER | true | UI color index | Used for calendar/dashboard styling. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for last update. |
| name | JSONB | false | Team name | Likely contains multi-language strings. |
| active | BOOLEAN | true | Soft-delete flag | If false, the team is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| alias_id | INTEGER | false | Email alias ID | Links to an email routing alias. |
| assignment_domain | VARCHAR | true | Lead assignment filter | Domain expression for lead routing. |
| lead_properties_definition | JSONB | true | Custom lead fields | Schema definition for dynamic properties. |
| use_leads | BOOLEAN | true | Lead management enabled | Flag for lead pipeline usage. |
| use_opportunities | BOOLEAN | true | Opportunity management enabled | Flag for opportunity pipeline usage. |
| assignment_optout | BOOLEAN | true | Assignment opt-out | Flag to exclude team from auto-assignment. |
| invoiced_target | DOUBLE PRECISION | true | Sales target | Numeric target for the team. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `user_id` → `res_users.id` (Standard Odoo reference to the team lead).
    - `alias_id` → `mail_alias.id` (Standard Odoo reference for email integration).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `name` and `lead_properties_definition` columns may contain internal business logic or naming conventions; ensure access is restricted if necessary.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with Odoo's standard database storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = true` unless historical analysis of archived teams is required.
- **JSONB:** The `name` and `lead_properties_definition` columns require PostgreSQL JSONB operators (e.g., `->>`) to extract values.