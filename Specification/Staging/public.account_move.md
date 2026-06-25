# account_move

## Source system
This table originates from Odoo ERP. The naming convention (`account_move`, `journal_id`, `partner_id`, `move_type`) and the specific column structure (e.g., `inalterable_hash`, `auto_post`, `invoice_date_due`) are characteristic of the Odoo accounting module's core ledger engine.

## Functional process 
This table supports the "Record-to-Report" and "Order-to-Cash" business processes. It acts as the central ledger for all accounting entries, including customer invoices, vendor bills, bank statements, and manual journal entries. It tracks the financial lifecycle of a transaction from creation through to payment reconciliation and posting.

## Description
One row represents a single accounting move (journal entry), which may be an invoice, a credit note, or a general ledger adjustment. The grain is one row per unique accounting document or entry. In the staging layer, this represents a raw, denormalized copy of the Odoo `account.move` model, containing both header-level financial data and metadata for document tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence_number | INTEGER | true | Internal sequence number | Used for ordering within a journal. |
| message_main_attachment_id | INTEGER | true | Link to main attachment | FK to `ir_attachment`. |
| journal_id | INTEGER | false | Accounting journal ID | FK to `account_journal`. |
| company_id | INTEGER | true | Company ID | FK to `res_company`. |
| origin_payment_id | INTEGER | true | Source payment ID | FK to `account_payment`. |
| statement_line_id | INTEGER | true | Bank statement line ID | FK to `account_bank_statement_line`. |
| tax_cash_basis_rec_id | INTEGER | true | Tax cash basis reconciliation ID | Used for cash-basis accounting. |
| tax_cash_basis_origin_move_id | INTEGER | true | Origin move for tax cash basis | FK to `account_move`. |
| auto_post_origin_id | INTEGER | true | Auto-post origin ID | FK to `account_move`. |
| secure_sequence_number | INTEGER | true | Hash-secured sequence number | Used for legal compliance/auditing. |
| invoice_payment_term_id | INTEGER | true | Payment terms ID | FK to `account_payment_term`. |
| partner_id | INTEGER | true | Primary partner ID | FK to `res_partner`. |
| commercial_partner_id | INTEGER | true | Commercial partner ID | FK to `res_partner`. |
| partner_shipping_id | INTEGER | true | Shipping partner ID | FK to `res_partner`. |
| partner_bank_id | INTEGER | true | Partner bank account ID | FK to `res_partner_bank`. |
| fiscal_position_id | INTEGER | true | Fiscal position ID | FK to `account_fiscal_position`. |
| preferred_payment_method_line_id | INTEGER | true | Payment method line ID | FK to `account_payment_method_line`. |
| currency_id | INTEGER | false | Currency ID | FK to `res_currency`. |
| reversed_entry_id | INTEGER | true | Reversal entry ID | FK to `account_move` (the entry being reversed). |
| invoice_user_id | INTEGER | true | Salesperson/Account manager ID | FK to `res_users`. |
| invoice_incoterm_id | INTEGER | true | Incoterm ID | FK to `account_incoterms`. |
| invoice_cash_rounding_id | INTEGER | true | Cash rounding ID | FK to `account_cash_rounding`. |
| create_uid | INTEGER | true | Creator user ID | FK to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | FK to `res_users`. |
| sequence_prefix | VARCHAR | true | Sequence prefix | String prefix for the document name. |
| access_token | VARCHAR | true | Portal access token | Used for public invoice links. |
| name | VARCHAR | true | Document number | The human-readable invoice/entry number. |
| ref | VARCHAR | true | Reference | External reference string. |
| state | VARCHAR | false | Lifecycle state | e.g., 'draft', 'posted', 'cancel'. |
| move_type | VARCHAR | false | Move type | e.g., 'out_invoice', 'in_invoice'. |
| auto_post | VARCHAR | false | Auto-post configuration | Frequency or status for auto-posting. |
| inalterable_hash | VARCHAR | true | Legal hash | Used for tax audit compliance. |
| payment_reference | VARCHAR | true | Payment reference | Memo for bank reconciliation. |
| qr_code_method | VARCHAR | true | QR code generation method | Used for payment instructions. |
| payment_state | VARCHAR | true | Payment status | e.g., 'not_paid', 'paid', 'partial'. |
| invoice_source_email | VARCHAR | true | Source email | Email address of the sender. |
| invoice_partner_display_name | VARCHAR | true | Partner display name | Denormalized name. |
| invoice_origin | VARCHAR | true | Origin document | Source document reference. |
| incoterm_location | VARCHAR | true | Incoterm location | Free text location. |
| date | DATE | false | Accounting date | The date the entry affects the ledger. |
| auto_post_until | DATE | true | Auto-post end date | Limit for recurring entries. |
| invoice_date | DATE | true | Invoice date | The date on the invoice document. |
| invoice_date_due | DATE | true | Due date | Payment deadline. |
| delivery_date | DATE | true | Delivery date | Actual goods delivery date. |
| sending_data | JSONB | true | Sending metadata | JSON blob for communication logs. |
| narration | TEXT | true | Internal notes | Comments on the entry. |
| invoice_currency_rate | NUMERIC | true | Currency rate | Exchange rate at time of entry. |
| amount_untaxed | NUMERIC | true | Untaxed amount | Total before tax. |
| amount_tax | NUMERIC | true | Tax amount | Total tax. |
| amount_total | NUMERIC | true | Total amount | Gross total. |
| amount_residual | NUMERIC | true | Residual amount | Remaining balance to be paid. |
| amount_untaxed_signed | NUMERIC | true | Signed untaxed amount | Signed based on move type. |
| amount_untaxed_in_currency_signed | NUMERIC | true | Signed untaxed (currency) | Signed amount in foreign currency. |
| amount_tax_signed | NUMERIC | true | Signed tax amount | Signed tax. |
| amount_total_signed | NUMERIC | true | Signed total amount | Signed gross total. |
| amount_total_in_currency_signed | NUMERIC | true | Signed total (currency) | Signed total in foreign currency. |
| amount_residual_signed | NUMERIC | true | Signed residual amount | Signed remaining balance. |
| quick_edit_total_amount | NUMERIC | true | Quick edit total | UI helper field. |
| is_storno | BOOLEAN | true | Storno flag | Indicates a reversal entry. |
| always_tax_exigible | BOOLEAN | true | Tax exigibility flag | For specific tax reporting. |
| checked | BOOLEAN | true | Checked flag | Internal audit flag. |
| posted_before | BOOLEAN | true | Posted before flag | Tracks if entry was previously posted. |
| made_sequence_gap | BOOLEAN | true | Sequence gap flag | Indicates a break in numbering. |
| is_manually_modified | BOOLEAN | true | Manual modification flag | Indicates user override. |
| is_move_sent | BOOLEAN | true | Sent flag | Indicates if sent to customer. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC. |
| stock_move_id | INTEGER | true | Stock move ID | FK to `stock_move`. |
| reversed_pos_order_id | INTEGER | true | POS order ID | FK to `pos_order`. |
| campaign_id | INTEGER | true | Marketing campaign ID | FK to `utm_campaign`. |
| source_id | INTEGER | true | Marketing source ID | FK to `utm_source`. |
| medium_id | INTEGER | true | Marketing medium ID | FK to `utm_medium`. |
| team_id | INTEGER | true | Sales team ID | FK to `crm_team`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Standard Odoo accounting link)
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `currency_id` → `res_currency.id` (Standard Odoo currency link)
- **Natural keys (inferred):** 
    - `name` (The document number, e.g., "INV/2023/0001")

## Caveats for downstream consumers

- **Sensitive Data:** Contains `invoice_source_email` and `partner_id` which may be considered PII.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically uses the `state` column (e.g., 'cancel') rather than physical deletion. Filter by `state = 'posted'` for financial reporting.
- **Signed Amounts:** The `_signed` columns are critical for reporting; they automatically handle the debit/credit logic based on the `move_type` (e.g., invoices are positive, credit notes are negative).