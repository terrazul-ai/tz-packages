# Basic Package Template

A minimal Terrazul package structure for getting started quickly.

## Directory Structure

```
my-package/
├── agents.toml
├── README.md
└── templates/
    └── CLAUDE.md
```

## agents.toml

```toml
[package]
name = "@owner/my-package"
version = "1.0.0"
description = "Brief description of what this package provides"
license = "MIT"
keywords = ["keyword1", "keyword2"]

[compatibility]
claude = ">=0.2.0"

[exports.claude]
template = "templates/CLAUDE.md"
```

## templates/CLAUDE.md

```markdown
# Package Name

Brief description of what this package provides.

## Purpose

[Explain the purpose and use cases]

## Guidelines

[Key instructions for the AI tool]

## Best Practices

- [Practice 1]
- [Practice 2]
```

## README.md

```markdown
# @owner/my-package

Brief description.

## Installation

\`\`\`bash
tz add @owner/my-package
tz apply
\`\`\`

## Usage

[How to use this package]

## License

MIT
```

## When to Use

Use this template when:
- Creating a simple context package
- No dynamic content needed
- Single platform support (Claude only)
- Quick prototyping
