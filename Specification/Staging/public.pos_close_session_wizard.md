# pos_close_session_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the table (`pos_close_session_wizard`), the use of `create_uid`/`write_uid` audit columns, and the sequence-based default value for the `id` column, which are characteristic patterns of the Odoo framework.

## Functional process 
This table supports the Point of Sale (POS) session management process, specifically the wizard used to close a POS session. It captures the state and user input required to reconcile cash balances at the end of a shift, as indicated by the `amount_to_balance` and `message` fields.

## Description
One row in this table represents a single instance of a POS session closure wizard execution. It serves as a staging entity, capturing the transient data and user-provided inputs during the session reconciliation process before the final closure is committed to the core accounting modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_close_session_wizard_id_seq`. |
| account_id | INTEGER | true | Foreign key to the accounting account | Likely references `account.account`. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| message | TEXT | true | User-provided closing message | Used for notes during reconciliation. |
| account_readonly | BOOLEAN | true | Read-only flag for the account | Controls UI behavior in the wizard. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| amount_to_balance | DOUBLE PRECISION | true | Discrepancy amount | The value needing reconciliation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Inferred from standard Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit trails (`create_uid`, `write_uid`) which are useful for tracking user activity during the closure process.
- The `amount_to_balance` column represents a floating-point value; ensure appropriate rounding is applied if used for financial reporting.
- This is a staging table; data may be transient and subject to cleanup or archival depending on the Odoo instance's retention policy.