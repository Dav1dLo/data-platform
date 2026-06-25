# hr_departure_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`hr_departure_wizard_id_seq`), the use of `create_uid`/`write_uid` audit columns, and the specific functional module prefix `hr_`.

## Functional process 
This table supports the Human Resources offboarding process. It acts as a transient or staging record for the "Departure Wizard," a UI-driven workflow used to capture the details of an employee's exit, including the date of departure and the reason for leaving.

## Description
One row in this table represents a single instance of an employee departure record initiated through the HR wizard. It serves as a raw landing copy of the wizard's state, capturing the intent and metadata for an employee's separation from the organization at a specific point in time.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_departure_wizard_id_seq`. |
| departure_reason_id | INTEGER | false | Foreign key to departure reasons | Links to the lookup table for exit categories. |
| employee_id | INTEGER | false | Foreign key to employee | Identifies the departing staff member. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| departure_date | DATE | false | Effective date of departure | The calendar date the employee leaves. |
| departure_description | TEXT | true | Exit notes | Free-text field for additional context. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp of initial entry. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Standard Odoo naming convention for HR modules).
    - `departure_reason_id` → `hr_departure_reason.id` (Standard Odoo naming convention for HR modules).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `employee_id` and potentially sensitive exit descriptions; ensure access is restricted to authorized HR personnel.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Lifecycle:** This table represents a "wizard" state; records may be ephemeral or represent incomplete workflows depending on how the Odoo module handles the transition to the permanent `hr_employee` record.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs, not necessarily the employee being offboarded.