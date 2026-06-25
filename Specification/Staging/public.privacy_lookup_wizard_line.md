# privacy_lookup_wizard_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_id`, `res_model`, `create_uid`, `write_uid`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the data privacy and GDPR compliance module within the ERP. It tracks individual records (identified by `res_id` and `res_model`) that are being processed or audited by a "privacy lookup wizard," likely used to identify, anonymize, or delete personal data across various system entities.

## Description
One row represents a single line item within a privacy lookup wizard session, detailing a specific record that has been flagged for privacy review. This is a raw landing table in the staging layer, capturing the state of privacy-related record processing at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `privacy_lookup_wizard_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the parent wizard session | Links to the specific privacy lookup task. |
| res_id | INTEGER | false | ID of the target record | The ID of the record in the source model. |
| res_model_id | INTEGER | true | ID of the target model | Reference to the system model (e.g., res.partner). |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated this line. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this line. |
| res_name | VARCHAR | true | Display name of the target record | Human-readable identifier for the record. |
| res_model | VARCHAR | true | Technical name of the model | e.g., 'res.partner' or 'sale.order'. |
| execution_details | VARCHAR | true | Processing logs or status | Details regarding the privacy action taken. |
| has_active | BOOLEAN | true | Presence of active flag | Indicates if the source record has an active field. |
| is_active | BOOLEAN | true | Current active status | The active state of the target record. |
| is_unlinked | BOOLEAN | true | Unlink status | Indicates if the record has been unlinked/deleted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `privacy_lookup_wizard.id` (Likely parent container for the lookup process).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable; the combination of `wizard_id`, `res_model`, and `res_id` likely acts as the business key for a specific lookup instance.

## Caveats for downstream consumers

- **Sensitive Data:** This table tracks records subject to privacy/GDPR review; `res_name` may contain PII.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `is_unlinked` and `is_active` flags should be checked to determine if the underlying source record still exists or is considered "active" in the source system.
- **Data Integrity:** As a staging table, this may contain multiple versions of a record if the wizard is re-run; filter by the latest `write_date` if necessary.