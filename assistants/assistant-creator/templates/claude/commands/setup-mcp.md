---
name: setup-mcp
description: Interactive wizard to set up MCP server credentials in your shell environment (~/.zshenv, ~/.bashrc, etc.)
---

# MCP Server Credential Setup Wizard

Guide the user through setting up environment variables for MCP server authentication. Since Terrazul passes MCP configuration via CLI flags, credentials must be persisted in shell environment files.

## Instructions

This is an **interactive** setup flow. Guide the user through ONE credential at a time using `AskUserQuestion` to confirm progress.

---

## Step 0: Detect Shell Environment

First, determine the user's shell and appropriate config file:

```bash
echo $SHELL
```

| Shell | Recommended File | Alternative |
|-------|------------------|-------------|
| zsh | `~/.zshenv` | `~/.zshrc` |
| bash | `~/.bashrc` | `~/.bash_profile` |

**Why ~/.zshenv?** Environment variables in `.zshenv` are loaded for all shell sessions (interactive and non-interactive), ensuring MCP servers always have access to credentials.

Ask the user which file they want to use if multiple options exist. Default to `~/.zshenv` for zsh users.

---

## Step 1: Identify Required Credentials

Read the package's MCP configuration to identify which environment variables are needed. Look in these locations:

1. `.claude/settings.local.json` - Local project MCP config
2. `templates/claude/mcp_servers.json.hbs` - Package MCP template
3. `.gemini/settings.json` - Gemini MCP config

Look for `${VAR_NAME}` patterns in the configuration files.

Present a summary to the user:
- List of MCP servers configured
- Environment variables needed for each
- Which are already set vs missing (check with `echo $VAR_NAME`)

---

## Step 2: Guide Through Each Credential

For each missing credential, provide service-specific instructions from the reference below. Ask the user to obtain the credential and provide it.

### GitHub (`GITHUB_TOKEN`)

**How to obtain:**
1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Select scopes: `repo`, `read:org`, `read:user`
4. Generate and copy the token

**Test command:**
```bash
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
```

### HubSpot (`HUBSPOT_ACCESS_TOKEN`)

**How to obtain:**
1. Go to HubSpot → Settings → Integrations → Private Apps
2. Create a new private app
3. Grant required scopes (contacts, companies, deals as needed)
4. Copy the access token

**Test command:**
```bash
curl -H "Authorization: Bearer $HUBSPOT_ACCESS_TOKEN" https://api.hubapi.com/crm/v3/objects/contacts?limit=1
```

### Slack (`SLACK_BOT_TOKEN`)

**How to obtain:**
1. Go to https://api.slack.com/apps
2. Create or select your app
3. Navigate to "OAuth & Permissions"
4. Copy the "Bot User OAuth Token" (starts with `xoxb-`)

**Test command:**
```bash
curl -H "Authorization: Bearer $SLACK_BOT_TOKEN" https://slack.com/api/auth.test
```

### Linear (`LINEAR_API_KEY`)

**How to obtain:**
1. Go to Linear → Settings → API
2. Create a new personal API key
3. Copy the key

**Test command:**
```bash
curl -H "Authorization: $LINEAR_API_KEY" https://api.linear.app/graphql -d '{"query": "{ viewer { id } }"}'
```

### PostgreSQL (`DATABASE_URL`)

**Format:**
```
postgresql://username:password@host:port/database
```

**Test command:**
```bash
psql "$DATABASE_URL" -c "SELECT 1"
```

### PostHog (`POSTHOG_API_KEY`, `POSTHOG_PROJECT_ID`)

**How to obtain:**
1. Go to PostHog → Settings → Personal API Keys
2. Create a new key
3. Copy the project ID from your project URL

### Discord (`DISCORD_BOT_TOKEN`)

**How to obtain:**
1. Go to https://discord.com/developers/applications
2. Select your application → Bot
3. Click "Reset Token" or copy existing token

### Context7 (`CONTEXT7_API_KEY`)

**How to obtain:**
1. Go to https://context7.com/dashboard
2. Navigate to API Keys section
3. Generate a new key

### Exa (`EXA_API_KEY`)

**How to obtain:**
1. Go to https://exa.ai/dashboard
2. Navigate to API section
3. Copy your API key

### Meta Ads (`META_ACCESS_TOKEN`, `META_AD_ACCOUNT_ID`)

**How to obtain:**
1. Go to Meta Business Suite → Business Settings
2. Navigate to System Users
3. Generate a token with ads_management permission
4. Copy your Ad Account ID from Ads Manager

### Garmin (`GARMIN_EMAIL`, `GARMIN_PASSWORD`)

**Note:** These are your Garmin Connect account credentials. Use app-specific password if available.

---

## Step 3: Add to Shell Profile

For each credential, append to the chosen profile file using the Edit tool:

```bash
# MCP Server: [Server Name]
export VAR_NAME="value_here"
```

**Important:**
- Group related variables together with comments
- Use double quotes around values
- Add a blank line between different server configurations

**Example additions:**
```bash
# MCP Server: GitHub
export GITHUB_TOKEN="ghp_xxxxxxxxxxxx"

# MCP Server: Slack
export SLACK_BOT_TOKEN="xoxb-xxxxxxxxxxxx"
```

---

## Step 4: Verify Setup

After adding credentials:

1. Ask the user to source the profile:
   ```bash
   source ~/.zshenv  # or ~/.bashrc
   ```

2. Verify variables are set:
   ```bash
   echo $VAR_NAME
   ```

3. Run the test command for each service to verify the credentials work.

---

## Step 5: Success Summary

Provide a summary:
- List of configured credentials
- Reminder that new terminal sessions will have these variables
- Note that they may need to restart Claude Code for changes to take effect
- Quick reference for re-running `/setup-mcp` if needed

---

## Troubleshooting

### Variable not found after sourcing

Check that the export was added correctly:
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
