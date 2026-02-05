# MCP Server Credentials Reference

This document provides detailed instructions for obtaining and configuring credentials for popular MCP servers. Use this as a reference when running `/setup-mcp` or manually configuring MCP server authentication.

---

## Quick Reference Table

| Server | Environment Variables | How to Obtain |
|--------|----------------------|---------------|
| GitHub | `GITHUB_TOKEN` | Settings → Developer settings → Personal access tokens |
| HubSpot | `HUBSPOT_ACCESS_TOKEN` | Settings → Integrations → Private Apps |
| Slack | `SLACK_BOT_TOKEN` | api.slack.com → OAuth & Permissions |
| PostgreSQL | `DATABASE_URL` | Connection string from database provider |
| Linear | `LINEAR_API_KEY` | Settings → API |
| PostHog | `POSTHOG_API_KEY`, `POSTHOG_PROJECT_ID` | Settings → Personal API Keys |
| Discord | `DISCORD_BOT_TOKEN` | Developer Portal → Bot → Token |
| Context7 | `CONTEXT7_API_KEY` | context7.com dashboard |
| Exa | `EXA_API_KEY` | exa.ai dashboard |
| Meta Ads | `META_ACCESS_TOKEN`, `META_AD_ACCOUNT_ID` | Business Settings → System Users |
| Garmin | `GARMIN_EMAIL`, `GARMIN_PASSWORD` | Garmin Connect account credentials |
| Notion | `NOTION_TOKEN` | Settings → Integrations → Create integration |
| Airtable | `AIRTABLE_API_KEY` | Account → Developer hub → Personal access tokens |
| Jira | `JIRA_API_TOKEN`, `JIRA_EMAIL`, `JIRA_URL` | Atlassian account settings |
| AWS | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | IAM console |
| Google | `GOOGLE_APPLICATION_CREDENTIALS` | Google Cloud Console → Service accounts |

---

## Detailed Setup Instructions

### GitHub (`GITHUB_TOKEN`)

**Purpose:** Access GitHub APIs for repository, issue, and PR operations.

**Required Scopes:**
- `repo` - Full control of private repositories
- `read:org` - Read organization membership
- `read:user` - Read user profile data

**How to obtain:**
1. Navigate to https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Add a descriptive note (e.g., "MCP Server - Claude Code")
4. Select expiration (recommend 90 days or custom)
5. Check the required scopes: `repo`, `read:org`, `read:user`
6. Click **"Generate token"**
7. **Copy the token immediately** - it won't be shown again

**Test command:**
```bash
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
```

**Expected response:** JSON with your GitHub user profile

**Troubleshooting:**
- "Bad credentials" → Token is invalid or expired
- "Not Found" → Token lacks required scopes
- 403 Forbidden → Rate limit or IP restrictions

---

### HubSpot (`HUBSPOT_ACCESS_TOKEN`)

**Purpose:** Access HubSpot CRM for contacts, companies, deals, and more.

**How to obtain:**
1. Log into HubSpot
2. Go to **Settings** (gear icon) → **Integrations** → **Private Apps**
3. Click **"Create a private app"**
4. Name your app (e.g., "MCP Server Integration")
5. Go to **Scopes** tab and select required scopes:
   - `crm.objects.contacts.read` - Read contacts
   - `crm.objects.companies.read` - Read companies
   - `crm.objects.deals.read` - Read deals
   - Add write scopes if needed
6. Click **"Create app"**
7. Copy the **Access token**

**Test command:**
```bash
curl -H "Authorization: Bearer $HUBSPOT_ACCESS_TOKEN" \
  "https://api.hubapi.com/crm/v3/objects/contacts?limit=1"
```

**Expected response:** JSON with contacts (or empty results array)

**Troubleshooting:**
- 401 Unauthorized → Token is invalid
- 403 Forbidden → Missing required scopes

---

### Slack (`SLACK_BOT_TOKEN`)

**Purpose:** Send messages, read channels, and interact with Slack workspaces.

**Required Scopes (common):**
- `channels:read` - View basic channel info
- `chat:write` - Send messages
- `users:read` - View users
- Add more based on your needs

**How to obtain:**
1. Go to https://api.slack.com/apps
2. Click **"Create New App"** → **"From scratch"**
3. Name your app and select workspace
4. Go to **"OAuth & Permissions"** in the sidebar
5. Under **"Scopes"** → **"Bot Token Scopes"**, add required scopes
6. Click **"Install to Workspace"** at the top
7. Authorize the app
8. Copy the **"Bot User OAuth Token"** (starts with `xoxb-`)

