# payment_country_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a junction or mapping table, but the naming convention does not align with common ERP or CRM patterns (e.g., SAP, Salesforce, or Stripe).

## Functional process 
This table supports a many-to-many relationship mapping between payments and countries. It likely facilitates regional reporting or regulatory compliance tracking by associating specific payment transactions with their respective country of origin or destination.

## Description
One row in this table represents a single association between a payment record and a country record. It serves as a raw landing staging table, providing a normalized link between payment entities and country entities to support downstream join operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_id | INTEGER | false | Surrogate key referencing the payment record | Likely a foreign key to a payments table. |
| country_id | INTEGER | false | Surrogate key referencing the country record | Likely a foreign key to a countries dimension table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key of (`payment_id`, `country_id`).
- **Foreign keys (inferred):** 
    - `payment_id` → `payments.id` (guess: standard naming convention for relational mapping).
    - `country_id` → `countries.id` (guess: standard naming convention for relational mapping).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; ensure joins are handled carefully to avoid fan-out if a payment is associated with multiple countries.
- No audit timestamps or soft-delete flags are present; assume this table represents the current state of associations as captured during the last ingestion.
- As a staging table, data may be truncated and reloaded; verify row counts against the source system if performing reconciliation.