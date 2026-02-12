# MCP Server Configuration Examples

Real-world examples of searching for and configuring MCP servers.

## Example 1: Adding GitHub Integration

**User Request**: "Add GitHub integration to my project"

**Search**:
```
site:mcp.so github
```

**Result**: Found `@anthropic/mcp-github`

**Configuration**:

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

**Installation Steps**:

1. Create GitHub personal access token:
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Create token with `repo` scope

2. Set environment variable:
   ```bash
   export GITHUB_TOKEN="ghp_your_token_here"
   ```

3. Add to `.claude/settings.local.json`

4. Restart Claude Code

**Available Tools**:
- `mcp__github__create_issue` - Create issues
- `mcp__github__create_pull_request` - Create PRs
- `mcp__github__list_issues` - List issues
- `mcp__github__get_file_contents` - Read repo files

---

## Example 2: Database Access with PostgreSQL

**User Request**: "Set up PostgreSQL MCP server"

**Search**:
```
site:mcp.so postgres database
```

**Result**: Found `@anthropic/mcp-postgres`

**Configuration**:

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

**Setup**:

1. Set connection string:
   ```bash
   export DATABASE_URL="postgres://user:pass@localhost:5432/mydb"
   ```

2. Add configuration to settings

3. Restart Claude Code

**Available Tools**:
- `mcp__postgres__query` - Run SQL queries
- `mcp__postgres__list_tables` - List all tables
- `mcp__postgres__describe_table` - Get table schema

**Security Note**: Use read-only credentials for safety.

---

## Example 3: Library Documentation with Context7

**User Request**: "I want to search library documentation"

**Search**:
```
site:mcp.so context7 documentation
```

**Result**: Found `@anthropic/mcp-context7`

**Configuration**:

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

**Available Tools**:
- `mcp__context7__resolve-library-id` - Find library identifiers
- `mcp__context7__query-docs` - Search documentation

**Usage Example**:
```
"Look up React hooks documentation using Context7"
```

---

## Example 4: Multiple Servers Configuration

**User Request**: "Set up GitHub, filesystem, and Git servers"

**Combined Configuration**:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-filesystem", "/Users/dev/projects"],
      "env": {}
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-git"],
      "env": {}
    }
  }
}
```

**Notes**:
- Filesystem server needs explicit path argument
- Git server works in current directory
- Each server can be disabled independently

---

## Example 5: Package Template with Conditional Servers

**User Request**: "Create a package template with optional database support"

**Template** (`templates/claude/mcp_servers.json.hbs`):

```handlebars
{{~ var useDatabase = askUser('Do you need database access? (yes/no)', { default: 'no' }) ~}}
{{~ var dbType = askUser('Which database?', { default: 'postgres' }) ~}}

{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
    {{#if (eq vars.useDatabase "yes")}}
    ,
    "{{vars.dbType}}": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-{{vars.dbType}}"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
    {{/if}}
  }
}
```

---

## Example 6: Codex Configuration (TOML)

**User Request**: "Configure MCP for Codex"

**File**: `~/.codex/config.toml`

```toml
[mcp_servers.github]
command = "npx"
args = ["-y", "@anthropic/mcp-github"]

[mcp_servers.github.env]
GITHUB_TOKEN = "${GITHUB_TOKEN}"

[mcp_servers.filesystem]
command = "npx"
args = ["-y", "@anthropic/mcp-filesystem", "/home/user/projects"]

[mcp_servers.postgres]
command = "npx"
args = ["-y", "@anthropic/mcp-postgres"]

[mcp_servers.postgres.env]
DATABASE_URL = "${DATABASE_URL}"
```

---

## Example 7: Gemini Configuration

**User Request**: "Set up MCP for Gemini CLI"

**File**: `.gemini/settings.json`

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-filesystem", "."],
      "env": {}
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-git"],
      "env": {}
    }
  }
}
```

---

## Example 8: Slack Integration

**User Request**: "Add Slack messaging to my project"

**Search**:
```
site:mcp.so slack
```

**Result**: Found `@modelcontextprotocol/server-slack`

**Configuration**:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
        "SLACK_TEAM_ID": "${SLACK_TEAM_ID}"
      }
    }
  }
}
```

**Setup**:

1. Create Slack App at https://api.slack.com/apps
2. Add bot scopes: `chat:write`, `channels:read`, `users:read`
3. Install to workspace
4. Copy Bot Token (`xoxb-...`)

---

## Example 9: Merging with Existing Config

**Scenario**: Adding to existing settings file

**Existing** (`.claude/settings.local.json`):
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

**Adding Linear**:

1. Read existing file
2. Add new server:
   ```json
   {
     "mcpServers": {
       "github": { ... },
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
3. Write merged config
4. Restart Claude Code

---

## Example 10: Disabling a Server

**Scenario**: Temporarily disable a server without removing config

**Before**:
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

**After** (disabled):
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      },
      "disabled": true
    }
  }
}
```

---

## Common Configurations Reference

### Full Development Setup

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": { "GITHUB_TOKEN": "${GITHUB_TOKEN}" }
    },
    "git": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-git"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-filesystem", "."]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-context7"],
      "env": { "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}" }
    }
  }
}
```

### Database Development Setup

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-postgres"],
      "env": { "DATABASE_URL": "${DATABASE_URL}" }
    },
    "redis": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-redis"],
      "env": { "REDIS_URL": "${REDIS_URL}" }
    }
  }
}
```

### Documentation/Research Setup

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-context7"],
      "env": { "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}" }
    },
    "exa": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-exa"],
      "env": { "EXA_API_KEY": "${EXA_API_KEY}" }
    }
  }
}
```
