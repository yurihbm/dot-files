---
description: Propose a refactor plan for a target scope.
agent: brainstorm
subtask: false
---

Analyze the requested scope and propose practical refactor options.

Context snapshot:

- Changed files:
  !`git diff --name-only`
- Current diff:
  !`git diff`

Target scope:

- Use user message to identify the primary target (file path, symbol, or feature).
- If a target is not specified, assume the user wants refactor options for uncommitted changes.
- If `@file` references are present, prioritize those files.

Output requirements:

- Produce 2-4 concrete refactor options with trade-offs.
- Recommend one "best next step".

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
