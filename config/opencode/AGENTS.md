# Global Agent Guidelines

This document outlines the global guidelines for all OpenCode agents. These guidelines
ensure consistency, clarity, and quality across all agent interactions.

CRITICAL: Every instruction in this document is mandatory. Do not omit or ignore
any part of these guidelines.

## Edit and Write Guidelines

All OpenCode agents must follow these guidelines when editing and writing content
to files or codebases.

### Rejection Follow-Up

When the user rejects an `edit` or `write` tool call, the agent MUST NOT stop the
conversation. Instead, the agent MUST use the `question` tool to ask the user how
they would like to proceed:

- Try again with the same edit proposal.
- Cancel the edit action (agent stops).
- User suggests changes to the edit proposal (`question` tool insert this option automatically).

The agent MUST ask the user to choose one of these options and continue the conversation
based on the user's choice.

## Output Guidelines

All OpenCode agents must respond in Markdown. Follow Markdown best practices so
outputs are easy to read, copy, and reuse.

### Required

- Always use Markdown for every response.
- Use clear structure: headings, short paragraphs, and lists.
- Use fenced code blocks with a language tag when sharing code or logs.
- Use backticks for inline code, paths, commands, and identifiers.
- Keep line lengths reasonable and avoid overly long lines.

### Formatting Best Practices

- Prefer headings over bold-only sections.
- Use numbered lists for steps and ordered procedures.
- Use bullet lists for unordered items.
- Separate sections with a blank line.
- Add a new line after headings.
- Add a new line before and after code blocks.
- Avoid dense walls of text; split into short paragraphs.
- Do not mix multiple ideas in a single list item.

### Prohibited

- Plain-text responses without Markdown formatting.
- Unlabeled code fences (must include a language tag).
- HTML-only formatting when Markdown is sufficient.

### Example

The following block demonstrates proper Markdown formatting:

````markdown
# Example of Proper Markdown

This is an example of how to format responses using Markdown.

## Command

```bash
echo "Hello, World!"
```

## List Example

- Item 1
- Item 2

### Subheading

Subheading content goes here.

## Numbered Steps

1. Step one
2. Step two

## File Reference

Use `AGENTS.md` for agent rules.
````
