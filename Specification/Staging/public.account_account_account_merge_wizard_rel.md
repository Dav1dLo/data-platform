# account_account_account_merge_wizard_rel

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework that utilizes an ORM (Object-Relational Mapper). The naming convention `_rel` combined with the double-entity prefix `account_account_account_merge_wizard` is characteristic of a many-to-many join table generated automatically by Odoo to link account records to a specific merge wizard session.

## Functional process 
This table supports the data cleansing and maintenance process of merging duplicate financial accounts. It tracks the relationship between a specific "merge wizard" instance (the process session) and the individual account records selected to be merged or consolidated within that session.

## Description
One row represents a single association between a specific account merge wizard session and an account record. It serves as a raw landing link table in the staging layer, facilitating the many-to-many relationship required to group multiple accounts for a single merge operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_merge_wizard_id | INTEGER | false | Foreign key to the merge wizard session | Links to the parent wizard process. |
| account_account_id | INTEGER | false | Foreign key to the account record | Represents the specific account involved in the merge. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`account_merge_wizard_id`, `account_account_id`).
- **Foreign keys (inferred):** 
    - `account_merge_wizard_id` → `account_merge_wizard.id` (Guess: links to the wizard configuration).
    - `account_account_id` → `account_account.id` (Guess: links to the master account table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a join table; it contains no business data other than the relationship between two entities.
- There are no timestamps or audit columns present, so it is impossible to determine the age of these relationships or the sequence of merge operations from this table alone.
- As a staging table, it should be treated as a transient link; ensure joins to parent tables handle potential orphaned records if the source system performs hard deletes on the wizard sessions.