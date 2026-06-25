# product_template

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming conventions (e.g., `categ_id`, `uom_id`, `write_uid`, `create_date`), the use of `JSONB` for multi-language fields, and the specific pattern of `property_account_*` columns are characteristic of the Odoo ORM layer.

## Functional process 
This table supports the Product Lifecycle Management and Inventory Master Data process. It acts as the central repository for product definitions, including pricing, purchasing rules, sales policies, and accounting configurations, which are subsequently used across the sales, procurement, and warehouse management modules.

## Description
One row in this table represents a single product template, which defines the core attributes and configurations shared by all variants of a product. It serves as a raw landed copy from the Odoo database, capturing the master definition of items available for sale, purchase, or internal inventory management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| categ_id | INTEGER | false | Product category ID | Foreign key to product category. |
| uom_id | INTEGER | false | Unit of measure ID | Default unit of measure. |
| uom_po_id | INTEGER | false | Purchase unit of measure ID | Unit used for purchasing. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| color | INTEGER | true | UI color index | Used for Kanban/UI display. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit: user who last updated the record. |
| type | VARCHAR | false | Product type | e.g., 'consu', 'service', 'product'. |
| service_tracking | VARCHAR | false | Service tracking policy | Defines how services are tracked. |
| default_code | VARCHAR | true | Internal reference | SKU or vendor code. |
| name | JSONB | false | Product name | Multi-language support. |
| description | JSONB | true | Internal description | Multi-language support. |
| description_purchase | JSONB | true | Purchase description | Multi-language support. |
| description_sale | JSONB | true | Sales description | Multi-language support. |
| product_properties | JSONB | true | Custom properties | Dynamic attributes. |
| list_price | NUMERIC | true | Sales price | Base price for customers. |
| volume | NUMERIC | true | Volume | Physical dimension. |
| weight | NUMERIC | true | Weight | Physical dimension. |
| sale_ok | BOOLEAN | true | Can be sold | Flag for sales availability. |
| purchase_ok | BOOLEAN | true | Can be purchased | Flag for procurement availability. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| can_image_1024_be_zoomed | BOOLEAN | true | Image zoom flag | UI configuration. |
| has_configurable_attributes | BOOLEAN | true | Configurable flag | Indicates product variants. |
| is_favorite | BOOLEAN | true | Favorite flag | User-specific UI preference. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| property_account_income_id | JSONB | true | Income account | Accounting configuration. |
| property_account_expense_id | JSONB | true | Expense account | Accounting configuration. |
| sale_delay | INTEGER | true | Sales lead time | Days to deliver. |
| tracking | VARCHAR | false | Tracking method | e.g., 'none', 'serial', 'lot'. |
| responsible_id | JSONB | true | Responsible user | Owner of the product record. |
| property_stock_production | JSONB | true | Production location | Inventory location mapping. |
| property_stock_inventory | JSONB | true | Inventory location | Inventory location mapping. |
| description_picking | JSONB | true | Picking description | Warehouse instructions. |
| description_pickingout | JSONB | true | Outbound picking description | Warehouse instructions. |
| description_pickingin | JSONB | true | Inbound picking description | Warehouse instructions. |
| is_storable | BOOLEAN | true | Is storable | Indicates stockable product. |
| purchase_method | VARCHAR | true | Purchase method | e.g., 'purchase', 'receive'. |
| purchase_line_warn | VARCHAR | false | Purchase warning type | Warning policy. |
| purchase_line_warn_msg | TEXT | true | Purchase warning message | Warning text. |
| lot_valuated | BOOLEAN | true | Lot valuation flag | Inventory valuation setting. |
| public_description | JSONB | true | Public description | Website/E-commerce display. |
| available_in_pos | BOOLEAN | true | Available in POS | Point of Sale availability. |
| to_weight | BOOLEAN | true | Weighing flag | Used for scale integration. |
| property_account_creditor_price_difference | JSONB | true | Price diff account | Accounting configuration. |
| service_type | VARCHAR | true | Service type | e.g., 'manual', 'timesheet'. |
| sale_line_warn | VARCHAR | false | Sales warning type | Warning policy. |
| expense_policy | VARCHAR | true | Expense policy | Re-invoicing policy. |
| invoice_policy | VARCHAR | true | Invoice policy | e.g., 'order', 'delivery'. |
| sale_line_warn_msg | TEXT | true | Sales warning message | Warning text. |
| service_to_purchase | JSONB | true | Service purchase link | Linking service to PO. |
| project_id | JSONB | true | Project ID | Linked project. |
| project_template_id | JSONB | true | Project template ID | Linked project template. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `categ_id` → `product_category.id` (Likely target based on naming convention).
    - `uom_id` → `uom_uom.id` (Likely target for unit of measure).
- **Natural keys (inferred):** 
    - `default_code` (Often used as the business-level SKU).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is used for soft deletes. Ensure queries filter by `WHERE active = TRUE` unless historical data is required.
- **JSONB Fields:** Many fields (e.g., `name`, `description`) are `JSONB`. These often contain multi-language dictionaries (e.g., `{"en_US": "Product Name", "fr_FR": "Nom du produit"}`). You may need to extract specific keys using `name->>'en_US'`.
- **Timestamps:** Timestamps are assumed to be in UTC.
- **Sensitive Data:** No direct PII, but `product_properties` and `description` fields may contain internal business notes or vendor-specific information.