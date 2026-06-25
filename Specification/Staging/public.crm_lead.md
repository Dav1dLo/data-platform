# crm_lead

## Source system
This table originates from Odoo CRM. The naming conventions (e.g., `create_uid`, `write_uid`, `partner_id`, `stage_id`), the use of `JSONB` for properties, and the specific pattern of `_id` suffixes for relational lookups are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the Lead-to-Opportunity pipeline. It tracks the lifecycle of potential sales prospects from initial acquisition (source/medium/campaign tracking) through qualification, stage progression, and eventual conversion or loss, including financial forecasting via revenue fields.

## Description
One row represents a single lead or opportunity within the CRM system. It captures contact details, qualification status, sales team assignment, and financial projections. As a staging table, it serves as a raw, landed copy of the Odoo `crm.lead` model, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Foreign key to campaign. |
| source_id | INTEGER | true | Marketing source ID | Foreign key to source. |
| medium_id | INTEGER | true | Marketing medium ID | Foreign key to medium. |
| message_bounce | INTEGER | true | Bounce count | Number of failed email deliveries. |
| user_id | INTEGER | true | Assigned salesperson ID | Foreign key to res.users. |
| team_id | INTEGER | true | Sales team ID | Foreign key to crm.team. |
| company_id | INTEGER | true | Company ID | Foreign key to res.company. |
| stage_id | INTEGER | true | Pipeline stage ID | Foreign key to crm.stage. |
| color | INTEGER | true | UI color index | Used for Kanban board styling. |
| recurring_plan | INTEGER | true | Recurring plan ID | Foreign key to subscription plan. |
| partner_id | INTEGER | true | Customer/Partner ID | Foreign key to res.partner. |
| title | INTEGER | true | Contact title ID | Foreign key to res.partner.title. |
| lang_id | INTEGER | true | Language ID | Foreign key to res.lang. |
| state_id | INTEGER | true | State/Province ID | Foreign key to res.country.state. |
| country_id | INTEGER | true | Country ID | Foreign key to res.country. |
| lost_reason_id | INTEGER | true | Lost reason ID | Foreign key to crm.lost.reason. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res.users. |
| phone_sanitized | VARCHAR | true | E.164 formatted phone | Normalized phone number. |
| email_normalized | VARCHAR | true | Normalized email | Lowercase/cleaned email address. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| name | VARCHAR | false | Lead/Opportunity name | Subject or title of the lead. |
| referred | VARCHAR | true | Referral source | Free-text referral info. |
| type | VARCHAR | false | Record type | 'lead' or 'opportunity'. |
| priority | VARCHAR | true | Priority level | Usually '0', '1', '2', '3'. |
| contact_name | VARCHAR | true | Primary contact name | Name of the person. |
| partner_name | VARCHAR | true | Company/Partner name | Name of the organization. |
| function | VARCHAR | true | Job title | Role of the contact. |
| email_from | VARCHAR | true | Sender email | Original email address. |
| email_domain_criterion | VARCHAR | true | Domain filter | Used for deduplication. |
| phone | VARCHAR | true | Raw phone number | As entered by user. |
| mobile | VARCHAR | true | Raw mobile number | As entered by user. |
| phone_state | VARCHAR | true | Phone validation status | e.g., 'correct', 'incorrect'. |
| email_state | VARCHAR | true | Email validation status | e.g., 'correct', 'incorrect'. |
| website | VARCHAR | true | Website URL | Company website. |
| street | VARCHAR | true | Address line 1 | |
| street2 | VARCHAR | true | Address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| date_deadline | DATE | true | Expected closing date | |
| lead_properties | JSONB | true | Custom attributes | Flexible storage for extra fields. |
| description | TEXT | true | Internal notes | |
| expected_revenue | NUMERIC | true | Expected revenue | |
| prorated_revenue | NUMERIC | true | Prorated revenue | |
| recurring_revenue | NUMERIC | true | Recurring revenue | |
| recurring_revenue_monthly | NUMERIC | true | Monthly recurring revenue | |
| recurring_revenue_monthly_prorated | NUMERIC | true | Monthly prorated MRR | |
| recurring_revenue_prorated | NUMERIC | true | Prorated recurring revenue | |
| active | BOOLEAN | true | Soft-delete flag | False indicates archived. |
| date_closed | TIMESTAMP | true | Closing timestamp | |
| date_automation_last | TIMESTAMP | true | Last automation run | |
| date_open | TIMESTAMP | true | Open timestamp | |
| date_last_stage_update | TIMESTAMP | true | Last stage change | |
| date_conversion | TIMESTAMP | true | Conversion timestamp | |
| create_date | TIMESTAMP | true | Record creation date | |
| write_date | TIMESTAMP | true | Record modification date | |
| day_open | DOUBLE PRECISION | true | Days to open | |
| day_close | DOUBLE PRECISION | true | Days to close | |
| probability | DOUBLE PRECISION | true | Success probability | Percentage (0-100). |
| automated_probability | DOUBLE PRECISION | true | System-calculated prob | |
| reveal_id | VARCHAR | true | Lead enrichment ID | External service identifier. |
| iap_enrich_done | BOOLEAN | true | Enrichment status | Flag for IAP service. |
| lead_mining_request_id | INTEGER | true | Lead mining request ID | Foreign key to lead.mining.request. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo user assignment)
    - `stage_id` → `crm_stage.id` (Standard Odoo pipeline stage)
    - `partner_id` → `res_partner.id` (Standard Odoo customer link)
- **Natural keys (inferred):** None. The table relies on the surrogate `id` for uniqueness.

## Caveats for downstream consumers

- **Sensitive Data:** Contains PII including `email_from`, `phone`, `mobile`, and address fields. Masking is recommended for non-authorized users.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should filter by `WHERE active = TRUE` unless performing historical analysis.
- **Data Types:** Financial fields (`expected_revenue`, etc.) are `NUMERIC`, ensuring precision for currency calculations.
- **JSONB:** The `lead_properties` column contains unstructured data; use PostgreSQL `->>` or `->` operators to extract specific keys.