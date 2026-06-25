# crm_iap_lead_mining_request

## Source system
This table originates from an Odoo-based CRM system, as evidenced by the naming conventions `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo/OpenERP architectures. The `crm_iap_lead_mining_request` naming pattern suggests it is part of the In-App Purchasing (IAP) module used for automated lead generation or enrichment services.

## Functional process 
This table supports the automated lead generation and enrichment pipeline. It tracks requests sent to external IAP services to mine or filter potential business leads based on specific criteria such as company size, contact roles, and seniority levels.

## Description
One row represents a single lead mining or enrichment request submitted to the IAP service. It captures the parameters of the search (e.g., company size, role, seniority) and the current processing state of the request. This is a raw staging table containing the initial request configuration and metadata before or during the processing lifecycle.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_mining_request_id_seq`. |
| lead_number | INTEGER | false | Business-defined lead count or identifier | Likely represents the number of leads requested. |
| team_id | INTEGER | true | Foreign key to CRM team | Links the request to a specific sales team. |
| user_id | INTEGER | true | Foreign key to system user | The user who initiated the request. |
| company_size_min | INTEGER | true | Minimum company size filter | Lower bound for lead filtering. |
| company_size_max | INTEGER | true | Maximum company size filter | Upper bound for lead filtering. |
| contact_number | INTEGER | true | Number of contacts requested | Target volume of contacts to mine. |
| preferred_role_id | INTEGER | true | Foreign key to role definition | Filter for specific job roles. |
| seniority_id | INTEGER | true | Foreign key to seniority level | Filter for professional seniority. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record updates. |
| name | VARCHAR | false | Request name or description | Descriptive label for the mining request. |
| state | VARCHAR | false | Lifecycle status | Current status (e.g., 'draft', 'done', 'error'). |
| search_type | VARCHAR | false | Type of search performed | Defines the logic used for lead mining. |
| error_type | VARCHAR | true | Error classification | Populated if the request failed. |
| lead_type | VARCHAR | false | Category of lead | Defines the nature of the leads sought. |
| contact_filter_type | VARCHAR | true | Contact filtering logic | Specific criteria used for contact selection. |
| filter_on_size | BOOLEAN | true | Size filter toggle | Flag indicating if company size filtering is active. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo CRM team association)
    - `user_id` → `res_users.id` (Guess: standard Odoo user association)
    - `preferred_role_id` → `crm_iap_lead_role.id` (Guess: domain-specific lookup)
    - `seniority_id` → `crm_iap_lead_seniority.id` (Guess: domain-specific lookup)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all rows are current unless the `state` column indicates otherwise.
- **Data Integrity:** As a staging table, some fields (like `error_type`) will be null for successful requests.
- **Sensitive Data:** While this table contains business metadata, ensure that any downstream reporting masks `user_id` if it maps to PII in the `res_users` table.