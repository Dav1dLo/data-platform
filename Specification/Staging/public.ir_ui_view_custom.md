# ir_ui_view_custom

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_ui_view_custom` is a standard Odoo internal table pattern used to store user-defined customizations for UI views (Interface Registry).

## Functional process 
This table supports the UI customization and personalization process within the ERP. It stores overrides or custom XML definitions for views, allowing specific users to modify the layout or visibility of interface elements without altering the base system code.

## Description
One row in this table represents a single custom UI view definition associated with a specific user and a base view reference. It serves as a raw landed copy of the customization metadata, capturing the XML architecture (`arch`) and audit trails for view modifications within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_ui_view_custom_id_seq`. |
| ref_id | INTEGER | false | Reference to the base view | Links to the original view being customized. |
| user_id | INTEGER | false | Owner of the customization | The user who created or owns this specific view override. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initially created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| arch | TEXT | false | View architecture XML | The XML string defining the custom UI layout. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ref_id` → `ir_ui_view.id` (Guess: links to the base view definition).
    - `user_id` → `res_users.id` (Guess: links to the system user who owns the customization).
    - `create_uid` → `res_users.id` (Guess: links to the creator).
    - `write_uid` → `res_users.id` (Guess: links to the last modifier).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `arch` column contains XML data; ensure your downstream processing tools can handle large text blobs and XML parsing.
- Timestamps (`create_date`, `write_date`) are assumed to be in the system's configured timezone (typically UTC in Odoo).
- This table contains audit fields (`create_uid`, `write_uid`) which are critical for tracking who modified the UI.
- No explicit soft-delete flag is present; assume records are hard-deleted if removed from the source.