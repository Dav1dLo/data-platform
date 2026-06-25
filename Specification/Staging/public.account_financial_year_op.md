# account_financial_year_op

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the financial accounting module, specifically managing the definition and tracking of financial years for companies within the ERP. It acts as a configuration or metadata store that links specific financial periods to a `company_id`, ensuring that accounting entries are correctly scoped to the appropriate fiscal timeframe.

## Description
One row in this table represents a single financial year record associated with a specific company entity. As a staging table, it serves as a raw, landed copy of the operational data from the source system, intended for subsequent transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a database sequence for auto-increment. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization this financial year belongs to. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user management table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user management table. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company scoping).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Audit columns:** `create_uid` and `write_uid` may be null if the record was created via a system migration or an automated script rather than a user interface action.
- **Data Integrity:** As this is a staging table, it contains raw data; verify if the source system performs soft deletes (often indicated by an `active` boolean column, which is absent here) or hard deletes.
- **Sensitive Data:** While this table contains no PII, it is part of the financial configuration schema and should be handled according to internal data governance policies for financial metadata.