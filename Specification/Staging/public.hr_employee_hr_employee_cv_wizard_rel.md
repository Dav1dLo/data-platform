# hr_employee_hr_employee_cv_wizard_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `hr_employee_hr_employee_cv_wizard_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link core HR modules with temporary wizard-based reporting or document generation tools.

## Functional process 
This table supports the HR document generation process, specifically the "CV Wizard" functionality. It acts as a join table to associate specific employee records with temporary wizard sessions used to compile or export employee curriculum vitae (CV) data.

## Description
One row in this table represents a single association between an employee record and a CV wizard session. It is a raw landing table in the staging layer, serving as a bridge to resolve many-to-many relationships between the `hr_employee` entity and the `hr_employee_cv_wizard` process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| hr_employee_cv_wizard_id | INTEGER | false | Foreign key to the CV wizard session | Links to the wizard instance. |
| hr_employee_id | INTEGER | false | Foreign key to the employee record | Links to the specific employee. |

## Keys

- **Primary key (inferred):** The combination of `(hr_employee_cv_wizard_id, hr_employee_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `hr_employee_cv_wizard_id` → `hr_employee_cv_wizard.id` (Guessed based on Odoo naming patterns).
    - `hr_employee_id` → `hr_employee.id` (Guessed based on Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a technical join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the age of these associations without joining to the parent wizard table.
- Expect high churn in this table as wizard sessions are typically transient and likely purged by the source system after the document generation process completes.