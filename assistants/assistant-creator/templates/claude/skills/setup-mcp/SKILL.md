---
name: setup-mcp
description: Interactive wizard to set up MCP server credentials in your shell environment (~/.zshenv, ~/.bashrc, etc.). Activates when the user needs to configure API keys, tokens, or environment variables for MCP servers, or after adding new MCP integrations that require authentication.
---

# MCP Server Credential Setup Wizard

Guides the user through setting up environment variables for MCP server authentication. Since Terrazul passes MCP configuration via CLI flags, credentials must be persisted in shell environment files.

## Instructions

This is an **interactive** setup flow. Guide the user through ONE credential at a time using `AskUserQuestion` to confirm progress.

## Workflow

### Step 1: Detect Shell Environment

Determine the user's shell and appropriate config file:

```bash
echo $SHELL
```

| Shell | Recommended File | Alternative |
|-------|------------------|-------------|
| zsh | `~/.zshenv` | `~/.zshrc` |
| bash | `~/.bashrc` | `~/.bash_profile` |

**Why ~/.zshenv?** Environment variables in `.zshenv` are loaded for all shell sessions (interactive and non-interactive), ensuring MCP servers always have access to credentials.

Ask the user which file they want to use if multiple options exist. Default to `~/.zshenv` for zsh users.

### Step 2: Identify Required Credentials

Read the project's MCP configuration to find which environment variables are needed. Check:

1. `.claude/settings.local.json` - Local project MCP config
2. `templates/claude/mcp_servers.json.hbs` - Package MCP template
3. `.gemini/settings.json` - Gemini MCP config

Look for `${VAR_NAME}` patterns. Present a summary:
- MCP servers configured
- Environment variables needed for each
- Which are already set vs missing (check with `echo $VAR_NAME`)

### Step 3: Guide Through Each Credential

For each missing credential, provide service-specific instructions from `reference.md`. Ask the user to obtain the credential and provide it.

### Step 4: Add to Shell Profile

For each credential, append to the chosen profile file:

```bash
# MCP Server: [Server Name]
export VAR_NAME="value_here"
```

Group related variables with comments. Use double quotes around values. Add blank lines between different server configurations.

### Step 5: Verify Setup

1. Ask the user to source the profile:
   ```bash
   source ~/.zshenv  # or ~/.bashrc
   ```

2. Verify variables are set:
   ```bash
   echo $VAR_NAME
   ```

3. Run the test command for each service (see `reference.md` for test commands).

### Step 6: Success Summary

Provide a summary:
- List of configured credentials
- Reminder that new terminal sessions will have these variables
- Note that they may need to restart Claude Code for changes to take effect

## Troubleshooting

### Variable not found after sourcing
```bash
grep "VAR_NAME" ~/.zshenv
```

### Wrong shell profile
If using bash but `.bashrc` isn't loaded, try `.bash_profile` instead.

### Credentials not working
1. Verify the value is correct (no extra spaces or quotes)
2. Check that the token hasn't expired
3. Verify the token has required permissions/scopes
4. Try regenerating the credential

### Claude Code not seeing variables
Restart Claude Code after setting up credentials. The terminal session used by Claude must have the updated environment.
