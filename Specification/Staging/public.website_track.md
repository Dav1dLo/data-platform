# website_track

## Source system
The table likely originates from a web analytics or clickstream tracking system, such as a custom-built event logger or a lightweight integration with a tool like Segment or Google Analytics. The presence of `visitor_id` and `page_id` suggests it captures user navigation patterns across a website.

## Functional process 
This table supports web traffic analysis and user behavior tracking. It records individual page views or navigation events, allowing for the calculation of metrics such as page popularity, visitor session duration, and user journey mapping.

## Description
One row in this table represents a single page view or tracking event initiated by a visitor on the website. As a staging table, it serves as a raw, append-only landing point for clickstream data before it is processed into sessionized or aggregated analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| visitor_id | INTEGER | false | Unique identifier for the website visitor | Likely links to a visitor dimension table. |
| page_id | INTEGER | true | Unique identifier for the page visited | Nullable if the event is a non-page event (e.g., click). |
| url | TEXT | true | The full URL of the page visited | Contains the path and query parameters. |
| visit_datetime | TIMESTAMP | false | The exact timestamp of the event | Assumed to be in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_id` → `pages.id` (Guess: links to a master list of site pages).
- **Natural keys (inferred):** 
    - None. This table relies on a surrogate `id` for uniqueness.

## Caveats for downstream consumers

- **Sensitive Data:** The `url` column may contain PII in query parameters (e.g., email addresses or session tokens); ensure this is masked if necessary.
- **Timezone:** Timestamps are assumed to be in UTC; verify against source system configuration.
- **Data Integrity:** `page_id` is nullable, meaning some events may represent off-site clicks or non-page interactions.
- **Soft Deletes:** There is no indication of soft-delete flags; assume this is an append-only log.