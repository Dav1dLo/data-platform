# account_journal_group

## Source system
This table originates from an Odoo ERP system. The naming convention (`account_journal_group`), the presence of `create_uid`/`write_uid` audit columns, and the use of `JSONB` for the `name` field (often used in Odoo for multi-language fields) are characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the financial accounting module, specifically the grouping of journals for reporting or organizational purposes. It allows users to categorize multiple journals under a single group entity, which is typically used to simplify the presentation of financial statements or ledger reports.

## Description
One row represents a single journal group definition within the accounting module. This is a raw landed staging table containing the configuration state of journal groups, including audit metadata and the localized name of the group.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_journal_group_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links the group to a specific organizational entity. |
| sequence | INTEGER | true | Sort order index | Determines the display order of the group in UI/reports. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| name | JSONB | false | Group name | Likely contains localized strings; requires parsing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** No direct PII, though `create_uid` and `write_uid` link to user identity tables.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Format:** The `name` column is `JSONB`; ensure your SQL dialect supports `->>` or `->` operators to extract values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to have an `active` boolean flag, which is common in Odoo; assume all rows are currently active unless otherwise specified by business logic.