# account_reconcile_model

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `account_reconcile_model`, the presence of `create_uid`/`write_uid` audit fields, and the use of `JSONB` for localized names are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the automated bank and payment reconciliation process within the accounting module. It defines the rules and criteria used by the system to automatically match bank statement lines against open invoices or journal entries, reducing manual accounting effort.

## Description
One row represents a single reconciliation rule or model configured for a specific company. These models define the logic (such as matching labels, amounts, or transaction types) that the system applies to automate the clearing of financial transactions. This is a raw landed copy of the Odoo configuration table, serving as the basis for downstream reconciliation reporting and audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | false | Execution order priority | Lower numbers are processed first. |
| company_id | INTEGER | false | Foreign key to company | Links to the owning entity. |
| past_months_limit | INTEGER | true | Lookback window in months | Limits how far back to search for matches. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the rule. |
| rule_type | VARCHAR | false | Type of reconciliation rule | e.g., 'writeoff_button', 'invoice_matching'. |
| matching_order | VARCHAR | false | Matching strategy | Defines the logic flow for matching. |
| counterpart_type | VARCHAR | true | Type of counterpart entry | Defines the nature of the balancing entry. |
| match_nature | VARCHAR | false | Matching criteria nature | e.g., 'amount_between', 'both'. |
| match_amount | VARCHAR | true | Amount matching logic | Defines how amounts are compared. |
| match_label | VARCHAR | true | Label matching logic | e.g., 'contains', 'regex'. |
| match_label_param | VARCHAR | true | Parameter for label matching | The string or pattern to match. |
| match_note | VARCHAR | true | Note matching logic | Criteria for matching transaction notes. |
| match_note_param | VARCHAR | true | Parameter for note matching | The string or pattern to match. |
| match_transaction_type | VARCHAR | true | Transaction type logic | Criteria for matching transaction types. |
| match_transaction_type_param | VARCHAR | true | Parameter for transaction type | The specific type string. |
| payment_tolerance_type | VARCHAR | false | Tolerance calculation method | e.g., 'percentage', 'fixed'. |
| decimal_separator | VARCHAR | true | Decimal separator character | Used for parsing amounts. |
| name | JSONB | false | Rule name | Multilingual label stored as JSON. |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is disabled. |
| auto_reconcile | BOOLEAN | true | Auto-reconcile toggle | If true, system attempts auto-matching. |
| to_check | BOOLEAN | true | Review flag | If true, matched items are marked for review. |
| match_text_location_label | BOOLEAN | true | Search label field | Whether to search in the label field. |
| match_text_location_note | BOOLEAN | true | Search note field | Whether to search in the note field. |
| match_text_location_reference | BOOLEAN | true | Search reference field | Whether to search in the reference field. |
| match_same_currency | BOOLEAN | true | Currency constraint | If true, only match same-currency items. |
| allow_payment_tolerance | BOOLEAN | true | Tolerance toggle | Whether to allow payment variance. |
| match_partner | BOOLEAN | true | Partner matching toggle | Whether to enforce partner matching. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |
| match_amount_min | DOUBLE PRECISION | true | Minimum amount threshold | Lower bound for amount matching. |
| match_amount_max | DOUBLE PRECISION | true | Maximum amount threshold | Upper bound for amount matching. |
| payment_tolerance_param | DOUBLE PRECISION | true | Tolerance value | The numeric value for the tolerance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal configuration logic; no direct PII, but reflects business financial controls.
- **Timestamps:** Assumed to be in UTC as per standard Odoo deployment practices.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to see current rules.
- **JSONB:** The `name` column is `JSONB`; use `name->>'en_US'` or similar syntax to extract specific language values.