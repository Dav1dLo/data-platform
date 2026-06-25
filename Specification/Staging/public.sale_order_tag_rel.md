# sale_order_tag_rel

## Source system
The table likely originates from an Odoo or similar ERP system, as the naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables between two entities.

## Functional process 
This table supports the categorization and tagging process within the sales module. It facilitates the many-to-many relationship between sales orders and custom tags, allowing users to label or group orders for reporting, filtering, or workflow automation.

## Description
One row in this table represents a single association between a specific sales order and a specific tag. It serves as a bridge table in the staging layer, providing a raw, normalized link between the `sale_order` and `tag` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| order_id | INTEGER | false | Foreign key to the sales order | Links to the primary sales order entity. |
| tag_id | INTEGER | false | Foreign key to the tag definition | Links to the master list of available tags. |

## Keys

- **Primary key (inferred):** The composite key `(order_id, tag_id)` is the inferred primary key, as it represents the unique intersection of the relationship.
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id`: This column references the unique identifier of a sales order.
    - `tag_id` → `tag.id`: This column references the unique identifier of a tag definition.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes other than the relationship itself.
- There are no timestamps or audit columns present, so it is impossible to determine when an association was created or removed based on this table alone.
- Ensure that joins to this table are filtered by both columns to avoid Cartesian products if the relationship is not strictly enforced at the database level.