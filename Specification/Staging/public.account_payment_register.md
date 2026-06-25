# account_payment_register

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `_id` suffixes, `create_uid`, `write_date`) and the specific structure of payment registration wizards are characteristic of the Odoo framework's accounting module.

## Functional process 
This table supports the "Order-to-Cash" or "Procure-to-Pay" business processes by acting as a transient staging area for the payment registration wizard. It captures the parameters required to generate payment records, including currency conversion, partner identification, and payment method selection, before these are committed to the permanent ledger.

## Description
One row in this table represents a single instance of a payment registration wizard session. It records the configuration and financial details provided by a user to initiate a payment or receipt. As a staging table, it serves as a raw landed copy of the wizard's state, used to facilitate the creation of accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| currency_id | INTEGER | true | Target currency identifier | Foreign key to currency table. |
| journal_id | INTEGER | true | Accounting journal identifier | Foreign key to journal table. |
| partner_bank_id | INTEGER | true | Partner bank account identifier | Foreign key to res.partner.bank. |
| custom_user_currency_id | INTEGER | true | User-defined currency override | Used for manual currency adjustments. |
| source_currency_id | INTEGER | true | Original transaction currency | Used for cross-currency payments. |
| company_id | INTEGER | true | Owning company identifier | Multi-company context. |
| partner_id | INTEGER | true | Partner (customer/vendor) identifier | Foreign key to res.partner. |
| payment_method_line_id | INTEGER | true | Payment method configuration | Defines how the payment is processed. |
| writeoff_account_id | INTEGER | true | Account for payment differences | Used if payment amount != invoice amount. |
| create_uid | INTEGER | true | Creator user identifier | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user identifier | Foreign key to res.users. |
| communication | VARCHAR | true | Payment reference/memo | Free-text field for bank statements. |
| installments_mode | VARCHAR | true | Installment configuration | Defines split payment logic. |
| payment_type | VARCHAR | true | Payment direction | e.g., 'inbound', 'outbound'. |
| partner_type | VARCHAR | true | Partner category | e.g., 'customer', 'supplier'. |
| payment_difference_handling | VARCHAR | true | Strategy for partial payments | e.g., 'open', 'reconcile'. |
| writeoff_label | VARCHAR | true | Label for write-off entry | Description for accounting adjustment. |
| payment_date | DATE | false | Effective date of payment | |
| amount | NUMERIC | true | Payment amount | In the target currency. |
| custom_user_amount | NUMERIC | true | Manual amount override | |
| source_amount | NUMERIC | true | Original amount | |
| source_amount_currency | NUMERIC | true | Original amount in source currency | |
| group_payment | BOOLEAN | true | Flag for batch payment | |
| can_edit_wizard | BOOLEAN | true | UI permission flag | |
| can_group_payments | BOOLEAN | true | UI permission flag | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last modification timestamp | |
| payment_token_id | INTEGER | true | Tokenized payment method ID | Used for recurring/saved payments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo standard naming).
    - `journal_id` → `account_journal.id` (Inferred from Odoo standard naming).
    - `currency_id` → `res_currency.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are typically stored in UTC in Odoo environments.
- **Data Volatility:** As a staging table for a wizard, this data may be transient or subject to frequent updates/deletions depending on the Odoo cleanup cron jobs.
- **PII:** The `communication` field may contain sensitive information or personal identifiers; ensure appropriate masking if exposing to non-authorized users.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are either active or purged by the source system.