# rule_group_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a relational mapping or join table, but the column names lack specific prefixes or suffixes that would link them to a known ERP, CRM, or SaaS platform.

## Functional process 
This table supports a many-to-many relationship management process, likely used to associate rules with specific groups or categories. It functions as a bridge table to resolve complex rule-set hierarchies or organizational tagging structures.

## Description
One row in this table represents a single association between a rule group and a parent group. It serves as a raw landed copy of a junction table, intended to facilitate relational joins between rule definitions and their respective group containers in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| rule_group_id | INTEGER | false | Identifier for the rule group entity | Likely a foreign key to a rule_group table |
| group_id | INTEGER | false | Identifier for the parent or associated group | Likely a foreign key to a groups table |

## Keys

- **Primary key (inferred):** Not confidently inferable. While this is a junction table, the provided metadata does not explicitly define a composite primary key. It is likely a composite key of `(rule_group_id, group_id)`.
- **Foreign keys (inferred):** 
    - `rule_group_id → rule_group.id` (guess: standard naming convention for junction tables).
    - `group_id → groups.id` (guess: standard naming convention for junction tables).
- **Natural keys (inferred):** 
    - The combination of `(rule_group_id, group_id)` is the business key representing the unique relationship between these two entities.

## Caveats for downstream consumers

- This table is a junction table; ensure you use `INNER JOIN` or `LEFT JOIN` carefully to avoid fan-outs when aggregating metrics from related tables.
- No audit or timestamp columns are present, so incremental loading logic cannot be based on record modification times.
- There are no soft-delete flags; assume this table represents the current state of relationships as captured during the last ingestion.