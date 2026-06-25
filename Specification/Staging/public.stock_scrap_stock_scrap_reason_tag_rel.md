# stock_scrap_stock_scrap_reason_tag_rel

## Source system
The table likely originates from an Odoo or similar ERP system, as indicated by the `_rel` suffix and the naming convention of linking a primary entity (`stock_scrap`) to a classification or tag entity (`stock_scrap_reason_tag`).

## Functional process 
This table supports the inventory management and quality control process by facilitating a many-to-many relationship between stock scrap records and the specific reasons or tags associated with those scrap events. It allows a single scrap transaction to be categorized by multiple descriptive tags.

## Description
One row in this table represents a single association between a specific stock scrap event and a reason tag. It serves as a junction table in the staging layer, providing a raw, normalized link between scrap transactions and their descriptive metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_scrap_id | INTEGER | false | Foreign key to the stock scrap record | Represents the specific inventory scrap event. |
| stock_scrap_reason_tag_id | INTEGER | false | Foreign key to the scrap reason tag definition | Represents the category or reason assigned to the scrap. |

## Keys

- **Primary key (inferred):** The composite of (`stock_scrap_id`, `stock_scrap_reason_tag_id`).
- **Foreign keys (inferred):** 
    - `stock_scrap_id` → `stock_scrap.id`: Links to the parent scrap transaction.
    - `stock_scrap_reason_tag_id` → `stock_scrap_reason_tag.id`: Links to the definition of the scrap reason.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both the `stock_scrap` and `stock_scrap_reason_tag` tables to produce meaningful business reports.
- There are no timestamps or audit columns present; this table reflects the current state of associations as captured during the last ingestion.
- The table does not contain its own surrogate primary key, so downstream models should treat the combination of both columns as the unique identifier.