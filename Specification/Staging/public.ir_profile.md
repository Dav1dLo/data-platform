# ir_profile

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `ir_` prefix for "internal resource" or "ir" modules) and the presence of columns like `sql`, `qweb`, and `init_stack_trace` are characteristic of Odoo's internal performance profiling and debugging infrastructure.

## Functional process 
This table supports the performance monitoring and debugging process within the Odoo framework. It captures execution profiles for specific requests or operations, logging metrics such as SQL query counts, execution duration, and stack traces to help developers identify bottlenecks in the application logic or database layer.

## Description
One row in this table represents a single performance profile capture for a specific application execution or session. It serves as a raw landing record in the staging layer, containing diagnostic data including timing, stack traces, and the specific SQL queries executed during the profiled operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_profile_id_seq`. |
| sql_count | INTEGER | true | Total number of SQL queries executed | Useful for identifying N+1 query issues. |
| entry_count | INTEGER | true | Number of entries or operations recorded | Context depends on the specific profiling trigger. |
| session | VARCHAR | true | Identifier for the user or system session | Links the profile to a specific user context. |
| name | VARCHAR | true | Descriptive name of the profile | Often contains the method or action name. |
| init_stack_trace | TEXT | true | Initial stack trace of the profiled operation | Used for debugging the origin of the call. |
| sql | TEXT | true | Captured SQL query text | May contain multiple queries or a specific slow query. |
| traces_async | TEXT | true | Asynchronous execution traces | Details on background or non-blocking tasks. |
| traces_sync | TEXT | true | Synchronous execution traces | Details on blocking or main-thread tasks. |
| qweb | TEXT | true | QWeb template rendering profile data | Specific to Odoo's web rendering engine. |
| create_date | TIMESTAMP | true | Timestamp of the profile record creation | Assumed to be in UTC. |
| duration | DOUBLE PRECISION | true | Total execution duration | Unit is typically seconds. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** Not confidently inferable from the provided metadata.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `sql` and `init_stack_trace` columns may contain sensitive information, including raw data values, table names, or internal file paths. Masking is recommended before exposing to non-technical users.
- **Timestamps:** `create_date` is assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Volume:** This table is likely to grow rapidly in environments where profiling is enabled; consider partitioning or TTL policies if querying over large time ranges.
- **Soft Deletes:** There is no explicit soft-delete flag; assume all records are active unless otherwise specified by the application logic.