# stock_valuation_layer_revaluation

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM, and the `account_journal_id` pattern typical of Odoo's accounting module.

## Functional process 
This table supports the inventory valuation and accounting reconciliation process. It tracks revaluation adjustments for stock valuation layers, linking specific inventory movements or product lots to accounting journals and ledger accounts to ensure that the financial value of stock reflects current market or cost adjustments.

## Description
One row in this table represents a single revaluation event applied to a stock valuation layer for a specific product and company. It serves as a staging record capturing the financial impact (`added_value`) and the justification (`reason`) for adjusting inventory values within the accounting system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_valuation_layer_revaluation_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity owning the stock. |
| product_id | INTEGER | false | Foreign key to the product | Identifies the item being revalued. |
| lot_id | INTEGER | true | Foreign key to the inventory lot | Specific batch or serial number reference. |
| account_journal_id | INTEGER | true | Foreign key to the accounting journal | The journal where the revaluation entry is recorded. |
| account_id | INTEGER | true | Foreign key to the general ledger account | The specific GL account impacted by the revaluation. |
| create_uid | INTEGER | true | User ID of creator | References the user who initiated the revaluation. |
| write_uid | INTEGER | true | User ID of last modifier | References the user who last updated the record. |
| reason | VARCHAR | true | Description of the revaluation | Textual justification for the financial adjustment. |
| date | DATE | true | Effective date | The business date the revaluation is applied. |
| added_value | NUMERIC | false | Adjustment amount | The monetary value added (or subtracted if negative) to the stock. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `product_id` → `product_product.id` (Standard Odoo product reference).
    - `account_journal_id` → `account_journal.id` (Standard Odoo accounting link).
    - `account_id` → `account_account.id` (Standard Odoo chart of accounts link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Data Integrity:** `added_value` is a `NUMERIC` type; ensure proper precision handling when aggregating these values in financial reports.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; assume this table contains the current state of revaluation records as landed from the source.
- **Nullability:** Several foreign keys (`lot_id`, `account_id`) are nullable, implying that some revaluations may be global or not yet fully reconciled to a specific ledger account.