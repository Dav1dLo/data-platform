# ir_sequence

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_sequence` (Internal Reference sequence) is a core component of the Odoo framework used to manage automated numbering for business documents like invoices, purchase orders, and stock moves.

## Functional process 
This table supports the document numbering and sequence generation process across the ERP. It defines the rules for how unique identifiers are generated for various business entities, including the prefix/suffix formatting, padding, and the next available number in the sequence.

## Description
One row in this table represents a single sequence configuration rule used to generate unique, incrementing identifiers for business objects. It resides in the Staging layer as a raw landed copy of the Odoo system's sequence definitions, providing the metadata required to reconstruct or validate document numbering patterns.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `nextval` sequence. |
| number_next | INTEGER | false | The next number to be used in the sequence | Increments based on `number_increment`. |
| number_increment | INTEGER | false | The step size for the sequence | Usually 1. |
| padding | INTEGER | false | Number of digits to pad with zeros | e.g., padding 5 turns 12 into 00012. |
| company_id | INTEGER | true | Foreign key to the company | Links sequence to a specific organizational unit. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the sequence | Human-readable label. |
| code | VARCHAR | true | Internal code for the sequence | Used by application logic to call the sequence. |
| implementation | VARCHAR | false | Storage method for the sequence | e.g., 'standard' or 'no_gap'. |
| prefix | VARCHAR | true | String to prepend to the number | e.g., 'INV/'. |
| suffix | VARCHAR | true | String to append to the number | e.g., '/2023'. |
| active | BOOLEAN | true | Soft-delete flag | If false, the sequence is disabled. |
| use_date_range | BOOLEAN | true | Flag for date-based sequences | If true, sequence resets or changes by date. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit trail).
- **Natural keys (inferred):** 
    - `code` (The internal code is typically unique within the Odoo application context).

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` to retrieve only currently valid sequences.
- **Implementation:** The `implementation` column dictates how the sequence behaves; 'no_gap' sequences are strictly transactional and may impact performance if queried heavily.
- **Data Sensitivity:** This table contains no PII, but it defines the logic for document numbering which is critical for financial audit trails.