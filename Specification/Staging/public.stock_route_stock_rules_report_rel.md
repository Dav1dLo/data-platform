# stock_route_stock_rules_report_rel

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo to denote a many-to-many join table between two entities, in this case, linking stock rules reports to specific stock routes.

## Functional process 
This table supports the inventory management and logistics configuration process. It maintains the relational mapping between stock rules reports and the stock routes they encompass, allowing the system to track which routes are included in specific reporting cycles.

## Description
One row in this table represents a single association between a stock rules report and a stock route. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to generate inventory rule analysis reports.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_rules_report_id | INTEGER | false | Foreign key to the stock rules report | Links to the parent report entity. |
| stock_route_id | INTEGER | false | Foreign key to the stock route | Links to the specific route configuration. |

## Keys

- **Primary key (inferred):** The combination of `stock_rules_report_id` and `stock_route_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_rules_report_id` → `stock_rules_report.id` (Inferred from naming convention).
    - `stock_route_id` → `stock_route.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this with both the `stock_rules_report` and `stock_route` tables to retrieve meaningful business attributes.
- No audit timestamps (e.g., `created_at`) are present, so incremental loading based on ingestion time is not possible without metadata from the source system.
- The table contains no soft-delete flags; assume all rows represent active relationships unless otherwise specified by the source system's logic.