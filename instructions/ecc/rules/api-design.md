# API Design — Rules

## Resources
- Nouns, plural, lowercase, kebab-case. No verbs in URLs (`/api/v1/users`, not `/getUsers`). Nested routes only for true ownership (`/users/:id/orders`). Non-CRUD actions sparingly via POST (`/orders/:id/cancel`).

## Methods
- GET: retrieve (safe, idempotent). POST: create/actions. PUT: full replace (idempotent). PATCH: partial update. DELETE: remove (idempotent).

## Status Codes
- 200 OK (GET/PUT/PATCH with body), 201 Created (POST + Location header), 204 No Content (DELETE).
- 400 validation/malformed JSON, 401 missing/invalid auth, 403 authenticated-but-forbidden, 404 not found, 409 conflict, 422 semantically invalid data, 429 rate limit.
- 500 unexpected (never expose details), 502 upstream failure, 503 overload + Retry-After.
- Never return 200 for everything. Never 500 for validation errors.

## Response Format
- Envelope for public APIs: `{ data, meta?, links? }`; errors: `{ error: { code, message, details? } }`. Flat responses OK for internal APIs (distinguish by status code).
- Collection responses include pagination meta (total, page, per_page/total_pages) and links (self/next/last).

## Pagination
- Offset (`page`/`per_page`): admin dashboards, small datasets, search results (users expect page numbers).
- Cursor (`cursor`/`limit`): feeds, large datasets, public APIs (default). Fetch one extra row to determine has_next.

## Filtering / Sorting / Search
- Filtering: equality query params, bracket operators (`price[gte]`), comma-separated multi-values, dot-notation nested fields.
- Sorting: `sort=-created_at` (prefix - descending), comma-separated multi-field.
- Search: `?q=`; sparse fieldsets `?fields=id,name` and `?include=relation`.

## Auth
- Bearer tokens / X-API-Key in headers. Resource-level ownership checks (404 vs 403 distinction). Role-based guards.

## Rate Limiting
- Headers: X-RateLimit-Limit / Remaining / Reset; 429 + Retry-After on exceed.
- Tiers: anonymous 30/min/IP, authenticated 100/min, premium 1000/min, internal 10000/min.

## Versioning
- URL path versioning (`/api/v1/`). Max 2 active versions. Non-breaking (add fields/params/endpoints) needs no new version; breaking (remove/rename fields, change types/URLs/auth) requires one.
- Deprecation: announce 6 months for public APIs, add `Sunset` header, 410 Gone after sunset.

## Checklist (before shipping endpoint)
- Naming rules followed; correct method; semantic status codes; schema input validation; standard error format; pagination on lists; auth required or explicitly public; authorization checked; rate limiting on; no internal detail leakage; consistent naming; OpenAPI/Swagger updated.