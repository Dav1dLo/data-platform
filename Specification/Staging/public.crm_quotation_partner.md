# crm_quotation_partner

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention (`crm_quotation_partner`), the use of `create_uid` and `write_uid` for audit tracking, and the sequence-based default for the `id` column are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the sales pipeline and partner management process by linking specific CRM leads to associated partners (such as resellers, distributors, or agents) involved in the quotation lifecycle. It tracks the administrative history of these associations, including who created or modified the record and when.

## Description
One row in this table represents a single association between a CRM lead and a partner entity, capturing the specific action taken during the quotation process. As a staging table, it serves as a raw, landed copy of the source system's relational data, intended for further transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `crm_quotation_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead | Links to the CRM lead record. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the associated partner/contact. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| action | VARCHAR | false | Business action type | Describes the nature of the quotation-partner link. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Guess: Standard Odoo naming convention for lead associations).
    - `partner_id` → `res_partner.id` (Guess: Standard Odoo naming convention for partner entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in the source system's local time; verify the server timezone configuration before performing time-series analysis.
- **Data Integrity:** The `partner_id` is nullable, suggesting that some lead-action associations may exist without a linked partner record.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs; these will require a join to the system's user table to resolve to human-readable names.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag, but Odoo often uses an `active` boolean column for soft deletes; if missing, assume all records are currently active.