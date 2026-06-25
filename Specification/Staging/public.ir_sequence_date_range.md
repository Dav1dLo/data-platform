# ir_sequence_date_range

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_sequence_date_range` is characteristic of Odoo's internal registry (`ir`) modules, which manage document numbering sequences (e.g., invoice or purchase order numbers) that reset or increment based on specific date ranges.

## Functional process 
This table supports the document numbering and sequence management process. It defines the specific numeric ranges or starting points (`number_next`) that a sequence should follow within a defined temporal window (`date_from` to `date_to`), ensuring that business documents maintain sequential integrity across different fiscal or calendar periods.

## Description
One row in this table represents a specific date-bound configuration for a document sequence, defining the next available number to be assigned within that timeframe. As a staging table, it serves as a raw, direct copy of the Odoo database state, capturing the audit trail of who created or modified these sequence rules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| sequence_id | INTEGER | false | Foreign key to the parent sequence | Links to the main sequence definition. |
| number_next | INTEGER | false | The next number to be used | The value assigned to the next document. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| date_from | DATE | false | Start date of the range | Inclusive start of the validity period. |
| date_to | DATE | false | End date of the range | Inclusive end of the validity period. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sequence_id` → `ir_sequence.id`: This column identifies the parent sequence configuration that this date-range rule belongs to.
    - `create_uid` → `res_users.id`: Tracks the system user who initialized this rule.
    - `write_uid` → `res_users.id`: Tracks the system user who last updated this rule.
- **Natural keys (inferred):** 
    - `(sequence_id, date_from, date_to)`: The combination of the sequence reference and the specific date window uniquely identifies a rule for a given sequence.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user records; ensure these are handled according to internal access policies.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed via hard delete in the source system.
- **Data Integrity:** `number_next` is a critical operational value; ensure queries filtering by date ranges account for the inclusive nature of `date_from` and `date_to`.