**Test command:**
```bash
curl -H "Authorization: Bearer $SLACK_BOT_TOKEN" https://slack.com/api/auth.test
```

**Expected response:** JSON with `"ok": true` and bot info

**Troubleshooting:**
- `"ok": false` → Check error field for details
- "invalid_auth" → Token is invalid or revoked

---

### Linear (`LINEAR_API_KEY`)

**Purpose:** Access Linear for issue tracking and project management.

**How to obtain:**
1. Go to Linear → **Settings** (gear icon)
2. Navigate to **"API"** section
3. Click **"Create key"** under Personal API keys
4. Add a label (e.g., "MCP Server")
5. Copy the API key

**Test command:**
```bash
curl -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "{ viewer { id name } }"}'
```

**Expected response:** JSON with your Linear user info

---

### PostgreSQL (`DATABASE_URL`)

**Purpose:** Connect to PostgreSQL databases for queries and operations.

**Format:**
```
postgresql://username:password@host:port/database?sslmode=require
```

**Components:**
- `username` - Database user
- `password` - Database password (URL-encoded if special characters)
- `host` - Database server hostname
- `port` - Database port (default: 5432)
- `database` - Database name
- `sslmode` - SSL mode (require, disable, etc.)

**Examples:**
```bash
# Local development
DATABASE_URL="postgresql://postgres:password@localhost:5432/mydb"

# Heroku
DATABASE_URL="postgresql://user:pass@ec2-xx-xx-xx-xx.compute-1.amazonaws.com:5432/dbname?sslmode=require"

# Supabase
DATABASE_URL="postgresql://postgres:password@db.xxxx.supabase.co:5432/postgres"
```

**Test command:**
```bash
psql "$DATABASE_URL" -c "SELECT 1"
```

**Troubleshooting:**
- "connection refused" → Check host/port, firewall rules
- "authentication failed" → Verify username/password
- "SSL required" → Add `?sslmode=require` to URL

---

### PostHog (`POSTHOG_API_KEY`, `POSTHOG_PROJECT_ID`)

**Purpose:** Access PostHog analytics data.

**How to obtain:**

**POSTHOG_API_KEY:**
1. Go to PostHog → **Settings** → **Personal API Keys**
2. Click **"Create personal API key"**
3. Add a label and copy the key

**POSTHOG_PROJECT_ID:**
1. Go to your project in PostHog
2. Look at the URL: `https://app.posthog.com/project/12345/...`
3. The number (`12345`) is your project ID

**Test command:**
```bash
curl "https://app.posthog.com/api/projects/$POSTHOG_PROJECT_ID/" \
  -H "Authorization: Bearer $POSTHOG_API_KEY"
```

---

### Discord (`DISCORD_BOT_TOKEN`)

**Purpose:** Interact with Discord servers via bot.

**How to obtain:**
1. Go to https://discord.com/developers/applications
2. Click **"New Application"** or select existing
3. Go to **"Bot"** in the sidebar
4. Click **"Reset Token"** (or view existing if available)
5. Copy the token

**Important:** Keep this token secret - it provides full bot access.

**Test command:**
```bash
curl -H "Authorization: Bot $DISCORD_BOT_TOKEN" \
  https://discord.com/api/v10/users/@me
```

---

### Context7 (`CONTEXT7_API_KEY`)

**Purpose:** Access library documentation and code examples.

**How to obtain:**
1. Go to https://context7.com
2. Sign in or create an account
3. Navigate to **Dashboard** → **API Keys**
4. Generate a new API key

---

### Exa (`EXA_API_KEY`)

**Purpose:** AI-powered code and web search.

**How to obtain:**
1. Go to https://exa.ai
2. Sign in or create an account
3. Navigate to **Dashboard** → **API**
4. Copy your API key

---

### Meta Ads (`META_ACCESS_TOKEN`, `META_AD_ACCOUNT_ID`)

**Purpose:** Access Meta (Facebook/Instagram) advertising APIs.

**How to obtain:**

**META_ACCESS_TOKEN:**
1. Go to Meta Business Suite → **Business Settings**
2. Navigate to **Users** → **System Users**
3. Create or select a system user
4. Click **"Generate new token"**
5. Select the app and required permissions:
   - `ads_management`
   - `ads_read`
