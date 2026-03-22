---
description: Review changes and provide feedback or suggestions
agent: review
subtask: true
---

Review the current changes in the repository following your expertise in code quality, security, performance, and maintainability.

Review context:

- Git status:
  !`git status --short`
- Diff to review:
  !`git diff`

Target scope:

- If the user provided file paths, focus review on those paths first.
- If the user provided `@file` references, treat those files as primary evidence.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
