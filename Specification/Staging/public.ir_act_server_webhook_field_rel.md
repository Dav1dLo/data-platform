# ir_act_server_webhook_field_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business application framework. The naming convention `ir_act_server_webhook_field_rel` follows the standard Odoo pattern for a many-to-many relationship table (often suffixed with `_rel`) linking server actions to webhook fields.

## Functional process 
This table supports the configuration of server-side actions and webhook integrations. It maps specific fields to server-side webhook actions, enabling the system to define which data attributes are included or processed when a webhook event is triggered.

## Description
One row in this table represents a single association between a server action and a specific field within a webhook configuration. It acts as a join table to resolve a many-to-many relationship between server actions and fields in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| server_id | INTEGER | false | Foreign key to the server action definition | Links to the parent action entity. |
| field_id | INTEGER | false | Foreign key to the field definition | Links to the specific field being associated. |

## Keys

- **Primary key (inferred):** The combination of `(server_id, field_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `server_id` → `ir_act_server.id` (guess: standard Odoo naming convention for server actions).
    - `field_id` → `ir_model_fields.id` (guess: standard Odoo naming convention for model fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with the parent `ir_act_server` and `ir_model_fields` tables to retrieve meaningful business data.
- No audit timestamps (e.g., `created_at`) are present, so tracking the history of these associations is not possible from this table alone.
- The table contains no sensitive PII, but represents internal system configuration metadata.