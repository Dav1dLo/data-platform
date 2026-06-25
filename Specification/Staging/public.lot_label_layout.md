# lot_label_layout

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a `nextval` sequence on the `id` column, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory and warehouse management process, specifically the configuration of label printing for stock lots or serial numbers. It stores the layout preferences and quantity settings used when generating physical labels for inventory items.

## Description
One row in this table represents a specific configuration profile or layout setting for printing labels associated with inventory lots. This is a raw landing table in the staging layer, capturing the current state of label layout definitions as they exist in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate identifier for the layout record | Primary key; managed by `lot_label_layout_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system's user table. |
| label_quantity | VARCHAR | false | Number of labels to print per lot | Stored as VARCHAR; may require casting to numeric for calculations. |
| print_format | VARCHAR | false | The template or format code for the label | Defines the visual layout of the printed label. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Types:** `label_quantity` is stored as a `VARCHAR` despite representing a count; ensure explicit casting to `INTEGER` or `NUMERIC` in downstream transformations.
- **Timestamps:** All date fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows represent currently tracked configurations unless otherwise specified by the source system's business logic.
- **PII:** No sensitive PII is present in this table, though `create_uid` and `write_uid` link to internal user identities.