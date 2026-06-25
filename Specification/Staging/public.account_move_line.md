# account_move_line

## Source system
This table originates from Odoo ERP. The naming convention (`account_move_line`, `move_id`, `journal_id`, `partner_id`) and the specific structure of accounting entries (debit/credit/balance, reconciliation fields, and analytic distributions) are characteristic of the Odoo accounting module.

## Functional process 
This table supports the General Ledger and sub-ledger accounting processes. It records the individual line items that constitute an accounting entry (`account_move`), tracking financial movements across accounts, partners, and products, and facilitating tax reporting, reconciliation, and analytic cost accounting.

## Description
One row represents a single line item within an accounting journal entry. It captures the financial impact of a transaction on a specific general ledger account, including amounts, currency, and associated metadata like tax or product details. As a staging table, it provides a raw, granular view of all ledger movements before any aggregation or transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| move_id | INTEGER | false | Foreign key to account_move | Links to the parent journal entry. |
| journal_id | INTEGER | true | Foreign key to account_journal | The journal where the entry is recorded. |
| company_id | INTEGER | true | Foreign key to res_company | The company associated with the entry. |
| company_currency_id | INTEGER | true | Foreign key to res_currency | The base currency of the company. |
| sequence | INTEGER | true | Line sequence number | Used for ordering lines within a move. |
| account_id | INTEGER | true | Foreign key to account_account | The GL account impacted by this line. |
| currency_id | INTEGER | false | Foreign key to res_currency | The transaction currency. |
| partner_id | INTEGER | true | Foreign key to res_partner | The customer or vendor involved. |
| reconcile_model_id | INTEGER | true | Foreign key to reconcile_model | Model used for automated reconciliation. |
| payment_id | INTEGER | true | Foreign key to account_payment | Links to the payment record if applicable. |
| statement_line_id | INTEGER | true | Foreign key to bank_statement_line | Links to bank statement line. |
| statement_id | INTEGER | true | Foreign key to bank_statement | Links to bank statement header. |
| group_tax_id | INTEGER | true | Foreign key to account_tax_group | Tax group identifier. |
| tax_line_id | INTEGER | true | Foreign key to account_tax | Specific tax line identifier. |
| tax_group_id | INTEGER | true | Foreign key to account_tax_group | Grouping for tax reporting. |
| tax_repartition_line_id | INTEGER | true | Foreign key to tax_repartition | Tax repartition logic identifier. |
| full_reconcile_id | INTEGER | true | Foreign key to full_reconcile | Links to a full reconciliation group. |
| product_id | INTEGER | true | Foreign key to product_product | The product involved in the transaction. |
| product_uom_id | INTEGER | true | Foreign key to uom_uom | Unit of measure for the product. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last updater user ID | Audit field for record modification. |
| move_name | VARCHAR | true | Move display name | Human-readable reference for the move. |
| parent_state | VARCHAR | true | Move status | e.g., 'draft', 'posted'. |
| ref | VARCHAR | true | Reference string | External reference or memo. |
| name | VARCHAR | true | Line description | Label or description of the line item. |
| matching_number | VARCHAR | true | Reconciliation matching ID | Identifier for matched lines. |
| display_type | VARCHAR | false | Line type | e.g., 'line', 'tax', 'product'. |
| date | DATE | true | Accounting date | The date the entry affects the ledger. |
| invoice_date | DATE | true | Invoice date | Date of the associated invoice. |
| date_maturity | DATE | true | Maturity date | Due date for payment. |
| discount_date | DATE | true | Discount date | Date for early payment discount. |
| analytic_distribution | JSONB | true | Analytic distribution | JSON mapping for cost center allocation. |
| debit | NUMERIC | true | Debit amount | Amount in company currency. |
| credit | NUMERIC | true | Credit amount | Amount in company currency. |
| balance | NUMERIC | true | Net balance | Calculated as debit - credit. |
| amount_currency | NUMERIC | true | Amount in transaction currency | Value in the foreign currency. |
| tax_base_amount | NUMERIC | true | Tax base amount | Amount used to calculate tax. |
| amount_residual | NUMERIC | true | Residual amount | Unreconciled balance in company currency. |
| amount_residual_currency | NUMERIC | true | Residual amount in currency | Unreconciled balance in transaction currency. |
| quantity | NUMERIC | true | Quantity | Product quantity involved. |
| price_unit | NUMERIC | true | Unit price | Price per unit. |
| price_subtotal | NUMERIC | true | Subtotal | Line total before tax. |
| price_total | NUMERIC | true | Total price | Line total including tax. |
| discount | NUMERIC | true | Discount percentage | Percentage applied to the line. |
| discount_amount_currency | NUMERIC | true | Discount amount | Discount value in transaction currency. |
| discount_balance | NUMERIC | true | Discount balance | Discount value in company currency. |
| is_imported | BOOLEAN | true | Import flag | True if record was imported. |
| tax_tag_invert | BOOLEAN | true | Tax tag inversion | Logic flag for tax reporting. |
| reconciled | BOOLEAN | true | Reconciled status | True if the line is fully reconciled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Update timestamp | UTC timestamp of last modification. |
| purchase_line_id | INTEGER | true | Foreign key to purchase_order_line | Links to purchasing module. |
| is_downpayment | BOOLEAN | true | Downpayment flag | Identifies downpayment lines. |
| cogs_origin_id | INTEGER | true | COGS origin ID | Links to cost of goods sold origin. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Standard Odoo parent-child relationship)
    - `account_id` → `account_account.id` (Links to the chart of accounts)
    - `partner_id` → `res_partner.id` (Links to the business partner/customer/vendor)
    - `product_id` → `product_product.id` (Links to the product catalog)
- **Natural keys (inferred):** None. This is a system-generated ledger table; uniqueness is maintained by the surrogate `id`.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and potentially sensitive financial descriptions in `ref` or `name`.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes in this table; records are usually permanent once posted.
- **Data Integrity:** `balance` should always equal `debit - credit`. Always verify that the sum of `balance` for a given `move_id` is zero for balanced journal entries.
- **Analytic Data:** The `analytic_distribution` column is `JSONB`; ensure your downstream processing can parse JSON structures to extract cost center allocations.