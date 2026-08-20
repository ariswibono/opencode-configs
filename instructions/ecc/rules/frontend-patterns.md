# Frontend Patterns — Rules

## Composition
- Composition over inheritance. Compound components + context for related UI (Tabs). Render props for flexible data loaders.

## Custom Hooks
- Encapsulate reusable logic: state toggle, async fetching, debounce. Keep latest fetcher/options in refs so refetch stays referentially stable (prevents infinite fetch loops).

## State
- Context + useReducer for shared domain state. Immutable updates (`{ ...state, x }`). Guard hook usage: throw if context missing.

## Performance
- useMemo for expensive computations (copy before in-place sort), useCallback for functions passed to children, React.memo for pure components.
- Lazy-load heavy components (lazy/Suspense).
- Virtualize long lists (`@tanstack/react-virtual`).

## Forms
- Controlled inputs with validation state; validate before submit; surface field-level errors.

## Errors
- Error boundary at app root; graceful fallback + retry.

## Animation
- AnimatePresence for enter/exit lists and modals; keep transitions meaningful and short.

## Accessibility
- Keyboard navigation on interactive widgets (Arrow keys, Enter, Escape). Manage focus on modals: save/restore previous focus, focus dialog, Escape to close. Use proper roles (`combobox`, `dialog`, `aria-modal`).

Choose patterns that fit the project's complexity.