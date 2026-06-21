---
description: Explain a file, symbol, or code path.
model: haiku
---

Explain the requested code clearly and concisely.

Target scope:

- Use the user message to identify the primary target (file path, symbol, or feature).
- If no target is specified, assume an explanation is wanted for uncommitted changes.
- If `@file` references are present, prioritize those files.

Output requirements:

- Start with a 1-2 sentence summary.
- Then explain purpose, control flow, key dependencies, and edge cases.
- End with a short "What to check next" list.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
