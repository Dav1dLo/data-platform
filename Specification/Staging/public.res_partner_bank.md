# res_partner_bank

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the naming convention `res_partner_bank`, the use of `partner_id` and `company_id` foreign keys, and the standard Odoo audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the financial master data management process, specifically the storage of bank account details associated with business partners (customers, vendors, or internal companies). It facilitates payment processing and treasury operations by linking entities to their respective financial institutions and account numbers.

## Description
One row in this table represents a single bank account record linked to a specific business partner. It serves as a raw landing copy of the Odoo `res.partner.bank` model, capturing account numbers, routing information, and status flags at the grain of one row per bank account.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_partner_bank_id_seq`. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the owner of the bank account. |
| bank_id | INTEGER | true | Foreign key to the bank | Links to the financial institution entity. |
| sequence | INTEGER | true | Display order | Used for UI sorting. |
| currency_id | INTEGER | true | Foreign key to currency | The currency associated with this account. |
| company_id | INTEGER | true | Foreign key to company | The company this account belongs to. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | Audit: user who last modified the record. |
| acc_number | VARCHAR | false | Bank account number | The raw account number string. |
| sanitized_acc_number | VARCHAR | true | Cleaned account number | Often stripped of spaces/special chars. |
| acc_holder_name | VARCHAR | true | Account holder name | Name as registered at the bank. |
| active | BOOLEAN | true | Soft-delete flag | If false, the account is archived. |
| allow_out_payment | BOOLEAN | true | Payment permission | Flag to enable outgoing payments. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| aba_routing | VARCHAR | true | ABA routing number | Specific to US banking systems. |
| has_iban_warning | BOOLEAN | true | IBAN validation flag | Indicates potential IBAN format issues. |
| has_money_transfer_warning | BOOLEAN | true | Transfer warning flag | Indicates potential risk or validation issues. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo relationship to partner entity).
    - `bank_id` → `res_bank.id` (Standard Odoo relationship to bank entity).
    - `currency_id` → `res_currency.id` (Standard Odoo relationship to currency entity).
    - `company_id` → `res_company.id` (Standard Odoo relationship to company entity).
- **Natural keys (inferred):** 
    - `acc_number` (Combined with `partner_id` and `company_id` usually forms the business uniqueness).

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `acc_number` and `acc_holder_name` are sensitive financial data and should be masked in non-production environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo server configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical audits.
- **Data Integrity:** `sanitized_acc_number` is preferred for joins or deduplication logic over the raw `acc_number`.