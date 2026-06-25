# hr_employee_skill_report

## Source system
This table likely originates from an internal Human Resources Information System (HRIS) or a Talent Management platform. The presence of granular identifiers such as `employee_id`, `department_id`, and `skill_type_id` suggests a structured relational database used to track workforce competencies and professional development.

## Functional process 
This table supports the human capital management and talent development process. It tracks the proficiency levels of employees across various skills, enabling HR departments to perform skills-gap analysis, identify training needs, and manage internal resource allocation based on competency levels.

## Description
Each row represents a single skill assessment or proficiency record for a specific employee within the organization. This is a staging-layer table, serving as a raw, landed copy of the source system's skill reporting data, intended for subsequent transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | BIGINT | true | Unique surrogate identifier for the record | Likely the primary key from the source system. |
| employee_id | INTEGER | true | Identifier for the employee | Links to the employee master record. |
| company_id | INTEGER | true | Identifier for the company or business unit | Used for multi-tenant or multi-entity filtering. |
| department_id | INTEGER | true | Identifier for the employee's department | Links to the organizational structure. |
| skill_id | INTEGER | true | Identifier for the specific skill | Links to the master skill catalog. |
| skill_type_id | INTEGER | true | Identifier for the category of the skill | Used to group skills (e.g., technical, soft skills). |
| level_progress | NUMERIC | true | Quantitative measure of progress | Likely a percentage or score (0.0 to 1.0 or 0 to 100). |
| skill_level | VARCHAR | true | Qualitative description of proficiency | e.g., "Beginner", "Intermediate", "Expert". |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `employees.id` (Guess: standard naming convention for employee linkage).
    - `department_id` → `departments.id` (Guess: standard naming convention for organizational hierarchy).
    - `skill_id` → `skills.id` (Guess: standard naming convention for skill catalog linkage).
- **Natural keys (inferred):** 
    - A combination of `employee_id` and `skill_id` likely represents the business-level uniqueness for a specific skill record.

## Caveats for downstream consumers

- The table contains `NULL` values across all columns; ensure your queries handle potential missing data (e.g., using `COALESCE` or `IS NOT NULL` filters).
- The `level_progress` column lacks a defined scale; verify if this is a percentage (0-100) or a normalized decimal (0-1) before performing aggregations.
- This is a staging table; it may contain duplicate records or unvalidated data that has not yet been cleaned by downstream transformation pipelines.
- No audit timestamps (e.g., `created_at`, `updated_at`) are present, making it difficult to determine the recency of the data without external metadata.