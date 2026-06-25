# account_automatic_entry_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `account_automatic_entry_wizard` and the presence of columns like `create_uid`, `write_uid`, `company_id`, and `_seq` sequences are characteristic of Odoo's internal wizard models used to automate accounting journal entries.

## Functional process 
This table supports the automated accounting entry process, specifically the "Automatic Entry" wizard functionality. It stores the configuration and state for wizards designed to split or reallocate account balances (e.g., deferrals or accruals) based on a specified `percentage` or `total_amount` across a selected `destination_account_id`.

## Description
One row in this table represents a single execution or configuration instance of an automatic accounting entry wizard. It acts as a staging record that captures the parameters—such as the target account, date, and distribution logic—before the system generates the corresponding journal entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_automatic_entry_wizard_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity for the entry. |
| destination_account_id | INTEGER | true | Target account ID | The account to which the balance is being moved. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the wizard. |
| action | VARCHAR | false | Wizard action type | Defines the specific operation (e.g., 'change', 'split'). |
| account_type | VARCHAR | true | Account category | The classification of the account being processed. |
| date | DATE | false | Effective date | The accounting date for the automatic entry. |
| total_amount | NUMERIC | true | Transaction amount | The total value to be processed by the wizard. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| percentage | DOUBLE PRECISION | true | Allocation percentage | The ratio of the balance to be moved. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `destination_account_id` → `account_account.id` (Standard Odoo accounting module link).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This table represents a "wizard" state; records may be transient or intended for cleanup after the associated journal entries are posted.
- **Precision:** `total_amount` is a `NUMERIC` type, suitable for financial calculations, while `percentage` is a `DOUBLE PRECISION` float, which may be subject to minor floating-point rounding errors.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume records are permanent unless the application logic dictates otherwise.