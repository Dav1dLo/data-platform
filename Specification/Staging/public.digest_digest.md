# digest_digest

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`digest_digest`), the use of `create_uid`/`write_uid` audit columns, and the specific `JSONB` field for `name` which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the "Digest Email" reporting process, which aggregates business performance metrics (KPIs) and sends periodic summaries to users. It tracks the configuration of these digests, including which specific KPIs (e.g., CRM leads, sales totals, project tasks) are enabled for each company.

## Description
One row in this table represents a single configured digest report definition. It acts as a raw landing copy of the digest configuration settings, capturing the schedule, status, and the set of active KPIs enabled for the report.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Foreign key to the company | Links the digest to a specific business entity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the digest. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the digest. |
| periodicity | VARCHAR | false | Frequency of the digest | e.g., 'daily', 'weekly', 'monthly'. |
| state | VARCHAR | true | Current status | e.g., 'activated', 'deactivated'. |
| next_run_date | DATE | true | Scheduled execution date | The date the next digest is due to be sent. |
| name | JSONB | false | Digest name | Stored as JSONB to support multi-language labels. |
| kpi_res_users_connected | BOOLEAN | true | KPI: Users connected | Flag to include user connection stats. |
| kpi_mail_message_total | BOOLEAN | true | KPI: Total mail messages | Flag to include email volume stats. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Record modification timestamp | Inferred UTC. |
| kpi_account_total_revenue | BOOLEAN | true | KPI: Total revenue | Flag to include accounting revenue stats. |
| kpi_crm_lead_created | BOOLEAN | true | KPI: CRM leads created | Flag to include new lead stats. |
| kpi_crm_opportunities_won | BOOLEAN | true | KPI: CRM opportunities won | Flag to include won opportunity stats. |
| kpi_project_task_opened | BOOLEAN | true | KPI: Project tasks opened | Flag to include open task stats. |
| kpi_pos_total | BOOLEAN | true | KPI: POS total | Flag to include Point of Sale stats. |
| kpi_all_sale_total | BOOLEAN | true | KPI: Total sales | Flag to include overall sales stats. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; use `name->>'en_US'` or similar syntax to extract specific language values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains configuration flags (`kpi_*`); these are boolean toggles for the reporting engine and do not contain the actual metric values.
- There is no explicit soft-delete flag, but the `state` column may be used to filter active vs. inactive configurations.