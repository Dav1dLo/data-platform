# pos_session

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`pos_session`, `config_id`, `move_id`, `create_uid`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the Point of Sale (POS) management process, specifically tracking individual cashier sessions from opening to closing. It captures financial reconciliation data, such as starting and ending cash balances, and links sessions to specific users, configurations, and accounting entries.

## Description
One row represents a single POS session, defined by the period between a user logging into a POS terminal and closing the session. This is a raw landing table in the staging layer, providing a direct copy of session-level metadata, financial totals, and audit timestamps from the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_session_id_seq` |
| config_id | INTEGER | false | Foreign key to POS configuration | Defines the terminal/shop settings |
| user_id | INTEGER | false | Foreign key to the system user | The user who opened the session |
| sequence_number | INTEGER | true | Session sequence identifier | Used for internal ordering |
| login_number | INTEGER | true | Incremental login count | Tracks session frequency |
| cash_journal_id | INTEGER | true | Foreign key to cash journal | Links to accounting journal |
| move_id | INTEGER | true | Foreign key to accounting move | Links to the final journal entry |
| create_uid | INTEGER | true | Creator user ID | Audit field |
| write_uid | INTEGER | true | Last modifier user ID | Audit field |
| access_token | VARCHAR | true | Security token | Used for external session access |
| name | VARCHAR | false | Session display name | Usually a unique code like 'POS/2023/001' |
| state | VARCHAR | false | Session status | e.g., 'opening', 'opened', 'closed' |
| opening_notes | TEXT | true | Notes at session start | Free-text field |
| closing_notes | TEXT | true | Notes at session end | Free-text field |
| cash_register_balance_end_real | NUMERIC | true | Actual closing cash balance | Monetary value |
| cash_register_balance_start | NUMERIC | true | Starting cash balance | Monetary value |
| cash_real_transaction | NUMERIC | true | Real cash transactions | Net cash movement |
| rescue | BOOLEAN | true | Rescue session flag | Indicates a recovered session |
| update_stock_at_closing | BOOLEAN | true | Stock update trigger | If true, updates inventory on close |
| start_at | TIMESTAMP | true | Session start time | UTC assumed |
| stop_at | TIMESTAMP | true | Session end time | UTC assumed |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit field |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit field |
| employee_id | INTEGER | true | Foreign key to employee | The employee operating the POS |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `config_id` → `pos_config.id` (Standard Odoo POS configuration link)
    - `user_id` → `res_users.id` (Standard Odoo user link)
    - `cash_journal_id` → `account_journal.id` (Links to accounting journal)
    - `move_id` → `account_move.id` (Links to the accounting ledger entry)
    - `employee_id` → `hr_employee.id` (Links to HR employee record)
- **Natural keys (inferred):** 
    - `name` (The session identifier string is typically unique within the source system)

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and `employee_id` which may be considered PII depending on your organization's data governance policy.
- **Timestamps:** All timestamps (`start_at`, `stop_at`, `create_date`, `write_date`) are assumed to be in UTC as per standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if they disappear from the source.
- **Financial Precision:** `NUMERIC` fields represent currency; ensure proper rounding is applied if performing aggregations across multiple sessions.