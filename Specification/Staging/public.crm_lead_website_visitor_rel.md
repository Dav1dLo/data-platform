# crm_lead_website_visitor_rel

## Source system
The table likely originates from a CRM system (such as Salesforce or HubSpot) integrated with a web analytics or marketing automation platform. The naming convention suggests a junction table used to bridge lead records in the CRM with visitor tracking IDs from a web-tracking pixel or session management tool.

## Functional process 
This table supports the lead-to-customer attribution process. It maps anonymous or identified website visitor sessions to specific CRM lead records, enabling marketing teams to track the digital journey and touchpoints that preceded a lead's creation or conversion.

## Description
One row in this table represents a single association between a CRM lead and a website visitor ID. As a staging table, it serves as a raw, normalized link entity intended to facilitate join operations between lead data and web activity logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_id | INTEGER | false | Unique identifier for the lead in the CRM. | Foreign key to the CRM leads table. |
| website_visitor_id | INTEGER | false | Unique identifier for the visitor session or user profile. | Likely links to a web analytics or tracking table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`crm_lead_id`, `website_visitor_id`).
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_leads.id` (Inferred based on standard naming conventions for CRM entities).
    - `website_visitor_id` → `web_visitors.id` (Inferred based on the context of visitor tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction entity; expect many-to-many relationships if a lead visits from multiple devices or if a visitor ID is shared across sessions.
- There is no audit timestamp (e.g., `created_at`) provided in this schema; query writers should be aware that temporal filtering is not possible directly on this table.
- The table contains no PII, but it links behavioral data to CRM records, which may be subject to privacy compliance (GDPR/CCPA) depending on the nature of the `website_visitor_id`.