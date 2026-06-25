# web_editor_converter_test_sub

## Source system
The table likely originates from an Odoo ERP instance, as evidenced by the naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports a testing or configuration utility process, likely related to a web editor or data conversion module within the application. The presence of `create_uid` and `write_uid` suggests it tracks administrative changes or audit trails for specific test sub-entities.

## Description
One row in this table represents a single test sub-entity record within the web editor converter module. It serves as a raw landed copy of the source system's data, maintaining the audit trail of record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate identifier | Primary key; managed by sequence. |
| create_uid | INTEGER | true | User ID who created the record | References a user in the system. |
| write_uid | INTEGER | true | User ID who last modified the record | References a user in the system. |
| name | VARCHAR | true | Name or label of the test sub-entity | Descriptive identifier. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess based on standard Odoo naming patterns).
    - `write_uid` → `res_users.id` (guess based on standard Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- This table does not appear to implement soft-delete flags (e.g., `active`), so assume all rows are current unless otherwise specified by the source system logic.
- The `id` column is generated via a sequence; do not rely on it for business logic ordering, only for relational integrity.