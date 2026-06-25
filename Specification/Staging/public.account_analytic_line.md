# account_analytic_line

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `account_analytic_line` and the presence of columns like `partner_id`, `product_uom_id`, `journal_id`, and `move_line_id` are characteristic of Odoo's accounting and project management modules.

## Functional process 
This table supports the analytical accounting process, which tracks costs and revenues independently of the general ledger. It is used for project costing, time tracking, and expense allocation, linking operational activities (like sales order lines or journal entries) to specific analytical accounts for internal reporting and profitability analysis.

## Description
One row in this table represents a single analytical entry, which records a financial or operational movement against an analytical account. This is a raw landing copy of the Odoo `account.analytic.line` model, capturing the grain of individual cost or revenue allocations. It serves as the base for calculating project margins and departmental performance metrics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| account_id | INTEGER | true | Analytical account reference | Links to `account.analytic.account`. |
| product_uom_id | INTEGER | true | Unit of measure ID | Reference to `uom.uom`. |
| partner_id | INTEGER | true | Customer/Vendor reference | Links to `res.partner`. |
| user_id | INTEGER | true | Responsible user ID | Links to `res.users`. |
| company_id | INTEGER | false | Company ID | Multi-company context. |
| currency_id | INTEGER | true | Currency ID | Reference to `res.currency`. |
| create_uid | INTEGER | true | Creator user ID | Audit trail. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail. |
| name | VARCHAR | false | Description of the entry | Human-readable label. |
| category | VARCHAR | true | Category classification | Custom or module-specific grouping. |
| date | DATE | false | Transaction date | Business date of the entry. |
| amount | NUMERIC | false | Monetary amount | Financial value in the account currency. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| unit_amount | DOUBLE PRECISION | true | Quantity/Units | Often used for hours or physical units. |
| x_plan2_id | INTEGER | true | Custom analytical plan 2 | Odoo Studio or custom field. |
| x_plan3_id | INTEGER | true | Custom analytical plan 3 | Odoo Studio or custom field. |
| product_id | INTEGER | true | Product reference | Links to `product.product`. |
| general_account_id | INTEGER | true | General ledger account | Links to `account.account`. |
| journal_id | INTEGER | true | Analytical journal ID | Links to `account.analytic.journal`. |
| move_line_id | INTEGER | true | GL move line reference | Links to `account.move.line`. |
| code | VARCHAR(8) | true | Short code | Optional reference code. |
| ref | VARCHAR | true | External reference | Free-text reference field. |
| so_line | INTEGER | true | Sales order line ID | Links to `sale.order.line`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account_analytic_account.id` (Standard Odoo analytical link)
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `product_id` → `product_product.id` (Standard Odoo product link)
    - `move_line_id` → `account_move_line.id` (Links to the source GL entry)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC by Odoo.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in the source Odoo system.
- **Precision:** `amount` is `NUMERIC` (high precision for currency), while `unit_amount` is `DOUBLE PRECISION` (potentially subject to floating-point rounding errors).
- **Custom Fields:** Columns prefixed with `x_` (e.g., `x_plan2_id`) are custom fields added via Odoo Studio and may not be populated consistently across all installations.