# sale_payment_provider_onboarding_wizard

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of the primary key sequence (`public.sale_payment_provider_onboarding_wizard_id_seq`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the "Payment Provider Onboarding" business process, specifically capturing the configuration steps for setting up payment gateways (like PayPal or manual bank transfers) within the sales module. It acts as a temporary state holder or wizard configuration object used during the initial setup of payment methods for customer transactions.

## Description
One row in this table represents a single instance of a payment provider configuration session initiated by a user. It serves as a raw landed copy of the wizard's state, capturing the user's inputs for payment method details, account identifiers, and associated journal settings before they are persisted to the core accounting or payment modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-increment. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| payment_method | VARCHAR | true | Selected payment provider type | e.g., 'paypal', 'manual'. |
| paypal_email_account | VARCHAR | true | PayPal account email address | PII; sensitive data. |
| manual_name | VARCHAR | true | Display name for manual payment | Used for manual bank transfer labels. |
| journal_name | VARCHAR | true | Associated accounting journal name | Links to the general ledger journal. |
| acc_number | VARCHAR | true | Bank account number | Sensitive financial data. |
| manual_post_msg | TEXT | true | Custom payment instruction message | Text displayed to customers. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains PII (`paypal_email_account`) and financial data (`acc_number`). Ensure appropriate masking or access controls are applied.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** As a "wizard" table, rows may represent transient states or incomplete configurations; verify if the record is linked to a finalized payment provider before using it for financial reporting.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume standard CRUD behavior unless otherwise specified by the source application logic.