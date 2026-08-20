# Eval Harness — Rules

## Philosophy
Eval-Driven Development: evals are the unit tests of AI development. Define expected behavior BEFORE implementation, run evals continuously, track regressions with each change, measure reliability with pass@k.

## Eval Types
- Capability evals: can the agent do something new? Task + success criteria checklist + expected output.
- Regression evals: did changes break existing behavior? Baseline SHA + test list with PASS/FAIL + result.

## Graders
1. Code-based: deterministic (grep for expected pattern, test pass, build success). Prefer when possible.
2. Model-based: LLM-as-judge rubric, score 1-5 with reasoning.
3. Rule-based: regex/schema constraints.
4. Human: manual adjudication for ambiguous outputs, security-sensitive changes, high-risk.

## Metrics
- pass@1: first-attempt success rate.
- pass@3: at least one success in 3 attempts. Target >= 0.90 for capability evals.
- pass^3: all 3 consecutive trials succeed. Use for release-critical paths; target 1.00 for regression evals.

## Workflow
1. Define evals BEFORE coding (capability + regression + success metrics).
2. Implement to pass evals.
3. Evaluate: run each capability eval, record PASS/FAIL; run regression suite; generate report.
4. Report: capability results, regression results, metrics, overall status.

## Storage
- `.claude/evals/<feature>.md` definition, `.claude/evals/<feature>.log` run history, `baseline.json` regression baselines. Version evals with code.

## Integration
- Pre-implementation: `/eval define <name>`; during: `/eval check <name>`; post: `/eval report <name>`.

## Best Practices
- Define before coding; run frequently; track pass@k over time; code graders over probabilistic; human review for security (never fully automate); keep evals fast (slow evals don't get run); version evals as first-class artifacts.

## Anti-Patterns
- Overfitting prompts to known eval examples; measuring only happy-path outputs; ignoring cost/latency drift while chasing pass rates; allowing flaky graders in release gates.