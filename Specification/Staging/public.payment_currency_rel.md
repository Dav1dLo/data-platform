# payment_currency_rel

## Source system
Unknown — insufficient evidence. The table name suggests a mapping or relationship entity, but the column names lack specific prefixes or suffixes that would link them to a known ERP or CRM system.

## Functional process 
This table supports a configuration or reference mapping process, likely defining which payment providers are authorized to process specific currencies. It acts as a bridge between a payment provider registry and a currency master list.

## Description
One row in this table represents a single valid association between a payment provider and a supported currency. As a staging table, it serves as a raw landed copy of a bridge entity used to enforce business rules regarding payment processing capabilities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_provider_id | INTEGER | false | Surrogate key for the payment provider | Likely a foreign key to a provider master table. |
| currency_id | INTEGER | false | Surrogate key for the currency | Likely a foreign key to a currency master table. |

## Keys

- **Primary key (inferred):** The composite of (`payment_provider_id`, `currency_id`).
- **Foreign keys (inferred):** 
    - `payment_provider_id` → `payment_providers.id` (guess: standard naming convention for provider entities).
    - `currency_id` → `currencies.id` (guess: standard naming convention for currency entities).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a bridge/associative entity; expect a many-to-many relationship between providers and currencies.
- There are no audit timestamps or soft-delete flags present; assume this table represents the current state of associations as captured during the last ingestion.
- No sensitive PII is contained within this table.