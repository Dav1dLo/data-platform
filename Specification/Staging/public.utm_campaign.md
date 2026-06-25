# utm_campaign

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences and `JSONB` for localized titles, is highly characteristic of the Odoo framework's internal data architecture.

## Functional process 
This table supports the marketing and lead-tracking pipeline by managing UTM campaign definitions. It tracks the configuration of marketing campaigns, including their status, automation settings, and association with specific company entities, likely used to attribute incoming traffic or leads to specific marketing initiatives.

## Description
One row in this table represents a single marketing campaign definition within the system. It serves as a raw landed copy of the campaign configuration, capturing metadata such as the campaign name, its active status, and audit timestamps for creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `utm_campaign_id_seq`. |
| user_id | INTEGER | false | Owner user ID | Likely references a user in the system. |
| stage_id | INTEGER | false | Campaign stage ID | References the current status/stage of the campaign. |
| color | INTEGER | true | UI color index | Used for visual representation in the application. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Campaign name | The internal identifier or name of the campaign. |
| title | JSONB | false | Localized title | Stores the campaign title, potentially in multiple languages. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the campaign is currently active. |
| is_auto_campaign | BOOLEAN | true | Automation flag | Indicates if the campaign is managed automatically. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp when the record was last updated. |
| company_id | INTEGER | true | Company ID | References the company associated with the campaign. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for audit fields).
    - `company_id` → `res_company.id` (Guess: Standard Odoo pattern for multi-company isolation).
- **Natural keys (inferred):**
    - `name` (Assuming campaign names are unique within the system).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL/Odoo practices.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = true` to retrieve only currently valid campaigns.
- **JSONB:** The `title` column contains structured data; use PostgreSQL JSONB operators (e.g., `->>`) to extract specific values.
- **Audit Fields:** `create_uid` and `write_uid` are system-generated and should be treated as internal references to the user table.