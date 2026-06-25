# crm_stage

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic column naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized or multi-language fields like `name`.

## Functional process 
This table supports the Sales Pipeline management process, specifically defining the stages (e.g., "New", "Qualified", "Proposition", "Won") within a CRM sales funnel. It tracks the progression of opportunities through these stages, including metadata on whether a stage represents a successful outcome (`is_won`) or if it is hidden in the UI (`fold`).

## Description
One row in this table represents a single stage definition within a CRM sales pipeline. It serves as a raw landed copy of the Odoo `crm.stage` model, capturing the configuration and state of pipeline stages at the grain of one row per stage ID.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `crm_stage_id_seq` sequence. |
| sequence | INTEGER | true | Display order index | Determines the order of stages in the UI. |
| team_id | INTEGER | true | Sales team identifier | Foreign key to the associated sales team. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this stage. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this stage. |
| name | JSONB | false | Stage name | Often contains localized strings (e.g., `{"en_US": "Won"}`). |
| requirements | TEXT | true | Stage requirements | Description of criteria needed to enter this stage. |
| is_won | BOOLEAN | true | Success flag | Indicates if this stage represents a won opportunity. |
| fold | BOOLEAN | true | UI visibility flag | If true, the stage is collapsed in the pipeline view. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo pattern for linking stages to specific sales teams).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail for record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** Assumed to be in UTC as per standard Odoo/PostgreSQL configurations.
- **Data Type:** The `name` column is `JSONB`; ensure you use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume it contains the current state of records as landed from the source.