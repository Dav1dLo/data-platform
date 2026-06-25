# project_share_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_id`, `res_model`, `create_uid`, `write_uid`) and the use of sequence-based primary keys are characteristic of the Odoo framework's ORM layer, which manages record sharing and wizard-based workflows.

## Functional process 
This table supports the "Record Sharing" business process, specifically tracking the configuration of wizards used to share specific records (identified by `res_id` and `res_model`) with external or internal users. It logs the metadata associated with the creation and modification of these sharing sessions, including any notes attached to the share request.

## Description
One row in this table represents a single instance of a "share wizard" session, which captures the intent to share a specific record from a model with other parties. As a staging table, it serves as a raw, landed copy of the Odoo `project.share.wizard` model, preserving the state of share requests at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.project_share_wizard_id_seq`. |
| res_id | INTEGER | false | Resource ID | The ID of the record being shared. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the share. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the share. |
| res_model | VARCHAR | false | Resource model name | The technical name of the model (e.g., 'project.project'). |
| note | TEXT | true | Share note | Optional message or context attached to the share. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `note` column may contain free-text information that could include sensitive data or PII.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows represent the current state of the wizard records as captured during ingestion.
- **Model Context:** The `res_id` is only meaningful when joined with the corresponding `res_model` in the source system.