# account_setup_bank_manual_config

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_partner_bank_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the financial configuration process, specifically the manual setup of bank accounts within the accounting module. It tracks the association between bank records and journal configurations, likely used during the onboarding or migration of bank accounts to ensure that journals are correctly mapped to financial institutions.

## Description
One row in this table represents a specific manual configuration entry for a bank account setup, linking a partner bank record to a journal name. As a staging table, it serves as a raw landed copy of the Odoo `account.setup.bank.manual.config` model, capturing the state of manual bank journal configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_setup_bank_manual_config_id_seq`. |
| res_partner_bank_id | INTEGER | false | Foreign key to the bank account | References the `res_partner_bank` table. |
| num_journals_without_account | INTEGER | true | Count of journals missing an account | Indicates configuration gaps during setup. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| new_journal_name | VARCHAR | false | Name assigned to the new journal | The display name for the bank journal. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `res_partner_bank_id` → `res_partner_bank.id` (Evidence: standard Odoo naming convention for partner bank relations).
    - `create_uid` → `res_users.id` (Evidence: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Evidence: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in the database's local time, typically configured to UTC in Odoo environments.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not resolve to human-readable names without joining to the `res_users` table.
- **Data Integrity:** As a staging table, this may contain transient data or incomplete configurations that were subsequently corrected in the source system.
- **Sensitivity:** Contains no direct PII, but links to financial journal configurations which may be considered sensitive in some compliance contexts.