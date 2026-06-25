# crm_activity_report

## Source system
The table likely originates from an Odoo ERP or CRM system. The naming convention of columns such as `subtype_id`, `mail_activity_type_id`, `partner_id`, and `stage_id` is highly characteristic of Odoo's relational data model, which frequently uses these specific identifiers to track CRM interactions and lead progression.

## Functional process 
This table supports the lead-to-opportunity conversion and sales activity tracking process. It aggregates various touchpoints, including email activity, lead creation, and stage transitions, allowing the business to monitor the lifecycle of a lead from initial contact through to closure or conversion.

## Description
One row in this table represents a single activity or status update associated with a CRM lead or opportunity. It serves as a raw landing copy of activity logs, capturing temporal milestones (creation, conversion, closure) and relational context (assigned user, team, and company) for analytical reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely auto-incrementing ID from source. |
| lead_create_date | TIMESTAMP | true | Timestamp of lead creation | Used to calculate lead age. |
| date_conversion | TIMESTAMP | true | Timestamp of lead-to-opportunity conversion | Null if lead has not converted. |
| date_deadline | DATE | true | Target completion date | Date-only format. |
| date_closed | TIMESTAMP | true | Timestamp of activity or lead closure | Indicates finalization of the record. |
| subtype_id | INTEGER | true | Activity subtype identifier | Categorizes the specific nature of the activity. |
| mail_activity_type_id | INTEGER | true | Email activity category ID | Links to specific email-related activity definitions. |
| author_id | INTEGER | true | ID of the user who created the activity | References the system user table. |
| date | TIMESTAMP | true | General activity timestamp | Primary timestamp for the activity record. |
| body | TEXT | true | Content of the activity | Contains descriptive notes or email body text. |
| lead_id | INTEGER | true | Foreign key to the lead | Links the activity to a specific lead. |
| user_id | INTEGER | true | Assigned user ID | The salesperson or agent responsible. |
| team_id | INTEGER | true | Sales team identifier | Groups activities by organizational unit. |
| country_id | INTEGER | true | ISO-3166 country identifier | Geographic context of the lead/activity. |
| company_id | INTEGER | true | Company/Organization identifier | Links to the parent entity. |
| stage_id | INTEGER | true | CRM pipeline stage identifier | Tracks progress through the sales funnel. |
| partner_id | INTEGER | true | Partner/Customer identifier | Links to the external contact or partner. |
| lead_type | VARCHAR | true | Classification of the lead | e.g., 'opportunity', 'lead'. |
| active | BOOLEAN | true | Soft-delete flag | True if the record is active, false if archived. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Likely links to the main lead entity).
    - `user_id` → `res_users.id` (Standard Odoo pattern for user assignment).
    - `team_id` → `crm_team.id` (Standard Odoo pattern for sales teams).
    - `stage_id` → `crm_stage.id` (Standard Odoo pattern for pipeline stages).
    - `partner_id` → `res_partner.id` (Standard Odoo pattern for contacts/companies).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII (names, phone numbers, email addresses) and should be handled according to data privacy policies.
- **Timezones:** Timestamps are assumed to be in UTC, but Odoo systems often store time in the server's local time; verify against system configuration.
- **Soft Deletes:** The `active` column should be used to filter out archived or deleted records in all queries.
- **Nullability:** Many columns are nullable; ensure queries handle missing values for `date_conversion` and `date_closed` when calculating durations.