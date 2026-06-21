---
description: Propose a refactor plan for a target scope.
---

Analyze the requested scope and propose practical refactor options.

Context snapshot:

- Changed files:
  !`git diff --name-only`
- Current diff:
  !`git diff`

Target scope:

- Use the user message to identify the primary target (file path, symbol, or feature).
- If no target is specified, assume refactor options are wanted for uncommitted changes.
- If `@file` references are present, prioritize those files.

Output requirements:

- Produce 2-4 concrete refactor options with trade-offs.
- Recommend one "best next step".

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
