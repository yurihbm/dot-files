---
description: Write unit tests for the current changes or provided files.
agent: build
subtask: true
---

Write unit tests to the current changes or any files provided in the user's message.

Testing Guidelines:

- Always follow current project patterns for testing.
- Use current project testing frameworks and libraries.
- Only suggest new frameworks or libraries if there is a clear gap in the current testing approach that can be filled by a new tool.
- Read similar and related tests in the codebase to understand the style and approach.
- Use the `question` tool to ask the user for clarification if needed.
- Use the user's message to identify specific files, functions, or features to focus on for testing.
- If user's message is empty, check if there is uncommitted code changes and write tests for those changes.
- If there are no uncommitted changes and the user's message is empty, use the `questio` tool to ask the user what they would like to have tests written for.

The user provided the following message (ignore if empty):

```markdown
$ARGUMENTS
```
