# account_bank_statement_line

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `move_id`, `journal_id`, `partner_id`, `create_uid`) and the presence of `JSONB` fields for transaction details are characteristic of the Odoo accounting and financial modules.

## Functional process 
This table supports the bank reconciliation and cash management process. It captures individual line items from imported bank statements or point-of-sale sessions, linking them to accounting entries (`move_id`), business partners (`partner_id`), and specific financial journals (`journal_id`) to facilitate the matching of bank transactions against internal ledger records.

## Description
One row in this table represents a single transaction line extracted from a bank statement or a point-of-sale session. It serves as a raw landed staging entity, providing the granular detail required to reconcile external bank activity with internal accounting moves.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| move_id | INTEGER | false | Accounting move reference | Links to the corresponding journal entry. |
| journal_id | INTEGER | false | Journal identifier | The financial journal this line belongs to. |
| company_id | INTEGER | false | Company identifier | Multi-company context identifier. |
| statement_id | INTEGER | true | Bank statement reference | Links to the parent bank statement header. |
| sequence | INTEGER | true | Display sequence | Ordering index for UI/reporting. |
| partner_id | INTEGER | true | Partner identifier | The customer or vendor associated with the transaction. |
| currency_id | INTEGER | true | Currency identifier | The transaction currency. |
| foreign_currency_id | INTEGER | true | Foreign currency identifier | Used if the transaction involves a secondary currency. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| account_number | VARCHAR | true | Bank account number | The source bank account identifier. |
| partner_name | VARCHAR | true | Partner name | Denormalized name of the counterparty. |
| transaction_type | VARCHAR | true | Transaction type | Category or code of the bank transaction. |
| payment_ref | VARCHAR | true | Payment reference | The memo or reference string from the bank. |
| internal_index | VARCHAR | true | Internal index | System-specific tracking code. |
| transaction_details | JSONB | true | Raw transaction metadata | Structured data containing specific bank-provided details. |
| amount | NUMERIC | true | Transaction amount | The amount in the company's base currency. |
| amount_currency | NUMERIC | true | Amount in foreign currency | The amount in the transaction's native currency. |
| is_reconciled | BOOLEAN | true | Reconciliation status | Flag indicating if the line is matched to an entry. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| amount_residual | DOUBLE PRECISION | true | Residual amount | Remaining balance to be reconciled. |
| pos_session_id | INTEGER | true | POS session identifier | Links to a Point of Sale session if applicable. |
| employee_id | INTEGER | true | Employee identifier | Links to an employee if the transaction is payroll/expense related. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Likely links to the main accounting entry table).
    - `journal_id` → `account_journal.id` (Links to the journal definition).
    - `partner_id` → `res_partner.id` (Links to the business partner master data).
    - `statement_id` → `account_bank_statement.id` (Links to the parent bank statement).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `partner_name` and `account_number` columns contain PII/financial data and should be masked in non-production environments.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are stored in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically managed via the Odoo ORM lifecycle.
- **JSONB Usage:** The `transaction_details` column contains semi-structured data; ensure your downstream processing handles potential schema variations within this JSON object.