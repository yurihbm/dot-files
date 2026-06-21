---
description: Generate or improve docs for a target file or feature.
model: haiku
---

Create or improve developer-facing documentation for the requested scope.

Target scope:

- Use the user message to identify the primary target (file path, symbol, or feature).
- If no target is specified, assume documentation is wanted for uncommitted changes.
- If `@file` references are present, prioritize those files.

Documentation requirements:

- Explain what it does, how it is used, key inputs/outputs, and constraints.
- Include examples when helpful.
- Match existing project terminology and style.
- Use documentation comments for variable, function, and class-level explanations.
- Use README or markdown files for broader feature, module, or folder explanations.

The user provided the following message (ignore if empty):

<prompt>
$ARGUMENTS
</prompt>
