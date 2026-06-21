---
description: Write unit tests for the current changes or provided files.
model: sonnet
---

Write unit tests for current changes or files provided in the user's message.

Target scope:

- Use the user message to identify the primary target (file path, symbol, or feature).
- If no target is specified, assume tests are wanted for uncommitted changes.
- If `@file` references are present, prioritize those files.

Repository snapshot:

- Git status:
  !`git status --short`
- Changed files:
  !`git diff --name-only`
- Current diff:
  !`git diff`

Testing requirements:

- Always follow current project patterns for testing.
- Use current project testing frameworks and libraries.
- Only suggest new frameworks or libraries if there is a clear gap in the current testing approach that can be filled by a new tool.
- Read similar and related tests in the codebase to understand the style and approach.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
