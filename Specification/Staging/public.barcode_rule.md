# barcode_rule

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of `barcode_nomenclature_id` are characteristic of Odoo's internal ORM structure for managing barcode scanning configurations.

## Functional process 
This table supports the barcode scanning and inventory management process. It defines the rules for interpreting scanned barcodes, mapping specific patterns to internal system actions, product identifiers, or units of measure (UoM) within the warehouse management module.

## Description
One row in this table represents a single barcode parsing rule that dictates how the system should interpret a scanned string based on its encoding and pattern. This is a raw landed staging table containing configuration data used to translate external barcode inputs into internal system entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `barcode_rule_id_seq`. |
| barcode_nomenclature_id | INTEGER | true | Foreign key to the parent nomenclature | Links the rule to a specific barcode configuration set. |
| sequence | INTEGER | true | Sort order for rule evaluation | Lower numbers are evaluated first. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| name | VARCHAR | false | Descriptive name of the rule | Human-readable label for the rule. |
| encoding | VARCHAR | false | Barcode symbology | e.g., EAN-13, UPC-A, Code 128. |
| type | VARCHAR | false | Rule type | Defines the action (e.g., product, weight, lot). |
| pattern | VARCHAR | false | Regex or pattern string | The logic used to match the scanned barcode. |
| alias | VARCHAR | false | Alias for the rule | Used for internal mapping. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| associated_uom_id | INTEGER | true | Foreign key to Unit of Measure | Links to `uom.uom` if the rule involves quantities. |
| gs1_content_type | VARCHAR | true | GS1 standard content type | Used for GS1-128 barcode parsing. |
| gs1_decimal_usage | BOOLEAN | true | Decimal usage flag | Indicates if the barcode contains decimal values. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `barcode_nomenclature_id` → `barcode_nomenclature.id` (Guess: links to the parent configuration group).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `associated_uom_id` → `uom_uom.id` (Guess: links to the unit of measure table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by the source system logic.
- **Data Integrity:** As a staging table, ensure that `barcode_nomenclature_id` and `associated_uom_id` are validated against their respective master tables before joining, as referential integrity may not be enforced at the database level in the staging layer.
- **Pattern Complexity:** The `pattern` column may contain complex regular expressions; ensure the downstream processing engine supports the specific regex dialect used by the Odoo application.