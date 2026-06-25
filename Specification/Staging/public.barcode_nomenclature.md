# barcode_nomenclature

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of PostgreSQL sequences for primary keys, is characteristic of Odoo's ORM-based data structure.

## Functional process 
This table supports the inventory and warehouse management process, specifically the configuration of barcode scanning rules. It defines how the system interprets different barcode standards (such as UPC or EAN) and GS1 nomenclature, which is critical for automated stock movements and product identification.

## Description
One row in this table represents a specific barcode nomenclature configuration, defining the rules for how the system parses and validates scanned barcodes. It serves as a raw landed staging entity, capturing the settings used by the warehouse scanning module to map physical barcode strings to internal product identifiers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `barcode_nomenclature_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| name | VARCHAR | false | Descriptive name of the nomenclature | Human-readable label. |
| upc_ean_conv | VARCHAR | false | UPC/EAN conversion rule | Defines how to handle barcode format conversion. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| gs1_separator_fnc1 | VARCHAR | true | GS1 FNC1 separator character | Used for parsing GS1-128 barcodes. |
| is_gs1_nomenclature | BOOLEAN | true | GS1 compliance flag | Indicates if the nomenclature follows GS1 standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Likely references the user who created the configuration.
    - `write_uid` → `res_users.id`: Likely references the user who last updated the configuration.
- **Natural keys (inferred):** 
    - `name`: The unique name of the nomenclature is typically used as the business identifier in Odoo.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- This table does not implement soft deletes; records are typically updated in place or hard-deleted by the application.
- `create_uid` and `write_uid` may be null if the record was created via a system process or migration script rather than a user action.
- The `upc_ean_conv` column contains specific logic strings that may require mapping to a lookup table or documentation provided by the ERP's barcode module.