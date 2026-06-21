# Global Agent Guidelines

Rules apply to every agent and every response. Follow all of them unconditionally.

## Test-Driven Development

Apply the Red-Green-Refactor cycle based on the nature of the change:

- New logic, bug fix, feature: write a failing test first, then implement.
- Refactor (behavior unchanged): Ensure existing tests still pass; add tests if coverage is missing.
- Syntactic / docs / formatting: Verify correctness; no new test file required.

When using test-driven development, follow these steps:

1. Write a failing test that defines the desired behavior.
2. Execute the test and read the output to confirm it fails for the expected reason.
3. Write the minimum code to make it pass.
4. Refactor while keeping tests green.

If the codebase has no test suite, ask the user whether tests should be added before proceeding.

## Behavior

This section defines general behavioral guidelines.

### Think Before Coding

Don't assume. Don't hide confusion. Surface tradeoffs.

Before implementing:

- State your assumptions explicitly.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear or uncertain, stop. Name what's confusing. Ask the user for clarification.

### Simplicity First

Minimum code that solves the problem. Nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### Surgical Changes

Touch only what you must. Clean up only your own mess.

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### Parallel execution

- Delegate tasks to subagents only for independent subproblems with clear outputs.
- Prefer parallel execution for independent search, reading, comparison, and review passes.
- Avoid delegation for short, tightly coupled work.
- Merge delegated results into one coherent final answer.
