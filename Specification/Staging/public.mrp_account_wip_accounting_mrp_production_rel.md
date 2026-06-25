# mrp_account_wip_accounting_mrp_production_rel

## Source system
This table likely originates from an Odoo ERP system, as indicated by the naming convention `mrp_account_wip_accounting_mrp_production_rel`, which follows the standard pattern for many-to-many relationship tables (often suffixed with `_rel`) in Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing accounting process, specifically linking Work-in-Progress (WIP) accounting entries to specific manufacturing production orders. It facilitates the reconciliation of production costs against accounting records in the manufacturing-to-finance pipeline.

## Description
One row in this table represents a single association between a WIP accounting record and a production order. It acts as a join table in the staging layer, preserving the raw many-to-many relationship between manufacturing production entities and their corresponding financial accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_account_wip_accounting_id | INTEGER | false | Foreign key to the WIP accounting record | Links to the primary accounting entity. |
| mrp_production_id | INTEGER | false | Foreign key to the production order | Links to the manufacturing production entity. |

## Keys

- **Primary key (inferred):** The combination of `mrp_account_wip_accounting_id` and `mrp_production_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_account_wip_accounting_id` → `mrp_account_wip_accounting.id`: This column references the parent accounting record.
    - `mrp_production_id` → `mrp_production.id`: This column references the parent production order record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with the parent `mrp_account_wip_accounting` and `mrp_production` tables to retrieve meaningful business attributes.
- No timestamps or soft-delete flags are present; this table represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins are performed on both columns to maintain the integrity of the relationship mapping.