# Security Review — Rules

## Secrets
- NEVER hardcode API keys, passwords, or tokens. All secrets in environment variables; validate presence at startup (`throw` if missing).
- `.env.local` in .gitignore; no secrets in git history; production secrets in the hosting platform's secret store.

## Input Validation
- Validate ALL user input at system boundaries with schemas (Zod/Pydantic/ORM validators). Whitelist, never blacklist.
- File uploads: enforce size, MIME type, and extension allowlists.
- Error messages must not leak internal/sensitive info.

## SQL Injection
- Always parameterized queries / ORM builders. Never concatenate user input into SQL strings.

## Authentication & Authorization
- Tokens in httpOnly + Secure + SameSite cookies, NOT localStorage (XSS exposure).
- Authorization checks BEFORE sensitive operations. Row Level Security enabled on Supabase tables. Role-based access control.

## XSS
- Sanitize user-provided HTML (allowlist tags/attrs). Configure CSP headers — start strict; `'unsafe-inline'`/`'unsafe-eval'` only as documented temporary debt.
- No unvalidated dynamic content rendering.

## CSRF
- CSRF tokens on all state-changing operations. SameSite=Strict on all cookies. Double-submit cookie pattern.

## Rate Limiting
- Rate limiting on ALL endpoints; stricter on expensive operations (search, auth). IP-based and user-based limits.

## Sensitive Data
- No passwords/tokens/secrets in logs. Generic user-facing error messages; detailed errors + stack traces only in server logs.

## Dependencies
- `npm audit` clean; lock files committed; `npm ci` in CI; Dependabot enabled; regular updates.

## Pre-Deployment Gate (before ANY production deploy)
- Secrets in env, input validated, queries parameterized, content sanitized, CSRF enabled, token handling correct, role checks present, rate limiting on, HTTPS enforced, security headers set, errors/logs leak nothing, deps clean, RLS enabled, CORS configured, uploads validated, wallet signatures verified (if blockchain).

## Blockchain (Solana, if applicable)
- Verify wallet signatures, validate transaction recipient/amount/balance before signing. No blind transaction signing.

## Testing
- Automated security tests: auth (401), authorization (403), invalid input (400), rate limit (429).

When in doubt, err on the side of caution. One vulnerability can compromise the entire platform.