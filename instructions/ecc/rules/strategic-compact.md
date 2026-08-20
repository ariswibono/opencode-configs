# Strategic Compact — Rules

## Purpose
Suggest manual `/compact` at logical task boundaries instead of relying on arbitrary auto-compaction (which fires mid-task, loses context, and ignores task phase).

## When to Compact
- Research → Planning: yes (research is bulky; plan is the distilled output).
- Planning → Implementation: yes (plan lives in TodoWrite/file).
- Implementation → Testing: maybe (keep if tests reference recent code).
- Debugging → Next feature: yes (traces pollute unrelated work).
- Mid-implementation: NO (losing variable names, paths, partial state is costly).
- After a failed approach: yes (clear dead-end reasoning).

## Signals
- Context size (primary): sum input + cache_read + cache_creation tokens. Suggest at window-scaled threshold (~160k on 200k window, ~250k on 1M), re-remind every +60k growth.
- Tool-call count (secondary, weak): suggest at 50 calls then every +25. A few large reads can fill the window in few calls; many tiny calls can cross 50 with an empty window.

## Config Env Vars
- `COMPACT_THRESHOLD` (default 50 calls), `COMPACT_CONTEXT_THRESHOLD` (160000/250000; 0 disables), `COMPACT_CONTEXT_INTERVAL` (60000), `COMPACT_STATE_TTL_DAYS` (14).
- `ECC_CONTEXT_WINDOW_TOKENS` / `CLAUDE_CODE_AUTO_COMPACT_WINDOW`: set explicit window size when model id lacks a `[1m]` marker so thresholds scale correctly.

## What Survives Compaction
- Persists: CLAUDE.md instructions, TodoWrite, memory files, git state, files on disk.
- Lost: intermediate reasoning, previously-read file contents, multi-step conversation, tool history, verbally-stated preferences.

## Best Practices
- Compact after planning and after debugging. Never mid-implementation.
- Read the suggestion — the hook says WHEN, you decide IF.
- Write important context to files/memory BEFORE compacting.
- Use `/compact` with a summary ("/compact Focus on implementing auth middleware next").

## Context Optimization
- Trigger-table lazy loading (load skills only on keyword trigger) cuts baseline context 50%+.
- Monitor context consumers: CLAUDE.md, loaded skills (1-5K each), conversation history, tool results.
- Detect duplicate instructions across rule dirs and overlapping skills.
- Tools: `token-optimizer` MCP (95%+ reduction via dedup), `context-mode` (virtualization).