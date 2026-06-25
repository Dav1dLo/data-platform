# res_company

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_company` is a standard Odoo core table, and the presence of columns like `partner_id`, `currency_id`, and various accounting/inventory configuration fields is characteristic of Odoo's multi-company architecture.

## Functional process 
This table supports the core multi-company configuration and organizational setup within the ERP. It acts as the central repository for company-specific settings, including accounting fiscal years, tax configurations, inventory lead times, and branding/reporting preferences, which are referenced by transactional modules across the platform.

## Description
One row in this table represents a single legal entity or company defined within the Odoo instance. It serves as a configuration master, storing the operational parameters, contact details, and accounting defaults required for the company to function within the broader ERP ecosystem.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence |
| name | VARCHAR | false | Company name | Display name |
| partner_id | INTEGER | false | Linked partner record | Foreign key to `res_partner` |
| currency_id | INTEGER | false | Default company currency | Foreign key to `res_currency` |
| sequence | INTEGER | true | Display order | Used for UI sorting |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC |
| parent_path | VARCHAR | true | Materialized path for hierarchy | Used for tree structures |
| parent_id | INTEGER | true | Parent company ID | For multi-company hierarchy |
| paperformat_id | INTEGER | true | Report paper format | Configuration for PDF reports |
| external_report_layout_id | INTEGER | true | Report layout ID | Branding configuration |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users` |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users` |
| email | VARCHAR | true | Company email address | |
| phone | VARCHAR | true | Company phone number | |
| mobile | VARCHAR | true | Company mobile number | |
| font | VARCHAR | true | Report font family | |
| primary_color | VARCHAR | true | UI/Report primary color | Hex code |
| secondary_color | VARCHAR | true | UI/Report secondary color | Hex code |
| layout_background | VARCHAR | false | Report background style | |
| report_header | JSONB | true | Header configuration | |
| report_footer | JSONB | true | Footer configuration | |
| company_details | JSONB | true | Full company address/details | |
| active | BOOLEAN | true | Soft-delete flag | True if company is active |
| uses_default_logo | BOOLEAN | true | Logo usage flag | |
| write_date | TIMESTAMP | true | Last update timestamp | UTC |
| logo_web | BYTEA | true | Binary logo image | |
| social_twitter | VARCHAR | true | Twitter handle | |
| social_facebook | VARCHAR | true | Facebook URL | |
| social_github | VARCHAR | true | GitHub URL | |
| social_linkedin | VARCHAR | true | LinkedIn URL | |
| social_youtube | VARCHAR | true | YouTube URL | |
| social_instagram | VARCHAR | true | Instagram URL | |
| social_tiktok | VARCHAR | true | TikTok URL | |
| nomenclature_id | INTEGER | true | Barcode nomenclature | |
| resource_calendar_id | INTEGER | true | Default working hours | |
| alias_domain_id | INTEGER | true | Email domain ID | |
| alias_domain_name | VARCHAR | true | Email domain name | |
| email_primary_color | VARCHAR | true | Email template primary color | |
| email_secondary_color | VARCHAR | true | Email template secondary color | |
| partner_gid | INTEGER | true | Global ID for partner | |
| iap_enrich_auto_done | BOOLEAN | true | IAP enrichment status | |
| snailmail_color | BOOLEAN | true | Snailmail color enabled | |
| snailmail_cover | BOOLEAN | true | Snailmail cover page enabled | |
| snailmail_duplex | BOOLEAN | true | Snailmail duplex enabled | |
| payment_onboarding_payment_method | VARCHAR | true | Onboarding payment method | |
| fiscalyear_last_day | INTEGER | false | Fiscal year end day | 1-31 |
| transfer_account_id | INTEGER | true | Internal transfer account | |
| default_cash_difference_income_account_id | INTEGER | true | Cash difference income account | |
| default_cash_difference_expense_account_id | INTEGER | true | Cash difference expense account | |
| account_journal_suspense_account_id | INTEGER | true | Suspense account | |
| account_journal_early_pay_discount_gain_account_id | INTEGER | true | Early payment gain account | |
| account_journal_early_pay_discount_loss_account_id | INTEGER | true | Early payment loss account | |
| account_sale_tax_id | INTEGER | true | Default sales tax | |
| account_purchase_tax_id | INTEGER | true | Default purchase tax | |
| currency_exchange_journal_id | INTEGER | true | Exchange rate journal | |
| income_currency_exchange_account_id | INTEGER | true | Exchange gain account | |
| expense_currency_exchange_account_id | INTEGER | true | Exchange loss account | |
| incoterm_id | INTEGER | true | Default Incoterm | |
| batch_payment_sequence_id | INTEGER | true | Batch payment sequence | |
| account_opening_move_id | INTEGER | true | Opening entry move | |
| account_default_pos_receivable_account_id | INTEGER | true | POS receivable account | |
| expense_accrual_account_id | INTEGER | true | Expense accrual account | |
| revenue_accrual_account_id | INTEGER | true | Revenue accrual account | |
| automatic_entry_default_journal_id | INTEGER | true | Auto-entry journal | |
| account_fiscal_country_id | INTEGER | true | Fiscal country ID | |
| tax_cash_basis_journal_id | INTEGER | true | Cash basis tax journal | |
| account_cash_basis_base_account_id | INTEGER | true | Cash basis base account | |
| account_discount_income_allocation_id | INTEGER | true | Discount income allocation | |
| account_discount_expense_allocation_id | INTEGER | true | Discount expense allocation | |
| fiscalyear_last_month | VARCHAR | false | Fiscal year end month | |
| chart_template | VARCHAR | true | Chart of accounts template | |
| bank_account_code_prefix | VARCHAR | true | Bank account prefix | |
| cash_account_code_prefix | VARCHAR | true | Cash account prefix | |
| transfer_account_code_prefix | VARCHAR | true | Transfer account prefix | |
| tax_calculation_rounding_method | VARCHAR | true | Tax rounding method | |
| terms_type | VARCHAR | true | Invoice terms type | |
| quick_edit_mode | VARCHAR | true | Quick edit mode setting | |
| account_price_include | VARCHAR | false | Tax inclusion setting | |
| fiscalyear_lock_date | DATE | true | Fiscal year lock date | |
| tax_lock_date | DATE | true | Tax lock date | |
| sale_lock_date | DATE | true | Sale lock date | |
| purchase_lock_date | DATE | true | Purchase lock date | |
| hard_lock_date | DATE | true | Hard lock date | |
| account_opening_date | DATE | false | Opening date | |
| invoice_terms | JSONB | true | Invoice terms | |
| invoice_terms_html | JSONB | true | Invoice terms (HTML) | |
| expects_chart_of_accounts | BOOLEAN | true | Chart of accounts expected | |
| anglo_saxon_accounting | BOOLEAN | true | Anglo-Saxon accounting enabled | |
| qr_code | BOOLEAN | true | QR code enabled | |
| display_invoice_amount_total_words | BOOLEAN | true | Show amount in words | |
| display_invoice_tax_company_currency | BOOLEAN | true | Show tax in company currency | |
| account_use_credit_limit | BOOLEAN | true | Credit limit enabled | |
| tax_exigibility | BOOLEAN | true | Tax exigibility enabled | |
| account_storno | BOOLEAN | true | Storno accounting enabled | |
| check_account_audit_trail | BOOLEAN | true | Audit trail enabled | |
| autopost_bills | BOOLEAN | true | Auto-post bills enabled | |
| hr_presence_control_email_amount | INTEGER | true | Email presence threshold | |
| hr_presence_control_ip_list | VARCHAR | true | Allowed IP list | |
| employee_properties_definition | JSONB | true | Employee properties schema | |
| hr_presence_control_login | BOOLEAN | true | Login presence check | |
| hr_presence_control_email | BOOLEAN | true | Email presence check | |
| hr_presence_control_ip | BOOLEAN | true | IP presence check | |
| hr_presence_control_attendance | BOOLEAN | true | Attendance presence check | |
| internal_transit_location_id | INTEGER | true | Internal transit location | |
| stock_mail_confirmation_template_id | INTEGER | true | Stock email template | |
| annual_inventory_day | INTEGER | true | Annual inventory day | |
| annual_inventory_month | VARCHAR | true | Annual inventory month | |
| stock_move_email_validation | BOOLEAN | true | Email validation enabled | |
| website_id | INTEGER | true | Linked website ID | |
| manufacturing_lead | DOUBLE PRECISION | false | Manufacturing lead time | Days |
| po_lock | VARCHAR | true | PO lock setting | |
| po_double_validation | VARCHAR | true | PO double validation setting | |
| po_double_validation_amount | NUMERIC | true | PO validation threshold | |
| po_lead | DOUBLE PRECISION | false | Purchase lead time | Days |
| account_production_wip_account_id | INTEGER | true | WIP account | |
| account_production_wip_overhead_account_id | INTEGER | true | WIP overhead account | |
| stock_sms_confirmation_template_id | INTEGER | true | Stock SMS template | |
| stock_move_sms_validation | BOOLEAN | true | SMS validation enabled | |
| has_received_warning_stock_sms | BOOLEAN | true | SMS warning flag | |
| point_of_sale_update_stock_quantities | VARCHAR | true | POS stock update mode | |
| point_of_sale_ticket_portal_url_display_mode | VARCHAR | false | POS ticket URL mode | |
| point_of_sale_use_ticket_qr_code | BOOLEAN | true | POS QR code enabled | |
| point_of_sale_ticket_unique_code | BOOLEAN | true | POS unique code enabled | |
| days_to_purchase | DOUBLE PRECISION | true | Days to purchase | |
| quotation_validity_days | INTEGER | true | Quotation validity | |
| sale_discount_product_id | INTEGER | true | Discount product ID | |
| sale_onboarding_payment_method | VARCHAR | true | Sale onboarding method | |
| portal_confirmation_sign | BOOLEAN | true | Portal sign enabled | |
| portal_confirmation_pay | BOOLEAN | true | Portal pay enabled | |
| prepayment_percent | DOUBLE PRECISION | true | Prepayment percentage | |
| sale_order_template_id | INTEGER | true | Default sale template | |
| security_lead | DOUBLE PRECISION | false | Security lead time | Days |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `partner_id` → `res_partner.id` (Standard Odoo link between company and its partner record).
    - `currency_id` → `res_currency.id` (Defines the base currency for the company).
    - `parent_id` → `res_company.id` (Self-referencing foreign key for company hierarchy).
- **Natural keys (inferred):**
    - `name` (While not strictly enforced as unique in all Odoo versions, it is the primary business identifier for a company).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is a boolean flag. Queries should filter by `WHERE active = TRUE` to retrieve only currently operational companies.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Sensitive Data:** The table contains contact information (`email`, `phone`, `mobile`) and potentially sensitive configuration data in `JSONB` columns.
- **Binary Data:** `logo_web` contains raw binary data (`BYTEA`); exclude this column unless specifically required for image processing to maintain query performance.
- **Hierarchy:** The `parent_path` column uses a materialized path pattern (e.g., `1/5/12`) which can be used for efficient recursive queries or tree traversal.