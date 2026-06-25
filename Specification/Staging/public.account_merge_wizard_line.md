# account_merge_wizard_line

## Source system
This table originates from an Odoo ERP system. The naming convention (`account_merge_wizard_line`, `create_uid`, `write_uid`, `display_type`) is characteristic of Odoo's ORM-generated tables, specifically those supporting transient wizard models used for data deduplication or record merging processes.

## Functional process 
This table supports the "Customer/Account Deduplication" business process. It acts as a temporary staging area for the wizard that identifies and merges duplicate account records, tracking which accounts are selected for merging and how they are grouped during the reconciliation workflow.

## Description
One row in this table represents a single line item within an account merge wizard session, identifying a specific account record being evaluated for a merge operation. As a staging table, it holds the transient state of the wizard's selection and grouping logic before the final merge is committed to the core account entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_merge_wizard_line_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard session | Links this line to the specific merge wizard instance. |
| sequence | INTEGER | true | Display order index | Determines the UI sort order in the wizard. |
| account_id | INTEGER | true | Foreign key to the account being processed | The target account record involved in the merge. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated this line entry. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this line. |
| grouping_key | VARCHAR | true | Deduplication grouping identifier | Used to cluster accounts that share similar attributes. |
| display_type | VARCHAR | false | UI rendering type | Defines how the line is rendered (e.g., 'line', 'section'). |
| is_selected | BOOLEAN | true | Selection flag | Indicates if the user has selected this account for merging. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `account_merge_wizard.id` (Guess: links to the parent wizard session).
    - `account_id` → `account_account.id` (Guess: links to the master account record).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Transient Data:** This table contains transient wizard data; records may be ephemeral and purged by the source system once the merge wizard session is closed.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not map to external identity systems without a join to the `res_users` table.
- **Soft Deletes:** There is no explicit soft-delete flag; however, the transient nature of the wizard suggests that rows are likely deleted rather than flagged.