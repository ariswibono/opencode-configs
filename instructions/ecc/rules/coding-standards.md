# Coding Standards — Rules

## Shared Floor
Baseline conventions across ALL projects. Framework-specific depth lives in frontend/backend/api skills. `rules/common/coding-style.md` is the shortest reusable layer.

## Quality Principles
- Readability first: clear descriptive names, self-documenting code over comments, consistent formatting.
- KISS: simplest working solution, no over-engineering, no premature optimization. Easy to understand > clever.
- DRY: extract shared logic; no copy-paste programming.
- YAGNI: don't build before needed, no speculative generality.

## Naming
- Descriptive, verb-noun functions (`fetchMarketData`, `isValidEmail`). No single letters or `flag`/`q`/`x`.

## Immutability (CRITICAL)
- Always create new objects/arrays (spread): `{ ...user, name: newName }`, `[...items, item]`.
- NEVER mutate in place: no `user.name = x`, no `items.push()`. Copy before mutating operations like `.sort()`.

## Error Handling
- Handle errors at every level. User-friendly messages in UI; detailed context server-side. Never silently swallow errors.

## Async
- Parallelize independent awaits with `Promise.all`.

## Type Safety
- No `any`. Full typed interfaces/signatures.

## React
- Typed functional components with explicit props. Functional state updates (`setCount(p => p+1)`), never stale direct references. Clear conditional rendering — no ternary nesting beyond 1 level.

## Files & Structure
- Functions < 50 lines. Files focused (< 800 lines). No nesting > 4 levels — use early returns.
- Named constants for magic numbers (`MAX_RETRIES`, `DEBOUNCE_DELAY_MS`).
- PascalCase components, `use` prefix hooks, camelCase utilities, `.types` suffix on type files.

## Comments
- Explain WHY, not WHAT. No obvious-true comments. JSDoc on public APIs.

## Performance
- Memoize expensive computations/callbacks. Lazy-load heavy components. Select only needed DB columns.

## Testing
- AAA pattern. Descriptive test names ("returns empty array when no markets match query"), never `works`/`test search`.

## Code Smells (watch for)
- Long functions, deep nesting, magic numbers, vague names, direct mutation, `any`, unhandled errors.

Code quality is not negotiable — it enables rapid development and confident refactoring.