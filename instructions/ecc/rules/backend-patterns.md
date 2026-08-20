# Backend Patterns — Rules

## Architecture
- RESTful resource URLs: GET/POST/PUT/PATCH/DELETE on `/api/resources/:id`; query params for filter/sort/pagination.
- Repository pattern: abstract data access behind interface (findAll/findById/create/update/delete). Business logic depends on the interface, not the storage mechanism.
- Service layer: business logic separated from data access.
- Middleware pipeline for cross-cutting concerns (auth, logging, rate limiting).

## Database
- Select only needed columns, never `select('*')` on large tables.
- Prevent N+1: batch-fetch related records in 1 query, map by ID.
- Wrap multi-write operations in transactions (RPC/DB function or ORM transaction).

## Caching
- Cache-aside: check cache → miss → fetch DB → write cache with TTL. Invalidate on writes.

## Errors
- Centralized error handler: typed API errors with status codes; Zod → 400; unknown → log + generic 500. Never leak internals.
- Retry transient failures with exponential backoff (1s, 2s, 4s; max retries).

## Auth
- JWT in Authorization Bearer; verify signature + validate claims. `requireAuth` wrapper on protected routes.
- RBAC via role→permissions map; `requirePermission` HOF wrapping handlers. Return 401 missing/invalid token, 403 insufficient permissions.

## Rate Limiting
- MUST use a shared store (Redis, gateway, platform limiter) — never per-process in-memory counters for production (reset on deploy, split across replicas, fail open in serverless).

## Background Jobs
- Queue pattern: add job → process serially → log failures; keep handler responsive.

## Logging
- Structured JSON logs (timestamp, level, message, context). Never log secrets.

Choose patterns that fit the project's complexity level.