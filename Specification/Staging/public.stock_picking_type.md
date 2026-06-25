# stock_picking_type

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `stock_picking_type`, `create_uid`, `write_date`, `JSONB` for translatable fields) and the specific functional domain of warehouse operations are characteristic of the Odoo Inventory/Warehouse module.

## Functional process 
This table supports the "Inventory Management" and "Warehouse Operations" business processes. It defines the operational workflows for stock movements (e.g., Receipts, Internal Transfers, Deliveries), governing how items are moved between locations, whether backorders are permitted, and the automation of label printing and reporting during the picking process.

## Description
One row in this table represents a specific type of stock picking operation (e.g., "WH/Receipts" or "WH/Delivery Orders"). It acts as a configuration entity that dictates the behavior, default source/destination locations, and automation rules for warehouse movements. This is a raw landed copy of the Odoo configuration table, used to drive logic in downstream inventory reporting and orchestration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| color | INTEGER | true | UI color index | Used for grouping/visual identification in the Odoo UI. |
| sequence | INTEGER | true | Display order | Determines the sort order in lists. |
| sequence_id | INTEGER | true | Reference to sequence object | Links to a specific numbering sequence for picking names. |
| default_location_src_id | INTEGER | false | Default source location | Foreign key to stock.location. |
| default_location_dest_id | INTEGER | false | Default destination location | Foreign key to stock.location. |
| return_picking_type_id | INTEGER | true | Return operation type | Links to the picking type used for returns. |
| warehouse_id | INTEGER | true | Associated warehouse | Foreign key to stock.warehouse. |
| reservation_days_before | INTEGER | true | Reservation lead time | Days before scheduled date to reserve stock. |
| reservation_days_before_priority | INTEGER | true | Priority reservation lead time | Days before for high-priority items. |
| company_id | INTEGER | false | Owning company | Foreign key to res.company. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res.users. |
| sequence_code | VARCHAR | false | Sequence prefix/code | Used for generating document numbers. |
| code | VARCHAR | false | Internal operation code | e.g., 'incoming', 'outgoing', 'internal'. |
| reservation_method | VARCHAR | false | Stock reservation strategy | e.g., 'at_confirm', 'manual', 'by_date'. |
| product_label_format | VARCHAR | true | Product label template | Format identifier for printing. |
| lot_label_format | VARCHAR | true | Lot label template | Format identifier for printing. |
| package_label_to_print | VARCHAR | true | Package label template | Format identifier for printing. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning operations. |
| create_backorder | VARCHAR | false | Backorder policy | e.g., 'ask', 'always', 'never'. |
| move_type | VARCHAR | false | Grouping strategy | e.g., 'direct', 'one'. |
| name | JSONB | false | Operation type name | Multi-language name field. |
| picking_properties_definition | JSONB | true | Custom properties schema | JSON definition for dynamic fields. |
| show_entire_packs | BOOLEAN | true | Show full packs | UI toggle for pack visibility. |
| active | BOOLEAN | true | Soft-delete flag | If false, the operation type is archived. |
| use_create_lots | BOOLEAN | true | Allow lot creation | Flag for lot tracking. |
| use_existing_lots | BOOLEAN | true | Allow existing lots | Flag for lot tracking. |
| print_label | BOOLEAN | true | Print label enabled | Global toggle for printing. |
| show_operations | BOOLEAN | true | Show operations detail | UI toggle. |
| auto_show_reception_report | BOOLEAN | true | Auto-show report | UI toggle. |
| auto_print_delivery_slip | BOOLEAN | true | Auto-print delivery slip | Automation flag. |
| auto_print_return_slip | BOOLEAN | true | Auto-print return slip | Automation flag. |
| auto_print_product_labels | BOOLEAN | true | Auto-print product labels | Automation flag. |
| auto_print_lot_labels | BOOLEAN | true | Auto-print lot labels | Automation flag. |
| auto_print_reception_report | BOOLEAN | true | Auto-print reception report | Automation flag. |
| auto_print_reception_report_labels | BOOLEAN | true | Auto-print reception labels | Automation flag. |
| auto_print_packages | BOOLEAN | true | Auto-print packages | Automation flag. |
| auto_print_package_label | BOOLEAN | true | Auto-print package label | Automation flag. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| mrp_product_label_to_print | VARCHAR | true | MRP product label template | Manufacturing label config. |
| done_mrp_lot_label_to_print | VARCHAR | true | Done MRP lot label template | Manufacturing label config. |
| generated_mrp_lot_label_to_print | VARCHAR | true | Generated MRP lot label template | Manufacturing label config. |
| use_create_components_lots | BOOLEAN | true | Create component lots | Manufacturing flag. |
| auto_print_done_production_order | BOOLEAN | true | Auto-print production order | Manufacturing flag. |
| auto_print_done_mrp_product_labels | BOOLEAN | true | Auto-print MRP product labels | Manufacturing flag. |
| auto_print_done_mrp_lot | BOOLEAN | true | Auto-print MRP lot | Manufacturing flag. |
| auto_print_mrp_reception_report | BOOLEAN | true | Auto-print MRP reception report | Manufacturing flag. |
| auto_print_mrp_reception_report_labels | BOOLEAN | true | Auto-print MRP reception labels | Manufacturing flag. |
| auto_print_generated_mrp_lot | BOOLEAN | true | Auto-print generated MRP lot | Manufacturing flag. |
| analytic_costs | BOOLEAN | true | Enable analytic costs | Financial tracking flag. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `warehouse_id` → `stock_warehouse.id` (Links the operation type to a specific warehouse).
    - `company_id` → `res_company.id` (Links the record to the owning organization).
    - `default_location_src_id` → `stock_location.id` (Defines the default source for movements).
    - `default_location_dest_id` → `stock_location.id` (Defines the default destination for movements).
- **Natural keys (inferred):**
    - `code` (In Odoo, the `code` field combined with `warehouse_id` typically identifies the operation type uniquely).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is used for soft deletes. Always filter by `WHERE active = true` unless you specifically need historical/archived configurations.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **JSONB:** The `name` column is a `JSONB` object containing translations (e.g., `{"en_US": "Receipts", "fr_FR": "Réceptions"}`). Use `name->>'en_US'` to extract the English label.
- **PII:** This table contains configuration data and is generally low-risk for PII, though `create_uid` and `write_uid` link to user records which may contain sensitive identity information.