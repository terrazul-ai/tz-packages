# MCP Server Configuration Reference

Complete reference for configuring MCP (Model Context Protocol) servers.

## What is MCP?

Model Context Protocol (MCP) allows AI assistants to interact with external tools and services. MCP servers provide:
- Tool definitions (functions Claude can call)
- Resource access (files, databases, APIs)
- Contextual information

## Configuration Formats

### Claude Code (JSON)

**Local Project** (`.claude/settings.local.json`):
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@package/name"],
      "env": {
        "ENV_VAR": "${LOCAL_VAR}"
      }
    }
  }
}
```

**User Settings** (`~/.claude/settings.json`):
```json
{
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["/path/to/server.js"],
      "env": {}
    }
  }
}
```

### Codex (TOML)

**Config** (`~/.codex/config.toml`):
```toml
[mcp_servers.server-name]
command = "npx"
args = ["-y", "@package/name"]

[mcp_servers.server-name.env]
API_KEY = "${API_KEY}"
```

### Gemini (JSON)

**Settings** (`.gemini/settings.json`):
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@package/name"],
      "env": {}
    }
  }
}
```

## Configuration Options

### command (required)

The executable to run:
- `"npx"` - Run npm packages
- `"node"` - Run Node.js scripts
- `"python"` - Run Python scripts
- `"/path/to/binary"` - Run binary executable

### args (required)

Array of command arguments:
```json
"args": ["-y", "@anthropic/mcp-github", "--repo", "owner/repo"]
```

### env (optional)

Environment variables for the server:
```json
"env": {
  "GITHUB_TOKEN": "${GITHUB_TOKEN}",
  "DEBUG": "true"
}
```

Use `${VAR_NAME}` to reference environment variables.

### cwd (optional)

Working directory for the server:
```json
"cwd": "/path/to/directory"
```

### disabled (optional)

Temporarily disable a server:
```json
"disabled": true
```

## Server Categories

### Development Tools

**GitHub** (`@anthropic/mcp-github`):
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

Tools: create_issue, create_pull_request, list_issues, etc.

**Filesystem** (`@anthropic/mcp-filesystem`):
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-filesystem", "/allowed/path"]
    }
  }
}
```

Tools: read_file, write_file, list_directory, etc.

**Git** (`@anthropic/mcp-git`):
```json
{
  "mcpServers": {
    "git": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-git"]
    }
  }
}
```

Tools: git_status, git_diff, git_commit, etc.

### Databases

**PostgreSQL** (`@anthropic/mcp-postgres`):
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  }
}
```

Tools: query, list_tables, describe_table, etc.

**SQLite** (`@anthropic/mcp-sqlite`):
```json
{
  "mcpServers": {
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-sqlite", "/path/to/database.db"]
    }
  }
}
```

Tools: execute_query, list_tables, etc.

### APIs & Services

**Linear** (`@anthropic/mcp-linear`):
```json
{
  "mcpServers": {
    "linear": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-linear"],
      "env": {
        "LINEAR_API_KEY": "${LINEAR_API_KEY}"
      }
    }
  }
}
```

Tools: create_issue, list_issues, update_issue, etc.

**Slack** (`@modelcontextprotocol/server-slack`):
```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}"
      }
    }
  }
}
```

Tools: send_message, list_channels, etc.

### Documentation

**Context7** (`@anthropic/mcp-context7`):
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-context7"],
      "env": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    }
  }
}
```

Tools: resolve-library-id, query-docs, etc.

**Exa** (`@anthropic/mcp-exa`):
```json
{
  "mcpServers": {
    "exa": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-exa"],
      "env": {
        "EXA_API_KEY": "${EXA_API_KEY}"
      }
    }
  }
}
```

Tools: web_search_exa, get_code_context_exa, etc.

## Package Templates

### Handlebars Template (`mcp_servers.json.hbs`)

```handlebars
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
    {{#if vars.usePostgres}}
    ,
    "postgres": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
    {{/if}}
  }
}
```

## Merging Configurations

When adding to existing settings:

1. **Read existing file**:
   ```javascript
   const existing = JSON.parse(fs.readFileSync('.claude/settings.local.json'));
   ```

2. **Merge mcpServers**:
   ```javascript
   existing.mcpServers = {
     ...existing.mcpServers,
     "new-server": { ... }
   };
   ```

3. **Write back**:
   ```javascript
   fs.writeFileSync('.claude/settings.local.json', JSON.stringify(existing, null, 2));
   ```

## Environment Variables

### Setting Variables

**Shell**:
```bash
export GITHUB_TOKEN="ghp_..."
export DATABASE_URL="postgres://..."
```

**Dotenv** (`.env`):
```
GITHUB_TOKEN=ghp_...
DATABASE_URL=postgres://...
```

### Referencing in Config

Use `${VAR_NAME}` syntax:
```json
"env": {
  "API_KEY": "${MY_API_KEY}"
}
```

### Security Best Practices

1. **Never commit secrets**: Add `.claude/settings.local.json` to `.gitignore`
2. **Use environment variables**: Never hardcode tokens
3. **Rotate keys**: Update tokens periodically
4. **Minimal permissions**: Use tokens with least privilege

## Troubleshooting

### Server Not Starting

Check:
- Command exists (`which npx`)
- Package is installable (`npx -y @package/name --help`)
- Environment variables are set

### Tools Not Appearing

- Restart Claude Code after config changes
- Check server logs for errors
- Verify JSON/TOML syntax

### Permission Errors

- Check file permissions
- Verify API token scopes
- Check server-specific permissions

### Connection Issues

- Verify network access
- Check API endpoint status
- Review firewall settings

## Validation

### JSON Validation

```bash
cat .claude/settings.local.json | jq .
```

### TOML Validation

```bash
cat ~/.codex/config.toml | toml-cli validate
```

### Test Server

```bash
npx -y @anthropic/mcp-github --help
```

## File Locations Summary

| Platform | Local Config | User Config | Package Template |
|----------|--------------|-------------|------------------|
| Claude | `.claude/settings.local.json` | `~/.claude/settings.json` | `templates/claude/mcp_servers.json.hbs` |
| Codex | N/A | `~/.codex/config.toml` | `templates/codex/config.toml.hbs` |
| Gemini | `.gemini/settings.json` | N/A | `templates/gemini/settings.json.hbs` |
