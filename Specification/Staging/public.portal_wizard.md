# portal_wizard

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM.

## Functional process 
This table supports the configuration of customer-facing portal onboarding or welcome flows. It manages the content and administrative tracking of wizard-style interfaces used to guide users through initial setup or feature introductions within the portal.

## Description
One row represents a single instance of a portal configuration wizard, containing the welcome message displayed to users and the audit trail of its creation and modification. As a staging table, it serves as a raw, direct copy of the source system's configuration entity, intended for downstream transformation into a more structured format.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence `portal_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References a user table (likely `res_users`). |
| write_uid | INTEGER | true | ID of the user who last modified the record | References a user table (likely `res_users`). |
| welcome_message | TEXT | true | The content of the welcome message | May contain HTML or plain text. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess based on Odoo naming patterns).
    - `write_uid` → `res_users.id` (guess based on Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `welcome_message` field may contain raw text or markup; verify encoding if special characters appear corrupted.
- This table does not appear to implement soft deletes; records are likely hard-deleted in the source system.
- `create_uid` and `write_uid` are likely internal system IDs and may not be stable across different environments (e.g., dev vs. prod).