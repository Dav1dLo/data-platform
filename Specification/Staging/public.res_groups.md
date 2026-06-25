# res_groups

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups` (a core Odoo model for security groups/access rights), the use of `JSONB` for multi-language fields (`name`, `comment`), and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are definitive indicators of an Odoo backend.

## Functional process 
This table supports the Identity and Access Management (IAM) process within the ERP. It defines the security groups that govern user permissions, access rights, and functional visibility across the platform. The `category_id` links these groups to specific application modules or functional areas, while `share` likely distinguishes between internal users and external portal users.

## Description
One row in this table represents a single security group or access role defined within the system. This is a raw landed copy of the Odoo `res.groups` model, capturing the configuration and metadata for user access control. It serves as the staging entity for downstream security and user-permission reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_groups_id_seq`. |
| name | JSONB | false | Display name of the group | Multi-language JSON object. |
| category_id | INTEGER | true | Foreign key to group category | Links to `res_groups_category`. |
| color | INTEGER | true | UI color index | Used for visual grouping in the UI. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| comment | JSONB | true | Description of the group | Multi-language JSON object. |
| share | BOOLEAN | true | Portal user flag | True if group is for external/portal users. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| api_key_duration | DOUBLE PRECISION | true | API key validity period | Duration in days or hours. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `category_id` → `res_groups_category.id`: This column references the category grouping for security roles.
    - `create_uid` → `res_users.id`: Standard Odoo audit trail for record creation.
    - `write_uid` → `res_users.id`: Standard Odoo audit trail for record modification.
- **Natural keys (inferred):** Not confidently inferable. While `name` is often unique, Odoo allows localized names in `JSONB` which may not be globally unique across all languages.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` and `comment` fields are `JSONB` and may contain internal system naming conventions; ensure these are handled correctly in downstream transformations.
- **Timestamps:** `create_date` and `write_date` are stored in the system's native timezone (typically UTC in Odoo).
- **Data Structure:** The `name` and `comment` columns are `JSONB` objects; you will need to use PostgreSQL `->>` operators to extract specific language strings (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless filtered by specific business logic.