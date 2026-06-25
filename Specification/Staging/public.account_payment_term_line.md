# account_payment_term_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the specific structure of payment term lines are characteristic of Odoo's accounting module, where payment terms are broken down into individual line items defining installment schedules.

## Functional process 
This table supports the "Order-to-Cash" and "Procure-to-Pay" business processes by defining the specific payment schedule for invoices. It dictates when payments are due, whether as a fixed percentage, a fixed amount, or a balance, and calculates the due date based on the `delay_type` and `nb_days` relative to the invoice date.

## Description
One row in this table represents a single installment or condition within a payment term definition. It acts as a raw landed copy of the Odoo `account.payment.term.line` model, capturing the logic used to calculate due dates and amounts for customer or vendor invoices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_payment_term_line_id_seq`. |
| nb_days | INTEGER | true | Number of days to add to the invoice date | Used when `delay_type` is 'days'. |
| payment_id | INTEGER | false | Foreign key to the parent payment term | Links to `account.payment.term`. |
| create_uid | INTEGER | true | User ID who created the record | Reference to `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Reference to `res.users`. |
| value | VARCHAR | false | Type of payment value | e.g., 'percent', 'fixed', 'balance'. |
| delay_type | VARCHAR | false | Method of calculating the due date | e.g., 'days', 'days_after_end_of_month'. |
| days_next_month | VARCHAR(2) | true | Day of the month for due date | Used for end-of-month calculations. |
| value_amount | NUMERIC | true | The amount or percentage value | Interpretation depends on the `value` column. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `account_payment_term.id`: This column links the line item to its parent payment term definition.
    - `create_uid` → `res_users.id`: Tracks the user who created the record (guess).
    - `write_uid` → `res_users.id`: Tracks the user who last updated the record (guess).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Interpretation:** The `value_amount` column is polymorphic; its meaning (percentage vs. absolute currency amount) is determined by the `value` column.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Denormalization:** This is a staging table; expect raw data types and potential inconsistencies in string-based fields like `value` and `delay_type`.