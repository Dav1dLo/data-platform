# payment_method_res_currency_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business system, as indicated by the `res_currency` naming convention, which is a standard pattern for "resource" tables in Odoo's PostgreSQL schema.

## Functional process 
This table supports the configuration of payment gateways or methods by defining which currencies are supported or enabled for specific payment methods. It acts as a bridge table to manage the many-to-many relationship between payment processing configurations and currency definitions.

## Description
One row in this table represents a single association between a payment method and a supported currency. It serves as a raw landing copy of the relationship mapping, ensuring that the system can validate whether a specific currency is permitted for a given payment transaction method.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition. | Represents the identifier for the payment gateway or method. |
| res_currency_id | INTEGER | false | Foreign key to the currency definition. | Represents the identifier for the ISO currency code. |

## Keys

- **Primary key (inferred):** The combination of `payment_method_id` and `res_currency_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_method.id`: Guessed based on the standard naming convention for Odoo-style relational tables.
    - `res_currency_id` → `res_currency.id`: Guessed based on the standard naming convention for Odoo-style relational tables.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; queries should expect to join this against both the payment method and currency master tables to retrieve human-readable names.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification history of these relationships from this table alone.
- This table contains no PII or sensitive financial data, only relational identifiers.