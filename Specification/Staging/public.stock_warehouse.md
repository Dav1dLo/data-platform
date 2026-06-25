# stock_warehouse

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `create_uid`, `write_uid`, `partner_id`, and the specific pattern of linking warehouse operations to various `_type_id` and `_route_id` references.

## Functional process 
This table supports the Inventory and Warehouse Management business process. It defines the physical and logical structure of warehouses, including their internal routing logic (reception, delivery, and manufacturing steps), associated stock locations, and resupply strategies.

## Description
One row in this table represents a single warehouse entity within the organization. It acts as a configuration record that maps a warehouse to its specific operational workflows, such as cross-docking, manufacturing, and procurement routes. This is a raw landed copy from the Odoo staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_warehouse_id_seq` |
| company_id | INTEGER | false | Owning company ID | Links to company master data |
| partner_id | INTEGER | true | Associated partner/address ID | Often represents the warehouse location address |
| view_location_id | INTEGER | false | Root location for the warehouse | Logical container for all stock locations |
| lot_stock_id | INTEGER | false | Default stock location | Primary storage location for this warehouse |
| wh_input_stock_loc_id | INTEGER | true | Input location ID | Used for multi-step reception |
| wh_qc_stock_loc_id | INTEGER | true | Quality control location ID | Used for QC processes |
| wh_output_stock_loc_id | INTEGER | true | Output location ID | Used for multi-step delivery |
| wh_pack_stock_loc_id | INTEGER | true | Packing location ID | Used for packing operations |
| mto_pull_id | INTEGER | true | MTO rule ID | Make-to-order pull rule |
| pick_type_id | INTEGER | true | Picking operation type | Internal picking workflow |
| pack_type_id | INTEGER | true | Packing operation type | Packing workflow |
| out_type_id | INTEGER | true | Delivery operation type | Outbound workflow |
| in_type_id | INTEGER | true | Reception operation type | Inbound workflow |
| int_type_id | INTEGER | true | Internal transfer type | Internal movement workflow |
| qc_type_id | INTEGER | true | Quality control type | QC workflow |
| store_type_id | INTEGER | true | Store operation type | Store workflow |
| xdock_type_id | INTEGER | true | Cross-dock operation type | Cross-docking workflow |
| crossdock_route_id | INTEGER | true | Cross-dock route ID | Routing logic for cross-docking |
| reception_route_id | INTEGER | true | Reception route ID | Routing logic for incoming goods |
| delivery_route_id | INTEGER | true | Delivery route ID | Routing logic for outgoing goods |
| sequence | INTEGER | true | Display sequence | Used for UI ordering |
| create_uid | INTEGER | true | Creator user ID | Audit field |
| write_uid | INTEGER | true | Last updater user ID | Audit field |
| name | VARCHAR | false | Warehouse name | Descriptive label |
| code | VARCHAR(5) | false | Warehouse short code | Used for identification/prefixes |
| reception_steps | VARCHAR | false | Reception workflow steps | e.g., 'one_step', 'two_steps' |
| delivery_steps | VARCHAR | false | Delivery workflow steps | e.g., 'ship_only', 'pick_pack_ship' |
| active | BOOLEAN | true | Soft-delete flag | True if warehouse is active |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |
| manufacture_pull_id | INTEGER | true | Manufacturing pull rule ID | - |
| manufacture_mto_pull_id | INTEGER | true | MTO manufacturing pull rule ID | - |
| pbm_mto_pull_id | INTEGER | true | PBM MTO pull rule ID | - |
| sam_rule_id | INTEGER | true | SAM rule ID | - |
| manu_type_id | INTEGER | true | Manufacturing operation type | - |
| pbm_type_id | INTEGER | true | PBM operation type | - |
| sam_type_id | INTEGER | true | SAM operation type | - |
| pbm_route_id | INTEGER | true | PBM route ID | - |
| pbm_loc_id | INTEGER | true | PBM location ID | - |
| sam_loc_id | INTEGER | true | SAM location ID | - |
| manufacture_steps | VARCHAR | false | Manufacturing workflow steps | - |
| manufacture_to_resupply | BOOLEAN | true | Resupply via manufacturing | - |
| pos_type_id | INTEGER | true | POS operation type | - |
| buy_pull_id | INTEGER | true | Buy pull rule ID | - |
| buy_to_resupply | BOOLEAN | true | Resupply via purchase | - |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture)
    - `partner_id` → `res_partner.id` (Links to the address book)
- **Natural keys (inferred):**
    - `code` (Warehouse short codes are typically unique within an Odoo instance)

## Caveats for downstream consumers

- **Active status:** Always filter by `active = TRUE` unless you specifically need historical/deactivated warehouse configurations.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; rows are not physically removed from the table.
- **Complexity:** This table is highly denormalized for Odoo's internal routing logic; many `_id` columns are optional depending on the complexity of the warehouse configuration (e.g., single-step vs. multi-step).