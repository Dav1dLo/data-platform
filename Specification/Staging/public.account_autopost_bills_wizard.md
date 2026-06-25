# account_autopost_bills_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `wizard` combined with columns like `create_uid`, `write_uid`, and the `_id` suffix for foreign keys is characteristic of Odoo's transient model architecture used for UI-driven batch processing.

## Functional process 
This table supports the automated billing or invoice processing workflow. It tracks the state of a "wizard" or temporary interface used to batch-process bills, specifically monitoring how many bills remain unmodified during an autoposting routine, likely linked to a specific business partner.

## Description
One row represents a single execution or session of the autoposting bills wizard. It serves as a staging record to track the progress and metadata of a batch operation, capturing who initiated the process and when it was last updated.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_autopost_bills_wizard_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the business entity associated with the bills. |
| nb_unmodified_bills | INTEGER | true | Count of bills not modified | Represents the number of bills processed but left unchanged. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo naming convention for partner associations).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This table represents a "wizard" state; records may be transient or ephemeral depending on the Odoo cleanup cron jobs.
- **Nullability:** Most fields are nullable, suggesting that wizard sessions may be partially initialized or abandoned before completion.