---
description: Commit current changes using a generated commit message
model: haiku
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*)
---

Commit the current changes:

1. Run `git status` and `git diff` (staged and unstaged) to see what changed, and `git log --oneline -5` to match this repo's commit message style.
2. Stage the relevant files by name (never `git add -A` or `git add .`). Skip files that look like secrets (.env, credentials, etc.) and warn if any were skipped.
3. Write a concise commit message (1-2 sentences) focused on _why_, matching the repo's existing style.
4. Create the commit. Do not amend, do not skip hooks, do not push.
5. Run `git status` after to confirm the commit succeeded. If a pre-commit hook fails, fix the issue, re-stage, and create a new commit (never amend after a failed hook).

Constraints:

- Commit messages must be concise and focused.
- The first sentence of the commit message should be a brief summary of the change (60 characters or less).
- Additional details can be included in the body of the commit message, but it should be separated from the summary by a blank line and should not exceed 80 characters per line.
- If there are no staged or unstaged changes, say so and stop without committing.