6. Generate and copy the token

**META_AD_ACCOUNT_ID:**
1. Go to Meta Ads Manager
2. Look at the URL or account selector
3. Copy the ad account ID (format: `act_123456789`)

**Test command:**
```bash
curl "https://graph.facebook.com/v18.0/$META_AD_ACCOUNT_ID" \
  -H "Authorization: Bearer $META_ACCESS_TOKEN"
```

---

### Garmin (`GARMIN_EMAIL`, `GARMIN_PASSWORD`)

**Purpose:** Access Garmin Connect fitness data.

**How to obtain:**
- Use your Garmin Connect account credentials
- Consider using an app-specific password if available

**Security note:** These are your actual account credentials. Ensure they're stored securely and consider:
- Using a dedicated account for API access
- Enabling two-factor authentication on your main account

---

### Notion (`NOTION_TOKEN`)

**Purpose:** Access Notion pages, databases, and content.

**How to obtain:**
1. Go to https://www.notion.so/my-integrations
2. Click **"+ New integration"**
3. Name your integration
4. Select the workspace
5. Copy the **"Internal Integration Token"**

**Important:** Share pages/databases with your integration for access.

---

### Airtable (`AIRTABLE_API_KEY`)

**Purpose:** Access Airtable bases and records.

**How to obtain:**
1. Go to https://airtable.com/account
2. Navigate to **Developer hub** → **Personal access tokens**
3. Click **"Create token"**
4. Add scopes and base access
5. Copy the token

---

### Jira (`JIRA_API_TOKEN`, `JIRA_EMAIL`, `JIRA_URL`)

**Purpose:** Access Jira for issue tracking.

**How to obtain:**
1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click **"Create API token"**
3. Name your token and copy it

**JIRA_URL format:** `https://your-domain.atlassian.net`

---

### AWS (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)

**Purpose:** Access AWS services.

**How to obtain:**
1. Go to AWS IAM Console
2. Navigate to **Users** → Select your user
3. Go to **Security credentials** tab
4. Click **"Create access key"**
5. Copy both the Access Key ID and Secret Access Key

**Security best practices:**
- Use IAM users with minimal required permissions
- Rotate keys regularly
- Never commit keys to version control

---

### Google (`GOOGLE_APPLICATION_CREDENTIALS`)

**Purpose:** Access Google Cloud services.

**How to obtain:**
1. Go to Google Cloud Console → **IAM & Admin** → **Service Accounts**
2. Create or select a service account
3. Click **"Keys"** tab → **"Add Key"** → **"Create new key"**
4. Select JSON format
5. Save the downloaded file

**Configuration:**
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account-key.json"
```

---

## Security Best Practices

1. **Never commit credentials to version control**
   - Add sensitive files to `.gitignore`
   - Use environment variables, not config files

2. **Use minimal permissions**
   - Only grant scopes/permissions actually needed
   - Prefer read-only access when possible

3. **Rotate credentials regularly**
   - Set expiration dates on tokens
   - Rotate after team member departures

4. **Store securely**
   - Use `~/.zshenv` or `~/.bashrc` (not world-readable)
   - Consider using a secrets manager for production

5. **Audit access**
   - Review which services have access
   - Remove unused integrations

---

## Shell Profile Locations

| Shell | Primary File | Alternative |
|-------|-------------|-------------|
| zsh | `~/.zshenv` | `~/.zshrc` |
| bash | `~/.bashrc` | `~/.bash_profile` |
| fish | `~/.config/fish/config.fish` | - |

**Recommendation:** Use `~/.zshenv` for zsh as it's loaded for all session types (interactive, non-interactive, login, non-login).

---

## Troubleshooting Common Issues

### Environment variable not found

```bash
# Check if variable is set
echo $VAR_NAME

# Check shell profile
grep "VAR_NAME" ~/.zshenv ~/.zshrc ~/.bashrc 2>/dev/null

# Source the profile
source ~/.zshenv
```

### Token expired or invalid

1. Check service dashboard for expiration
2. Regenerate the token
3. Update shell profile
4. Source profile and restart Claude Code

### Permission denied errors

1. Verify token has required scopes
2. Check IP/network restrictions
3. Ensure resource is shared with integration (Notion, etc.)

### Rate limiting

1. Implement backoff in requests
2. Check service's rate limit documentation
3. Consider upgrading service tier
