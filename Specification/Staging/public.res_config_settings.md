# res_config_settings

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `res_config_settings` is a standard Odoo pattern for storing global configuration parameters and module activation states. The presence of columns prefixed with `module_` and `group_` is characteristic of Odoo's modular architecture, where settings are dynamically aggregated based on installed features.

## Functional process 
This table supports the "System Configuration and Feature Management" process. It acts as the central repository for application-wide settings, including integration credentials (e.g., Twilio, Google, Unsplash), feature toggles (e.g., multi-currency, analytic accounting), and module-specific configurations across CRM, Sales, Inventory, and Accounting modules.

## Description
One row in this table represents a specific configuration set for a company or website instance within the Odoo environment. It captures the current state of various business features, integration keys, and operational preferences. In the staging layer, this represents a raw landed copy of the system's configuration state, which is frequently updated as administrators modify settings via the Odoo user interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed. |
| web_app_name | VARCHAR | true | Custom name for the web application | |
| company_id | INTEGER | false | ID of the associated company | References `res_company`. |
| user_default_rights | BOOLEAN | true | Flag for default user rights | |
| module_base_import | BOOLEAN | true | Feature toggle for base import | |
| module_google_calendar | BOOLEAN | true | Feature toggle for Google Calendar | |
| module_microsoft_calendar | BOOLEAN | true | Feature toggle for MS Calendar | |
| module_mail_plugin | BOOLEAN | true | Feature toggle for mail plugin | |
| module_auth_oauth | BOOLEAN | true | Feature toggle for OAuth auth | |
| module_auth_ldap | BOOLEAN | true | Feature toggle for LDAP auth | |
| module_account_inter_company_rules | BOOLEAN | true | Feature toggle for inter-company rules | |
| module_voip | BOOLEAN | true | Feature toggle for VoIP | |
| module_web_unsplash | BOOLEAN | true | Feature toggle for Unsplash integration | |
| module_sms | BOOLEAN | true | Feature toggle for SMS services | |
| module_partner_autocomplete | BOOLEAN | true | Feature toggle for partner autocomplete | |
| module_base_geolocalize | BOOLEAN | true | Feature toggle for geolocalization | |
| module_google_recaptcha | BOOLEAN | true | Feature toggle for Google Recaptcha | |
| module_website_cf_turnstile | BOOLEAN | true | Feature toggle for Cloudflare Turnstile | |
| group_multi_currency | BOOLEAN | true | Feature toggle for multi-currency | |
| show_effect | BOOLEAN | true | Flag to show UI effects | |
| module_product_images | BOOLEAN | true | Feature toggle for product images | |
| profiling_enabled_until | TIMESTAMP | true | Expiry date for profiling | |
| recaptcha_public_key | VARCHAR | true | Public key for Recaptcha | Sensitive. |
| recaptcha_private_key | VARCHAR | true | Private key for Recaptcha | Sensitive. |
| recaptcha_min_score | DOUBLE PRECISION | true | Minimum score for Recaptcha | |
| tenor_gif_limit | INTEGER | true | Limit for Tenor GIFs | |
| twilio_account_sid | VARCHAR | true | Twilio Account SID | Sensitive. |
| twilio_account_token | VARCHAR | true | Twilio Account Token | Sensitive. |
| sfu_server_url | VARCHAR | true | SFU Server URL | |
| sfu_server_key | VARCHAR | true | SFU Server Key | Sensitive. |
| tenor_api_key | VARCHAR | true | Tenor API Key | Sensitive. |
| tenor_content_filter | VARCHAR | true | Content filter level for Tenor | |
| google_translate_api_key | VARCHAR | true | Google Translate API Key | Sensitive. |
| external_email_server_default | BOOLEAN | true | Flag for default email server | |
| module_google_gmail | BOOLEAN | true | Feature toggle for Gmail integration | |
| module_microsoft_outlook | BOOLEAN | true | Feature toggle for Outlook integration | |
| restrict_template_rendering | BOOLEAN | true | Flag to restrict template rendering | |
| use_twilio_rtc_servers | BOOLEAN | true | Flag to use Twilio RTC | |
| group_analytic_accounting | BOOLEAN | true | Feature toggle for analytic accounting | |
| auth_signup_template_user_id | INTEGER | true | Template user ID for signups | |
| auth_signup_uninvited | VARCHAR | true | Signup policy for uninvited users | |
| auth_signup_reset_password | BOOLEAN | true | Flag for password reset capability | |
| google_gmail_client_identifier | VARCHAR | true | Gmail Client ID | Sensitive. |
| google_gmail_client_secret | VARCHAR | true | Gmail Client Secret | Sensitive. |
| product_weight_in_lbs | VARCHAR | true | Weight unit configuration | |
| product_volume_volume_in_cubic_feet | VARCHAR | true | Volume unit configuration | |
| group_uom | BOOLEAN | true | Feature toggle for Units of Measure | |
| group_product_variant | BOOLEAN | true | Feature toggle for product variants | |
| module_loyalty | BOOLEAN | true | Feature toggle for loyalty program | |
| group_stock_packaging | BOOLEAN | true | Feature toggle for stock packaging | |
| group_product_pricelist | BOOLEAN | true | Feature toggle for product pricelists | |
| unsplash_access_key | VARCHAR | true | Unsplash Access Key | Sensitive. |
| unsplash_app_id | VARCHAR | true | Unsplash App ID | |
| digest_id | INTEGER | true | ID of the digest configuration | |
| digest_emails | BOOLEAN | true | Flag for digest emails | |
| chart_template | VARCHAR | true | Accounting chart template code | |
| module_account_accountant | BOOLEAN | true | Feature toggle for Accountant module | |
| group_warning_account | BOOLEAN | true | Feature toggle for account warnings | |
| group_cash_rounding | BOOLEAN | true | Feature toggle for cash rounding | |
| group_show_sale_receipts | BOOLEAN | true | Flag to show sale receipts | |
| group_show_purchase_receipts | BOOLEAN | true | Flag to show purchase receipts | |
| module_account_budget | BOOLEAN | true | Feature toggle for budgets | |
| module_account_payment | BOOLEAN | true | Feature toggle for payments | |
| module_account_reports | BOOLEAN | true | Feature toggle for account reports | |
| module_account_check_printing | BOOLEAN | true | Feature toggle for check printing | |
| module_account_batch_payment | BOOLEAN | true | Feature toggle for batch payments | |
| module_account_iso20022 | BOOLEAN | true | Feature toggle for ISO20022 | |
| module_account_sepa_direct_debit | BOOLEAN | true | Feature toggle for SEPA | |
| module_account_bank_statement_import_qif | BOOLEAN | true | Feature toggle for QIF import | |
| module_account_bank_statement_import_ofx | BOOLEAN | true | Feature toggle for OFX import | |
| module_account_bank_statement_import_csv | BOOLEAN | true | Feature toggle for CSV import | |
| module_account_bank_statement_import_camt | BOOLEAN | true | Feature toggle for CAMT import | |
| module_currency_rate_live | BOOLEAN | true | Feature toggle for live currency rates | |
| module_account_intrastat | BOOLEAN | true | Feature toggle for Intrastat | |
| module_product_margin | BOOLEAN | true | Feature toggle for product margins | |
| module_l10n_eu_oss | BOOLEAN | true | Feature toggle for EU OSS | |
| module_account_extract | BOOLEAN | true | Feature toggle for account extraction | |
| module_account_invoice_extract | BOOLEAN | true | Feature toggle for invoice extraction | |
| module_account_bank_statement_extract | BOOLEAN | true | Feature toggle for statement extraction | |
| module_snailmail_account | BOOLEAN | true | Feature toggle for snailmail | |
| module_account_peppol | BOOLEAN | true | Feature toggle for Peppol | |
| use_invoice_terms | BOOLEAN | true | Flag to use invoice terms | |
| group_sale_delivery_address | BOOLEAN | true | Feature toggle for delivery addresses | |
| crm_auto_assignment_interval_number | INTEGER | true | Interval number for CRM assignment | |
| crm_auto_assignment_action | VARCHAR | true | Action type for CRM assignment | |
| crm_auto_assignment_interval_type | VARCHAR | true | Interval type for CRM assignment | |
| lead_enrich_auto | VARCHAR | true | Auto-enrichment policy for leads | |
| predictive_lead_scoring_start_date_str | VARCHAR | true | Start date for lead scoring | |
| predictive_lead_scoring_fields_str | VARCHAR | true | Fields used for lead scoring | |
| group_use_lead | BOOLEAN | true | Feature toggle for leads | |
| group_use_recurring_revenues | BOOLEAN | true | Feature toggle for recurring revenue | |
| is_membership_multi | BOOLEAN | true | Flag for multi-membership | |
| crm_use_auto_assignment | BOOLEAN | true | Flag for CRM auto-assignment | |
| module_crm_iap_mine | BOOLEAN | true | Feature toggle for CRM IAP mine | |
| module_crm_iap_enrich | BOOLEAN | true | Feature toggle for CRM IAP enrich | |
| module_website_crm_iap_reveal | BOOLEAN | true | Feature toggle for CRM IAP reveal | |
| lead_mining_in_pipeline | BOOLEAN | true | Flag for lead mining in pipeline | |
| crm_auto_assignment_run_datetime | TIMESTAMP | true | Last run time for CRM assignment | |
| module_hr_presence | BOOLEAN | true | Feature toggle for HR presence | |
| module_hr_skills | BOOLEAN | true | Feature toggle for HR skills | |
| module_hr_homeworking | BOOLEAN | true | Feature toggle for HR homeworking | |
| hr_employee_self_edit | BOOLEAN | true | Flag for employee self-edit | |
| module_hr_timesheet | BOOLEAN | true | Feature toggle for timesheets | |
| group_project_rating | BOOLEAN | true | Feature toggle for project ratings | |
| group_project_stages | BOOLEAN | true | Feature toggle for project stages | |
| group_project_recurring_tasks | BOOLEAN | true | Feature toggle for recurring tasks | |
| group_project_task_dependencies | BOOLEAN | true | Feature toggle for task dependencies | |
| group_project_milestone | BOOLEAN | true | Feature toggle for milestones | |
| barcode_separator | VARCHAR | true | Separator character for barcodes | |
| module_product_expiry | BOOLEAN | true | Feature toggle for product expiry | |
| group_stock_production_lot | BOOLEAN | true | Feature toggle for production lots | |
| group_stock_lot_print_gs1 | BOOLEAN | true | Feature toggle for GS1 printing | |
| group_lot_on_delivery_slip | BOOLEAN | true | Flag for lot on delivery slip | |
| group_stock_tracking_lot | BOOLEAN | true | Feature toggle for tracking lots | |
| group_stock_tracking_owner | BOOLEAN | true | Feature toggle for tracking owners | |
| group_stock_adv_location | BOOLEAN | true | Feature toggle for advanced locations | |
| group_warning_stock | BOOLEAN | true | Feature toggle for stock warnings | |
| group_stock_sign_delivery | BOOLEAN | true | Feature toggle for delivery signatures | |
| module_stock_picking_batch | BOOLEAN | true | Feature toggle for batch picking | |
| module_stock_barcode | BOOLEAN | true | Feature toggle for stock barcode | |
| module_stock_barcode_barcodelookup | BOOLEAN | true | Feature toggle for barcode lookup | |
| module_stock_sms | BOOLEAN | true | Feature toggle for stock SMS | |
| module_delivery | BOOLEAN | true | Feature toggle for delivery | |
| module_delivery_dhl | BOOLEAN | true | Feature toggle for DHL | |
| module_delivery_fedex | BOOLEAN | true | Feature toggle for FedEx | |
| module_delivery_ups | BOOLEAN | true | Feature toggle for UPS | |
| module_delivery_usps | BOOLEAN | true | Feature toggle for USPS | |
| module_delivery_bpost | BOOLEAN | true | Feature toggle for Bpost | |
| module_delivery_easypost | BOOLEAN | true | Feature toggle for Easypost | |
| module_delivery_sendcloud | BOOLEAN | true | Feature toggle for Sendcloud | |
| module_delivery_shiprocket | BOOLEAN | true | Feature toggle for Shiprocket | |
| module_delivery_starshipit | BOOLEAN | true | Feature toggle for Starshipit | |
| module_quality_control | BOOLEAN | true | Feature toggle for quality control | |
| module_quality_control_worksheet | BOOLEAN | true | Feature toggle for QC worksheets | |
| group_stock_multi_locations | BOOLEAN | true | Feature toggle for multi-locations | |
| group_stock_reception_report | BOOLEAN | true | Feature toggle for reception reports | |
| module_stock_dropshipping | BOOLEAN | true | Feature toggle for dropshipping | |
| module_stock_fleet | BOOLEAN | true | Feature toggle for fleet | |
| website_id | INTEGER | true | ID of the associated website | References `website`. |
| group_multi_website | BOOLEAN | true | Feature toggle for multi-website | |
| module_website_livechat | BOOLEAN | true | Feature toggle for livechat | |
| module_marketing_automation | BOOLEAN | true | Feature toggle for marketing automation | |
| pay_invoices_online | BOOLEAN | true | Flag for online invoice payment | |
| use_manufacturing_lead | BOOLEAN | true | Flag to use manufacturing lead time | |
| group_mrp_byproducts | BOOLEAN | true | Feature toggle for MRP byproducts | |
| module_mrp_mps | BOOLEAN | true | Feature toggle for MPS | |
| module_mrp_plm | BOOLEAN | true | Feature toggle for PLM | |
| module_mrp_subcontracting | BOOLEAN | true | Feature toggle for subcontracting | |
| group_mrp_routings | BOOLEAN | true | Feature toggle for MRP routings | |
| group_unlocked_by_default | BOOLEAN | true | Flag for default unlocked state | |
| group_mrp_reception_report | BOOLEAN | true | Feature toggle for MRP reception | |
| group_mrp_workorder_dependencies | BOOLEAN | true | Feature toggle for workorder deps | |
| default_purchase_method | VARCHAR | true | Default purchase method | |
| lock_confirmed_po | BOOLEAN | true | Flag to lock confirmed POs | |
| po_order_approval | BOOLEAN | true | Flag for PO approval requirement | |
| group_warning_purchase | BOOLEAN | true | Feature toggle for purchase warnings | |
| module_account_3way_match | BOOLEAN | true | Feature toggle for 3-way match | |
| module_purchase_requisition | BOOLEAN | true | Feature toggle for requisitions | |
| module_purchase_product_matrix | BOOLEAN | true | Feature toggle for product matrix | |
| use_po_lead | BOOLEAN | true | Flag to use PO lead time | |
| group_send_reminder | BOOLEAN | true | Feature toggle for reminders | |
| module_stock_landed_costs | BOOLEAN | true | Feature toggle for landed costs | |
| group_lot_on_invoice | BOOLEAN | true | Flag for lot on invoice | |
| group_stock_accounting_automatic | BOOLEAN | true | Feature toggle for auto-accounting | |
| pos_config_id | INTEGER | true | ID of the POS configuration | References `pos_config`. |
| pos_default_fiscal_position_id | INTEGER | true | Default fiscal position for POS | References `account_fiscal_position`. |
| pos_pricelist_id | INTEGER | true | Default pricelist for POS | References `product_pricelist`. |
| pos_tip_product_id | INTEGER | true | Product ID for