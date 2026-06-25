# crm_tag

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for the `name` field (often used in Odoo for multi-language support), is characteristic of the Odoo framework's internal object relational mapping.

## Functional process 
This table supports the Customer Relationship Management (CRM) module by managing metadata tags used to categorize or label CRM entities such as leads, opportunities, or customers. These tags allow business users to segment their sales pipeline and customer base for reporting and workflow automation.

## Description
One row in this table represents a single CRM tag definition available for assignment within the system. It serves as a raw landing copy of the tag configuration, capturing the tag's display name, associated color, and audit metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_tag_id_seq`. |
| color | INTEGER | true | UI color index | Represents the color code used in the CRM interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the tag. |
| name | JSONB | false | Tag display name | Likely contains localized strings (e.g., `{"en_US": "Hot Lead"}`). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; queries will require extraction (e.g., `name->>'en_US'`) to access specific language values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag; assume all rows are active unless otherwise specified by business logic.
- The `color` column is an integer index; it does not contain hex codes directly and requires a lookup against the Odoo UI configuration to interpret.