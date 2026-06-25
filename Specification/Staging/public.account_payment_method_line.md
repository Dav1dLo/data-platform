# account_payment_method_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the configuration of payment methods within the accounting module. It maps specific payment methods to their corresponding accounting journals and accounts, defining how payments are processed and reconciled within the financial ledger.

## Description
One row in this table represents a single configuration line linking a payment method to a specific accounting journal or account. It serves as a raw landed copy of the Odoo `account.payment.method.line` model, capturing the association between payment processing logic and financial recording.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_payment_method_line_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for UI sorting of payment methods. |
| payment_method_id | INTEGER | false | Foreign key to payment method | Links to the definition of the payment method. |
| payment_account_id | INTEGER | true | Foreign key to account | The GL account used for this payment method. |
| journal_id | INTEGER | true | Foreign key to journal | The accounting journal associated with this line. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | VARCHAR | true | Descriptive name | Human-readable label for the payment line. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| payment_provider_id | INTEGER | true | Foreign key to provider | Links to the external payment gateway provider. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_method_id` → `account_payment_method.id` (Standard Odoo naming convention for payment methods).
    - `payment_account_id` → `account_account.id` (Standard Odoo naming convention for chart of accounts).
    - `journal_id` → `account_journal.id` (Standard Odoo naming convention for accounting journals).
    - `payment_provider_id` → `payment_provider.id` (Standard Odoo naming convention for payment gateways).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in UTC as per Odoo standard behavior.
- This table is a staging entity; it may contain historical versions of configurations if the source system performs soft deletes or maintains audit trails.
- The `id` column is a surrogate key; do not rely on it for business logic across different environments (e.g., dev vs. prod).
- `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not map to external identity provider IDs without a join to the `res_users` table.