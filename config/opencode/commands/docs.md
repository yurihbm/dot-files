---
description: Generate or improve docs for a target file or feature.
agent: general
subtask: true
---

Create or improve developer-facing documentation for the requested scope.

Target scope:

- Use user message to identify the primary target (file path, symbol, or feature).
- If a target is not specified, assume the user wants documentation for uncommitted changes.
- If `@file` references are present, prioritize those files.

Documentation requirements:

- Explain what it does, how it is used, key inputs/outputs, and constraints.
- Include examples when helpful.
- Match existing project terminology and style.
- Use documentation comments for variable, function, and class-level explanations.
- Use README or markdown files for broader feature, module or folders explanations.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
