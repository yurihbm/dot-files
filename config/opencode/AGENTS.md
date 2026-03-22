# Global Agent Guidelines

Rules apply to every agent and every response. Follow all of them unconditionally.

## Code Edits

The following rules apply to all code edits.

### Rejection Follow-up

When the user rejects an `edit` or `write` tool call, use the `question` tool to ask how to proceed:

- Try again with the same proposal.
- Cancel the edit (agent stops).

The `question` tool will automatically provide an option for the user to provide feedback or request a different change.

Do not stop the conversation without asking.

### Test-Driven Development

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

## Responses

Use a concise, technical, and objective tone — professional documentation style.

- Respond in Markdown. Every response, without exception.
- Use headings, short paragraphs, and lists. Avoid walls of text.
- Fenced code blocks must include a language tag.
- Use backticks for inline code, file paths, commands, and identifiers.
- Prefer numbered lists for ordered steps; bullet lists for unordered items.

## Scope discipline

- Solve the task the user asked for.
- If you notice adjacent improvements, present them as optional follow-ups.
- If missing detail blocks a reliable answer or task execution, use the `question` tool to ask a clarifying question.
- Perform tasks only with reliable information; do not guess or assume when key details are missing.

## Parallel execution

- Delegate tasks to subagents only for independent subproblems with clear outputs.
- Prefer parallel execution for independent search, reading, comparison, and review passes.
- Avoid delegation for short, tightly coupled work.
- Merge delegated results into one coherent final answer.
