# account_move_reversal

## Source system
This table originates from an Odoo ERP system. The naming convention (`account_move_reversal`), the presence of `create_uid`/`write_uid` audit columns, and the use of `nextval` sequences are characteristic of the Odoo ORM (Object-Relational Mapping) layer.

## Functional process 
This table supports the financial accounting module, specifically the "Reversal of Journal Entries" process. It tracks the metadata associated with reversing accounting moves (e.g., correcting erroneous journal entries), linking the reversal action to specific journals and companies.

## Description
One row in this table represents a single reversal request or event for an accounting journal entry. It acts as a raw landing record in the staging layer, capturing the reason for the reversal, the effective date, and the audit trail of who created or modified the reversal record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_move_reversal_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Identifies which journal the reversal belongs to. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity associated with the reversal. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| reason | VARCHAR | true | Textual explanation for the reversal | User-provided justification for the entry reversal. |
| date | DATE | true | Effective date of the reversal | The accounting date applied to the reversal. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Inferred from Odoo standard naming conventions).
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming conventions).
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming conventions).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Data Integrity:** This is a staging table; it may contain raw, unvalidated input from the source system.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by business logic.
- **Sensitivity:** `create_uid` and `write_uid` link to user records, which may contain PII; ensure appropriate access controls are applied when joining to user identity tables.