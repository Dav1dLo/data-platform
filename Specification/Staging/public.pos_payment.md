# pos_payment

## Source system
This table originates from an Odoo ERP system, indicated by the naming conventions such as `account_move_id`, `create_uid`, `write_uid`, and the use of sequence-based primary keys (`nextval` on `pos_payment_id_seq`). It specifically captures point-of-sale transaction data.

## Functional process 
This table supports the Point-of-Sale (POS) financial reconciliation process. It records individual payment entries linked to POS orders, tracking payment methods, card details, and transaction statuses to ensure that cash, card, and other payment types are correctly accounted for against sales orders.

## Description
One row represents a single payment transaction associated with a POS order. It serves as a raw landed staging entity, capturing the granular details of how a customer settled their balance, including card metadata and payment status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_payment_id_seq`. |
| pos_order_id | INTEGER | false | Foreign key to POS order | Links to the parent order. |
| payment_method_id | INTEGER | false | Payment method identifier | References the method used (e.g., Cash, Card). |
| session_id | INTEGER | true | POS session identifier | Groups payments by POS session. |
| company_id | INTEGER | true | Company identifier | Multi-company context. |
| account_move_id | INTEGER | true | Accounting entry ID | Links to the general ledger entry. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | VARCHAR | true | Payment name/label | Often a descriptive string or sequence. |
| card_type | VARCHAR | true | Type of card used | e.g., Credit, Debit. |
| card_brand | VARCHAR | true | Card brand | e.g., Visa, Mastercard. |
| card_no | VARCHAR | true | Masked card number | PII: Contains sensitive card data. |
| cardholder_name | VARCHAR | true | Name on card | PII: Contains customer name. |
| payment_ref_no | VARCHAR | true | External reference number | Transaction reference from gateway. |
| payment_method_authcode | VARCHAR | true | Authorization code | Auth code from payment processor. |
| payment_method_issuer_bank | VARCHAR | true | Issuing bank name | Bank associated with the card. |
| payment_method_payment_mode | VARCHAR | true | Payment mode | Specific mode of payment. |
| transaction_id | VARCHAR | true | Unique transaction ID | Unique ID from the payment provider. |
| payment_status | VARCHAR | true | Status of payment | e.g., 'done', 'reversed'. |
| ticket | VARCHAR | true | Receipt/Ticket identifier | Reference to the printed ticket. |
| uuid | VARCHAR | true | Global unique identifier | System-wide unique ID. |
| amount | NUMERIC | false | Payment amount | Monetary value of the payment. |
| is_change | BOOLEAN | true | Change flag | Indicates if this is a change payment. |
| payment_date | TIMESTAMP | false | Date of payment | Timestamp of the transaction. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| employee_id | INTEGER | true | Employee identifier | The employee processing the payment. |
| online_account_payment_id | INTEGER | true | Online payment reference | Links to online payment systems. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `pos_order_id` → `pos_order.id` (Inferred from standard Odoo POS schema naming).
    - `account_move_id` → `account_move.id` (Inferred from standard Odoo accounting schema naming).
- **Natural keys (inferred):**
    - `uuid` (Likely the business-level unique identifier for the transaction).

## Caveats for downstream consumers

- **PII:** Columns `card_no` and `cardholder_name` contain sensitive customer information and should be masked or restricted.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless indicated by `payment_status`.
- **Data Quality:** `payment_ref_no` and `transaction_id` may be null for cash payments or offline transactions.