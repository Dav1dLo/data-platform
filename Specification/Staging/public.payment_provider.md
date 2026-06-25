# payment_provider

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for localized messages and the `module_id` reference, are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the "Payment Processing" business process, specifically managing the configuration and availability of various payment gateways (e.g., Stripe, PayPal, Authorize.net) within the ERP. It defines how different payment methods are presented to customers, their operational states, and the specific messaging displayed during the transaction lifecycle.

## Description
One row in this table represents a single configured payment provider instance within the platform. It acts as a raw landed copy of the provider's configuration settings, including form view associations, transaction messaging, and feature flags like tokenization and manual capture.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| sequence | INTEGER | true | Display order index | Used for UI sorting |
| company_id | INTEGER | false | Owning company ID | Foreign key to company table |
| redirect_form_view_id | INTEGER | true | ID of the redirect form view | UI component reference |
| inline_form_view_id | INTEGER | true | ID of the inline form view | UI component reference |
| token_inline_form_view_id | INTEGER | true | ID of the tokenized form view | UI component reference |
| express_checkout_form_view_id | INTEGER | true | ID of the express checkout view | UI component reference |
| color | INTEGER | true | UI color index | Used for styling |
| module_id | INTEGER | true | Associated Odoo module ID | Links to installed app |
| create_uid | INTEGER | true | Creator user ID | Audit trail |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail |
| code | VARCHAR | false | Provider internal code | e.g., 'stripe', 'paypal' |
| state | VARCHAR | false | Operational state | e.g., 'enabled', 'disabled', 'test' |
| name | JSONB | false | Provider display name | Multi-language support |
| pre_msg | JSONB | true | Pre-payment message | Multi-language support |
| pending_msg | JSONB | true | Pending payment message | Multi-language support |
| auth_msg | JSONB | true | Authorization message | Multi-language support |
| done_msg | JSONB | true | Success message | Multi-language support |
| cancel_msg | JSONB | true | Cancellation message | Multi-language support |
| maximum_amount | NUMERIC | true | Max transaction limit | Currency-dependent |
| is_published | BOOLEAN | true | Public visibility flag | Web-facing toggle |
| allow_tokenization | BOOLEAN | true | Tokenization enabled flag | Feature toggle |
| capture_manually | BOOLEAN | true | Manual capture flag | Workflow setting |
| allow_express_checkout | BOOLEAN | true | Express checkout flag | Feature toggle |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC |
| so_reference_type | VARCHAR | true | Sales order reference type | Configuration setting |
| website_id | INTEGER | true | Associated website ID | Multi-site support |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture)
    - `module_id` → `ir_module_module.id` (References installed application modules)
    - `website_id` → `website.id` (References multi-site configuration)
- **Natural keys (inferred):** 
    - `code` (The provider identifier is typically unique within the system)

## Caveats for downstream consumers

- **JSONB columns:** The `name` and `*_msg` columns contain JSONB data, likely storing localized strings (e.g., `{"en_US": "Pay Now", "fr_FR": "Payer maintenant"}`). Ensure you extract the correct key for your reporting needs.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes in this table; records are usually updated or deleted directly.
- **Sensitive Data:** While this table contains configuration, ensure that any `JSONB` fields are audited for potential hardcoded credentials or sensitive API configuration details if the provider implementation stores them here.