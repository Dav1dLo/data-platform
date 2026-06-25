# account_report_line

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized field names (`name`). The structure is typical of Odoo's financial reporting engine, which manages hierarchical report definitions.

## Functional process 
This table supports the financial reporting configuration process. It defines the structure, hierarchy, and display logic for custom financial reports (such as Balance Sheets or P&L statements) within the ERP, determining how data is grouped, sorted, and rendered for end-users.

## Description
One row represents a single line item or node within a financial report structure. It defines the hierarchical position, display properties, and grouping logic for that specific line. This is a raw landed staging table representing the configuration state of report lines as stored in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_report_line_id_seq` |
| report_id | INTEGER | false | Foreign key to the parent report | Links to the report definition |
| hierarchy_level | INTEGER | false | Depth of the line in the report tree | Used for indentation/nesting |
| parent_id | INTEGER | true | Self-referencing parent ID | Defines the tree structure |
| sequence | INTEGER | true | Display order index | Determines vertical position |
| action_id | INTEGER | true | Associated action or drill-down trigger | Links to specific system actions |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` |
| groupby | VARCHAR | true | System grouping key | Defines how data is aggregated |
| user_groupby | VARCHAR | true | User-defined grouping label | Custom label for grouping |
| code | VARCHAR | true | Internal code for the report line | Used for formula references |
| horizontal_split_side | VARCHAR | true | Layout side for split reports | e.g., 'left', 'right' |
| name | JSONB | false | Display name of the report line | Multilingual support via JSON |
| foldable | BOOLEAN | true | Whether the line can be collapsed | UI interaction flag |
| print_on_new_page | BOOLEAN | true | Page break trigger | Formatting flag |
| hide_if_zero | BOOLEAN | true | Visibility toggle for zero values | Conditional formatting |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_id` → `account_report.id` (Inferred from Odoo naming patterns for report line definitions).
    - `parent_id` → `account_report_line.id` (Self-referencing hierarchy).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB Handling:** The `name` column contains JSONB data; ensure you use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract specific language values.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Hierarchy:** Queries traversing the tree structure via `parent_id` will likely require a Recursive Common Table Expression (CTE).