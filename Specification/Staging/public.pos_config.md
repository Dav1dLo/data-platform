# pos_config

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming conventions (e.g., `picking_type_id`, `journal_id`, `pos_config`), the presence of `module_pos_*` boolean flags, and the specific sequence generation pattern (`nextval('"public".pos_config_id_seq'::regclass)`) are characteristic of the Odoo framework.

## Functional process 
This table supports the configuration and operational setup of Point of Sale terminals. It defines how individual POS instances behave, including hardware integration (printers, scales, cash drawers), accounting integration (journals, fiscal positions), and feature enablement (restaurant mode, discount management, inventory routing).

## Description
One row represents a single Point of Sale configuration profile, which dictates the settings and capabilities for a specific POS terminal or shop. It acts as the central registry for terminal-specific business logic, such as whether a terminal allows manual discounts, uses specific pricelists, or requires a POSBox for hardware connectivity. This table serves as a raw landed copy of the Odoo `pos.config` model within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| picking_type_id | INTEGER | false | Inventory operation type ID | Links to stock picking configuration. |
| journal_id | INTEGER | true | Accounting journal ID | Default journal for POS transactions. |
| invoice_journal_id | INTEGER | true | Invoice journal ID | Journal used for generated invoices. |
| sequence_id | INTEGER | true | Sequence ID | Used for generating order references. |
| sequence_line_id | INTEGER | true | Sequence line ID | Internal sequence configuration. |
| pricelist_id | INTEGER | true | Default pricelist ID | The primary price list for this POS. |
| company_id | INTEGER | false | Company ID | Multi-company context identifier. |
| group_pos_manager_id | INTEGER | true | Manager group ID | Access control group for POS managers. |
| group_pos_user_id | INTEGER | true | User group ID | Access control group for POS users. |
| tip_product_id | INTEGER | true | Tip product ID | Product used to record tips. |
| default_fiscal_position_id | INTEGER | true | Fiscal position ID | Default tax/fiscal mapping. |
| rounding_method | INTEGER | true | Rounding method ID | Reference to cash rounding rules. |
| warehouse_id | INTEGER | true | Warehouse ID | Inventory source warehouse. |
| route_id | INTEGER | true | Route ID | Logistics route for POS orders. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this config. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified this. |
| access_token | VARCHAR | true | Security token | Used for external API/proxy access. |
| name | VARCHAR | false | Configuration name | Display name of the POS terminal. |
| iface_tax_included | VARCHAR | false | Tax display mode | Defines if prices include tax. |
| customer_display_type | VARCHAR | true | Customer display type | UI configuration for customer screens. |
| customer_display_bg_img_name | VARCHAR | true | Background image name | Filename for customer display UI. |
| proxy_ip | VARCHAR(45) | true | Proxy IP address | IP of the connected POSBox/IoT box. |
| uuid | VARCHAR | true | Unique identifier | Global unique identifier for the config. |
| picking_policy | VARCHAR | false | Picking policy | Strategy for stock movements. |
| receipt_header | TEXT | true | Receipt header text | Custom text printed at top of receipt. |
| receipt_footer | TEXT | true | Receipt footer text | Custom text printed at bottom of receipt. |
| is_order_printer | BOOLEAN | true | Order printer enabled | Flag for kitchen/order printing. |
| iface_cashdrawer | BOOLEAN | true | Cash drawer enabled | Hardware integration flag. |
| iface_electronic_scale | BOOLEAN | true | Scale enabled | Hardware integration flag. |
| iface_print_via_proxy | BOOLEAN | true | Print via proxy enabled | Hardware integration flag. |
| iface_scan_via_proxy | BOOLEAN | true | Scanner via proxy enabled | Hardware integration flag. |
| iface_big_scrollbars | BOOLEAN | true | UI setting | UI accessibility flag. |
| iface_print_auto | BOOLEAN | true | Auto-print enabled | Hardware integration flag. |
| iface_print_skip_screen | BOOLEAN | true | Skip print screen | UI workflow flag. |
| restrict_price_control | BOOLEAN | true | Price control restricted | Security flag for price overrides. |
| is_margins_costs_accessible_to_every_user | BOOLEAN | true | Margin visibility | Security flag for cost data. |
| set_maximum_difference | BOOLEAN | true | Max difference enabled | Cash control setting. |
| basic_receipt | BOOLEAN | true | Basic receipt mode | UI/Printing setting. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| iface_tipproduct | BOOLEAN | true | Tip product enabled | Feature flag. |
| use_pricelist | BOOLEAN | true | Pricelist enabled | Feature flag. |
| tax_regime_selection | BOOLEAN | true | Tax regime selection | Feature flag. |
| limit_categories | BOOLEAN | true | Limit categories | UI/Product filtering flag. |
| module_pos_restaurant | BOOLEAN | true | Restaurant module enabled | Feature flag. |
| module_pos_avatax | BOOLEAN | true | Avatax module enabled | Feature flag. |
| module_pos_discount | BOOLEAN | true | Discount module enabled | Feature flag. |
| is_posbox | BOOLEAN | true | POSBox enabled | Hardware integration flag. |
| is_header_or_footer | BOOLEAN | true | Header/Footer enabled | UI/Printing flag. |
| module_pos_hr | BOOLEAN | true | HR module enabled | Feature flag. |
| other_devices | BOOLEAN | true | Other devices enabled | Hardware integration flag. |
| cash_rounding | BOOLEAN | true | Cash rounding enabled | Accounting setting. |
| only_round_cash_method | BOOLEAN | true | Rounding method restriction | Accounting setting. |
| manual_discount | BOOLEAN | true | Manual discount enabled | Feature flag. |
| ship_later | BOOLEAN | true | Ship later enabled | Logistics feature flag. |
| auto_validate_terminal_payment | BOOLEAN | true | Auto-validate payment | Workflow flag. |
| show_product_images | BOOLEAN | true | Show product images | UI setting. |
| show_category_images | BOOLEAN | true | Show category images | UI setting. |
| module_pos_sms | BOOLEAN | true | SMS module enabled | Feature flag. |
| is_closing_entry_by_product | BOOLEAN | true | Closing entry by product | Accounting setting. |
| order_edit_tracking | BOOLEAN | true | Order edit tracking | Audit flag. |
| orderlines_sequence_in_cart_by_category | BOOLEAN | true | Order line sorting | UI setting. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |
| amount_authorized_diff | DOUBLE PRECISION | true | Authorized difference | Cash control limit. |
| epson_printer_ip | VARCHAR | true | Epson printer IP | Hardware integration. |
| sms_receipt_template_id | INTEGER | true | SMS template ID | Configuration for SMS receipts. |
| crm_team_id | INTEGER | true | CRM team ID | Links POS to a CRM sales team. |
| down_payment_product_id | INTEGER | true | Down payment product ID | Product used for down payments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
    - `picking_type_id` → `stock_picking_type.id` (Links to inventory operation types).
    - `journal_id` → `account_journal.id` (Links to accounting journals).
- **Natural keys (inferred):** 
    - `uuid` (Odoo-generated unique identifier for the configuration).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical configuration analysis is required.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Sensitive Data:** `access_token` and `proxy_ip` should be handled with care as they relate to system security and network infrastructure.
- **Boolean Defaults:** Many boolean columns default to `FALSE` in the application layer; ensure nulls are handled appropriately in logic (e.g., `COALESCE(column, FALSE)`).