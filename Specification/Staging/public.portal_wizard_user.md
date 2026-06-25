# portal_wizard_user

## Source system
This table likely originates from an Odoo ERP instance. The naming convention (`portal_wizard_user`), the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of a sequence-based default for the `id` column are characteristic patterns found in Odoo's PostgreSQL database schema.

## Functional process 
This table supports the portal access management process, specifically tracking which partners (contacts/customers) are associated with specific portal wizards. It acts as a join or configuration table to manage user permissions or invitations within the portal module.

## Description
One row in this table represents a single association between a portal wizard instance and a specific partner. It serves as a raw landed copy of the staging data, capturing the state of user-wizard assignments at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `portal_wizard_user_id_seq` for auto-increment. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard | Links to the specific portal wizard configuration. |
| partner_id | INTEGER | false | Foreign key to the partner | Identifies the contact/user associated with the wizard. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| email | VARCHAR | true | Contact email address | The email address associated with the portal user. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `portal_wizard.id` (Guess: links to the wizard definition table).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo table for contacts/partners).
    - `create_uid` → `res_users.id` (Guess: standard Odoo table for system users).
    - `write_uid` → `res_users.id` (Guess: standard Odoo table for system users).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `email` column contains PII and should be handled according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs; these may not resolve to human-readable names without joining to the `res_users` table.
- **Data State:** This is a staging table; it represents a raw snapshot and may contain duplicates or incomplete records depending on the frequency and logic of the upstream extraction process.