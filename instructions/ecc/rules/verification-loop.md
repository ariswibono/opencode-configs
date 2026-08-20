# Verification Loop — Rules

## When
After completing a feature or significant change, before creating a PR, after refactoring, or when quality gates must pass.

## Phases (run in order)
1. Build: `npm run build` (or `pnpm build`). If it fails, STOP and fix before continuing.
2. Type check: `tsc --noEmit` (TS) or `pyright .` (Python) with `set -o pipefail`. Report all type errors; fix critical ones before continuing.
3. Lint: `npm run lint` (JS/TS) or `ruff check .` (Python).
4. Tests with coverage: run suite; target 80% minimum. Report total/passed/failed/coverage%.
5. Security scan: grep for secrets (`sk-`, `api_key`) and stray `console.log` in source.
6. Diff review: `git diff --stat` + changed files. Review each for unintended changes, missing error handling, edge cases.

## Output Format
```
VERIFICATION REPORT
Build:    [PASS/FAIL]
Types:    [PASS/FAIL] (X errors)
Lint:     [PASS/FAIL] (X warnings)
Tests:    [PASS/FAIL] (X/Y passed, Z% coverage)
Security: [PASS/FAIL] (X issues)
Diff:     [X files changed]
Overall:  [READY/NOT READY] for PR
```

## Continuous Mode
- Checkpoint after each function, component, or before the next task. Run full verification after major changes (~15 min intervals in long sessions). Complements PreToolUse hooks — hooks catch issues immediately, this provides comprehensive review.