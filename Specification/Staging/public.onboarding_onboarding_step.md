# onboarding_onboarding_step

## Source system
The table originates from an Odoo ERP environment, evidenced by the naming convention `onboarding_onboarding_step`, the use of `create_uid`/`write_uid` audit columns, and the reliance on `JSONB` fields for localized content, which is characteristic of Odoo's multi-language support.

## Functional process 
This table supports the "User Onboarding" business process, specifically managing the configuration and display of guided setup steps within the application interface. It defines the sequence, visual assets, and localized text for interactive onboarding panels presented to users.

## Description
One row in this table represents a single step within an onboarding workflow, including its display order, associated imagery, and localized text content. As a staging table, it serves as a raw, direct reflection of the source ERP configuration data, intended for downstream transformation into a more consumable format.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `onboarding_onboarding_step_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order in which the step appears. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this step. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this step. |
| done_icon | VARCHAR | true | Icon identifier | Name or path of the icon displayed upon completion. |
| step_image_filename | VARCHAR | true | Image file name | Filename of the asset associated with the step. |
| panel_step_open_action_name | VARCHAR | true | Action trigger | The internal name of the action to execute when the step is opened. |
| title | JSONB | true | Localized title | Multi-language title content. |
| description | JSONB | true | Localized description | Multi-language description content. |
| button_text | JSONB | false | Localized button label | Multi-language text for the step's primary button. |
| done_text | JSONB | true | Localized completion text | Multi-language text shown when the step is finished. |
| step_image_alt | JSONB | true | Localized alt text | Multi-language alternative text for the step image. |
| is_per_company | BOOLEAN | true | Company-specific flag | Indicates if the step configuration is scoped per company. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Content:** Fields like `title`, `description`, and `button_text` contain `JSONB` data, likely structured as `{"en_US": "...", "fr_FR": "..."}`. You will need to use the `->>` operator to extract specific language values.
- **Timestamps:** Timestamps are stored in the database's local time; verify if the Odoo instance is configured for UTC (standard practice).
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs; they do not contain PII directly but link to the user directory.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all rows are currently active unless otherwise specified by the source system logic.