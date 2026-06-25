# payment_provider_onboarding_wizard

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in the Odoo framework, as well as the use of a sequence-based default for the `id` column.

## Functional process 
This table supports the "Payment Provider Configuration" process. It captures the state and user-provided configuration details during the onboarding wizard flow for setting up various payment methods (e.g., PayPal, manual bank transfers) within the accounting or e-commerce module.

## Description
One row in this table represents a single instance of a payment provider onboarding session or configuration record. It serves as a raw landing copy of the wizard's state, tracking the user who initiated or modified the setup and the specific parameters (such as account numbers or email addresses) provided for the payment integration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard PostgreSQL sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| payment_method | VARCHAR | true | Type of payment provider | e.g., 'paypal', 'manual', 'stripe'. |
| paypal_email_account | VARCHAR | true | PayPal account email address | PII; sensitive data. |
| manual_name | VARCHAR | true | Display name for manual payment | Used for custom payment methods. |
| journal_name | VARCHAR | true | Associated accounting journal name | Links the provider to an accounting journal. |
| acc_number | VARCHAR | true | Bank account number | Sensitive financial information. |
| manual_post_msg | TEXT | true | Custom post-payment message | Instructions shown to the end customer. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains PII (`paypal_email_account`) and financial data (`acc_number`). Ensure appropriate masking or access controls are applied.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain incomplete wizard sessions; rows with null values in configuration fields may represent abandoned onboarding attempts.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; assume all records are current unless business logic dictates otherwise.