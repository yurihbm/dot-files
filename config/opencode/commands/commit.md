---
description: Commit current changes to the repository.
subtask: true
model: github-copilot/gpt-4.1
---

Perform a commit of the current changes in the repository.
If there is any ambiguity about the commit message, use the `question` tool to ask the user for clarification or a specific message to use for the commit.
Use conventional commit messages if possible, or current project commit message style if known.

The user provided the following message (ignore if empty):

```markdown
$ARGUMENTS
```
