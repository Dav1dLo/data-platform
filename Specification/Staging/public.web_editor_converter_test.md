# web_editor_converter_test

## Source system
The table appears to originate from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific column types (e.g., `many2one`, `binary` as `BYTEA`) are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports internal testing or validation of data type conversion logic within the Odoo web editor framework. It serves as a sandbox or utility table to ensure that various data types—ranging from simple integers and strings to complex HTML and binary blobs—are correctly persisted and retrieved through the application's interface.

## Description
One row in this table represents a single test record containing a variety of data types used to verify the integrity of the web editor's data conversion processes. It exists in the Staging layer as a raw, landed copy of the Odoo application's internal test entity, intended for verifying data mapping and schema compatibility.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `web_editor_converter_test_id_seq`. |
| integer | INTEGER | true | Integer test value | - |
| many2one | INTEGER | true | Foreign key reference | Likely points to another Odoo model. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| char | VARCHAR | true | Character test string | - |
| selection_str | VARCHAR | true | Selection field value | Represents a choice from a predefined list. |
| date | DATE | true | Date test value | - |
| html | TEXT | true | HTML content | Stores formatted text or markup. |
| text | TEXT | true | Long-form text | - |
| numeric | NUMERIC | true | Precise decimal value | - |
| datetime | TIMESTAMP | true | Datetime test value | - |
| create_date | TIMESTAMP | true | Record creation timestamp | - |
| write_date | TIMESTAMP | true | Record modification timestamp | - |
| float | DOUBLE PRECISION | true | Floating point test value | - |
| binary | BYTEA | true | Binary data | Stores raw binary/blob data. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `many2one` → `unknown_target_table.id`: Likely a reference to a parent record in another Odoo model.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creation.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `binary` column contains raw byte data (`BYTEA`); ensure your downstream tools can handle binary streams if you intend to extract this data.
- Timestamps (`create_date`, `write_date`, `datetime`) are typically stored in UTC in Odoo environments, but verify against application settings.
- This table is likely a technical test artifact; data may be volatile, incomplete, or subject to frequent truncation depending on the testing cycle.
- No explicit soft-delete flag (e.g., `active`) is present, suggesting that records are either hard-deleted or this table does not implement standard Odoo archival patterns.