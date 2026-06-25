# account_payment

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `move_id`, `journal_id`, `partner_id`, `create_uid`), the specific sequence pattern for the primary key, and the presence of POS-related fields (`pos_session_id`, `pos_order_id`) are characteristic of the Odoo accounting and point-of-sale modules.

## Functional process 
This table supports the "Order-to-Cash" and "Procure-to-Pay" financial processes. It tracks incoming and outgoing payments, linking them to specific accounting journals, business partners, and underlying ledger entries (`move_id`). It handles both standard accounting payments and point-of-sale transactions.

## Description
One row in this table represents a single payment record, capturing the financial transaction details, status, and associated accounting entities. This is a raw landing table in the staging layer, containing a direct, un-transformed copy of the Odoo `account.payment` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_payment_id_seq` |
| message_main_attachment_id | INTEGER | true | Link to main attachment | Often used for payment receipts |
| move_id | INTEGER | true | Link to accounting journal entry | The ledger entry created by this payment |
| journal_id | INTEGER | false | Link to accounting journal | The bank or cash journal used |
| company_id | INTEGER | false | Link to company | Multi-company context |
| partner_bank_id | INTEGER | true | Link to partner bank account | Bank account used for the transaction |
| paired_internal_transfer_payment_id | INTEGER | true | Link to internal transfer | Used for transfers between internal accounts |
| payment_method_line_id | INTEGER | true | Payment method line ID | Configuration for payment methods |
| payment_method_id | INTEGER | true | Payment method ID | Legacy or simplified payment method |
| currency_id | INTEGER | true | Currency ID | The currency of the payment |
| partner_id | INTEGER | true | Partner ID | The customer or vendor involved |
| outstanding_account_id | INTEGER | true | Outstanding account ID | Interim account for reconciliation |
| destination_account_id | INTEGER | true | Destination account ID | The final ledger account |
| create_uid | INTEGER | true | Creator user ID | User who created the record |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the record |
| name | VARCHAR | true | Payment reference name | Usually a sequence number (e.g., PAY/2023/001) |
| state | VARCHAR | false | Payment status | e.g., 'draft', 'posted', 'sent', 'reconciled' |
| payment_type | VARCHAR | false | Payment type | 'inbound', 'outbound', or 'transfer' |
| partner_type | VARCHAR | false | Partner type | 'customer' or 'vendor' |
| memo | VARCHAR | true | Payment memo | User-provided description |
| payment_reference | VARCHAR | true | Payment reference | External reference or bank statement ref |
| date | DATE | false | Transaction date | The accounting date of the payment |
| amount | NUMERIC | true | Payment amount | Amount in the payment currency |
| amount_company_currency_signed | NUMERIC | true | Signed amount in company currency | Used for consolidated reporting |
| is_reconciled | BOOLEAN | true | Reconciled flag | Indicates if payment is fully reconciled |
| is_matched | BOOLEAN | true | Matched flag | Indicates if matched with a statement line |
| is_sent | BOOLEAN | true | Sent flag | Indicates if payment has been sent to bank |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation |
| write_date | TIMESTAMP | true | Modification timestamp | UTC timestamp of last update |
| payment_transaction_id | INTEGER | true | Online transaction ID | Link to external payment gateway record |
| payment_token_id | INTEGER | true | Payment token ID | Link to saved payment method token |
| source_payment_id | INTEGER | true | Source payment ID | Reference to original payment if reversed |
| pos_payment_method_id | INTEGER | true | POS payment method ID | Link to POS specific payment method |
| force_outstanding_account_id | INTEGER | true | Forced outstanding account | Override for reconciliation account |
| pos_session_id | INTEGER | true | POS session ID | Link to the POS session |
| pos_order_id | INTEGER | true | POS order ID | Link to the specific POS order |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Guessed: standard Odoo relation)
    - `partner_id` → `res_partner.id` (Guessed: standard Odoo relation)
    - `move_id` → `account_move.id` (Guessed: standard Odoo relation)
- **Natural keys (inferred):** 
    - `name` (The payment sequence number is typically unique per company/fiscal year)

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and `partner_bank_id`, which may be considered PII depending on your organization's data governance policy.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually deleted or archived. However, this table is a staging copy, so it reflects the state at the time of the last ingestion.
- **Data Integrity:** The `amount` field is in the transaction currency, while `amount_company_currency_signed` is normalized to the company's base currency. Use the latter for cross-currency financial reporting.