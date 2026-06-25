# web_tour_tour

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`web_tour_tour_id_seq`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific column `rainbow_man_message` which is a known feature in Odoo's user interface tour framework.

## Functional process 
This table supports the "User Onboarding and Training" process. It stores definitions for interactive product tours that guide users through the application interface, tracking the sequence of steps, the target URLs, and custom configuration messages displayed upon tour completion.

## Description
One row in this table represents a single interactive product tour definition. It serves as a raw landed copy of the tour configuration metadata, capturing the tour's name, its associated URL, and whether it is a custom-defined tour.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `web_tour_tour_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order in which tours appear. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| name | VARCHAR | false | Tour name | Human-readable identifier for the tour. |
| url | VARCHAR | true | Target URL | The relative path where the tour is active. |
| rainbow_man_message | JSONB | true | Completion message | JSON payload for the "Rainbow Man" success animation. |
| custom | BOOLEAN | true | Custom flag | Indicates if the tour is a user-defined customization. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unknown. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unknown. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `name` (Assuming tour names are unique within the application context).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the source system's local time; verify if the Odoo instance is configured for UTC.
- **JSONB:** The `rainbow_man_message` column contains semi-structured data; ensure your downstream processing handles JSONB parsing correctly.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system logic.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs and may not map to your enterprise-wide identity management system without a lookup table.