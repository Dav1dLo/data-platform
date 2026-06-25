# payment_method_payment_provider_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a junction or associative entity, common in relational databases to resolve many-to-many relationships between payment methods and payment providers, but the naming convention does not map to a specific major SaaS or ERP platform.

## Functional process 
This table supports the configuration of payment processing capabilities by mapping specific payment methods (e.g., Credit Card, PayPal, Bank Transfer) to the payment providers (e.g., Stripe, Adyen, Braintree) that support them. It acts as a lookup or bridge table within the payment orchestration logic.

## Description
One row represents a single association between a specific payment method and a payment provider. It is a raw landed copy of a junction table, serving as a reference for downstream transformations to determine which providers are authorized to process specific payment types.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Surrogate key for the payment method. | Foreign key to a payment_methods table. |
| payment_provider_id | INTEGER | false | Surrogate key for the payment provider. | Foreign key to a payment_providers table. |

## Keys

- **Primary key (inferred):** Composite key of (`payment_method_id`, `payment_provider_id`).
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_methods.id` (Inferred from naming convention).
    - `payment_provider_id` → `payment_providers.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to join this against both `payment_methods` and `payment_providers` to retrieve human-readable names.
- There are no timestamps or audit columns, so it is impossible to determine the history of these associations or when they were created.
- The table structure implies a many-to-many relationship; ensure joins are handled correctly to avoid Cartesian products if filtering is not applied.