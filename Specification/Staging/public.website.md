# website

## Source system
This table originates from an Odoo ERP environment, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of sequence-based primary keys (`nextval('"public".website_id_seq'::regclass)`).

## Functional process 
This table supports the "Website Management" module within the ERP, acting as the central configuration store for multi-site deployments. It manages site-specific settings, including social media integrations, third-party analytics keys (Google, Plausible), CDN configurations, and custom header/footer code injections.

## Description
One row in this table represents a single website instance configured within the ERP system. It serves as a raw landing copy of the website configuration entity, capturing both structural metadata (domain, language, company association) and operational settings (analytics keys, social links, and security policies).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for sorting websites in UI. |
| company_id | INTEGER | false | Associated company ID | Foreign key to company table. |
| default_lang_id | INTEGER | false | Default language ID | Foreign key to language table. |
| user_id | INTEGER | false | Responsible user ID | Foreign key to res_users table. |
| theme_id | INTEGER | true | Theme ID | Foreign key to theme table. |
| create_uid | INTEGER | true | Creator user ID | Audit field. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field. |
| name | VARCHAR | false | Website name | Human-readable site name. |
| domain | VARCHAR | true | Website domain | URL domain for the site. |
| social_twitter | VARCHAR | true | Twitter handle/URL | Social media integration. |
| social_facebook | VARCHAR | true | Facebook URL | Social media integration. |
| social_github | VARCHAR | true | GitHub URL | Social media integration. |
| social_linkedin | VARCHAR | true | LinkedIn URL | Social media integration. |
| social_youtube | VARCHAR | true | YouTube URL | Social media integration. |
| social_instagram | VARCHAR | true | Instagram URL | Social media integration. |
| social_tiktok | VARCHAR | true | TikTok URL | Social media integration. |
| google_analytics_key | VARCHAR | true | GA tracking ID | Sensitive: API/Tracking key. |
| google_search_console | VARCHAR | true | GSC verification code | Sensitive: API/Verification key. |
| google_maps_api_key | VARCHAR | true | Google Maps API key | Sensitive: API key. |
| plausible_shared_key | VARCHAR | true | Plausible shared key | Sensitive: API key. |
| plausible_site | VARCHAR | true | Plausible site domain | Analytics configuration. |
| cdn_url | VARCHAR | true | CDN base URL | Content delivery network path. |
| homepage_url | VARCHAR | true | Homepage path | Default landing page. |
| auth_signup_uninvited | VARCHAR | true | Signup policy | Configuration for user registration. |
| custom_blocked_third_party_domains | TEXT | true | Blocked domains list | Security/Privacy policy. |
| cdn_filters | TEXT | true | CDN file filters | Regex or patterns for CDN. |
| custom_code_head | TEXT | true | HTML head injection | Custom script/meta tags. |
| custom_code_footer | TEXT | true | HTML footer injection | Custom script tags. |
| robots_txt | TEXT | true | robots.txt content | SEO configuration. |
| auto_redirect_lang | BOOLEAN | true | Auto-redirect flag | Language detection toggle. |
| cookies_bar | BOOLEAN | true | Cookie banner flag | Privacy compliance toggle. |
| configurator_done | BOOLEAN | true | Setup status | Indicates if wizard is complete. |
| block_third_party_domains | BOOLEAN | true | Block third-party flag | Privacy setting. |
| has_social_default_image | BOOLEAN | true | Social image flag | Indicates if og:image is set. |
| cdn_activated | BOOLEAN | true | CDN status | Toggle for CDN usage. |
| specific_user_account | BOOLEAN | true | User account scope | Toggle for site-specific users. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| crm_default_team_id | INTEGER | true | Default CRM team | Foreign key to crm_team. |
| crm_default_user_id | INTEGER | true | Default CRM user | Foreign key to res_users. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `default_lang_id` → `res_lang.id` (Standard Odoo language reference).
    - `user_id` → `res_users.id` (Standard Odoo user reference).
    - `theme_id` → `ir_ui_view.id` (Likely reference to theme/view templates).
- **Natural keys (inferred):** 
    - `domain` (Assuming unique domains per website instance).

## Caveats for downstream consumers

- **Sensitive Data:** This table contains multiple API keys (`google_analytics_key`, `google_maps_api_key`, etc.) and custom code fields (`custom_code_head`, `custom_code_footer`) which may contain sensitive scripts or credentials. Mask these columns in non-production environments.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with standard Odoo database practices.
- **Data Integrity:** The `domain` column may be null for internal or staging sites.
- **Soft Deletes:** This table does not appear to use a soft-delete flag; assume records are hard-deleted if missing from source.