---
description: Explain a file, symbol, or code path.
agent: ask
subtask: false
---

Explain the requested code clearly and concisely.

Target scope:

- Use user message to identify the primary target (file path, symbol, or feature).
- If a target is not specified, assume the user wants explanations for uncommitted changes.
- If `@file` references are present, prioritize those files.

Output requirements:

- Start with a 1-2 sentence summary.
- Then explain purpose, control flow, key dependencies, and edge cases.
- End with a short "What to check next" list.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
