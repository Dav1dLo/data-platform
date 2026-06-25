# pos_config_printer_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (join tables) between two entities, in this case, point-of-sale configurations and printer devices.

## Functional process 
This table supports the Point of Sale (POS) hardware configuration process. It maps specific receipt or kitchen printers to POS configurations, ensuring that when a transaction is processed at a specific terminal, the system knows which physical hardware devices are authorized to print the associated documentation.

## Description
One row in this table represents a single association between a POS configuration and a printer. It is a raw, landing-layer join table used to resolve the many-to-many relationship between POS settings and hardware peripherals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| config_id | INTEGER | false | Foreign key to the POS configuration | Represents the parent POS setup. |
| printer_id | INTEGER | false | Foreign key to the printer definition | Represents the specific hardware device. |

## Keys

- **Primary key (inferred):** The composite key `(config_id, printer_id)`.
- **Foreign keys (inferred):** 
    - `config_id` → `pos_config.id`: This column references the primary configuration entity for the POS system.
    - `printer_id` → `pos_printer.id`: This column references the master list of configured printers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- Expect no timestamps or soft-delete flags; relationships are typically created or destroyed directly in the source system.
- Ensure referential integrity checks are performed against the parent `pos_config` and `pos_printer` tables before joining, as orphaned records may exist in raw staging data.