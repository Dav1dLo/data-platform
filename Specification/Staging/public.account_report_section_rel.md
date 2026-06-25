# account_report_section_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a relational mapping between report entities, but lacks specific vendor-identifying prefixes or naming conventions (e.g., `sf_`, `sap_`) to attribute it to a specific operational platform.

## Functional process 
This table supports a reporting or analytics configuration process, specifically managing the hierarchical or associative relationship between main reports and their constituent sections or sub-reports. It likely facilitates the construction of complex, multi-part report structures.

## Description
One row in this table represents a single association between a parent report and a child report or section. It serves as a junction table in the staging layer, providing a raw, normalized link between report entities to enable downstream assembly of report hierarchies.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| main_report_id | INTEGER | false | Identifier of the parent or primary report. | Foreign key reference to a parent report entity. |
| sub_report_id | INTEGER | false | Identifier of the child report or section. | Foreign key reference to a sub-report or section entity. |

## Keys

- **Primary key (inferred):** The combination of (`main_report_id`, `sub_report_id`) is the inferred composite primary key, as this is a standard junction table pattern.
- **Foreign keys (inferred):** 
    - `main_report_id` → `account_report.id` (guess: links to the primary report definition).
    - `sub_report_id` → `account_report.id` (guess: links to the child report or section definition).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between reports.
- There are no timestamps or audit columns; it is unclear when these associations were created or if they are subject to soft deletes.
- The table contains only integer identifiers; ensure referential integrity is checked against the parent `account_report` tables before joining.