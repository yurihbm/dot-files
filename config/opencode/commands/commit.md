---
description: Commit current changes to the repository.
agent: general
subtask: true
---

Perform a commit of the current changes in the repository.
Use repository context to draft a precise message and include only relevant files.

Repository snapshot:

- Git status:
  !`git status --short`
- Staged diff:
  !`git diff --cached`
- Unstaged diff:
  !`git diff`
- Recent commit messages:
  !`git log --oneline -10`

Execution rules:

- If the user provided a message, treat it as the highest-priority intent.
- Prefer current project commit style; otherwise use conventional commit format.
- Exclude unrelated or risky files (for example secrets) and mention exclusions clearly.
- If there are no changes to commit, report that and stop.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
