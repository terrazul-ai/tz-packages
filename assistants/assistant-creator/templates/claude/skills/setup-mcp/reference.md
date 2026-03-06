# MCP Credential Reference

Service-specific instructions for obtaining and testing MCP server credentials.

## GitHub (`GITHUB_TOKEN`)

**How to obtain:**
1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Select scopes: `repo`, `read:org`, `read:user`
4. Generate and copy the token

**Test command:**
```bash
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user
```

## HubSpot (`HUBSPOT_ACCESS_TOKEN`)

**How to obtain:**
1. Go to HubSpot → Settings → Integrations → Private Apps
2. Create a new private app
3. Grant required scopes (contacts, companies, deals as needed)
4. Copy the access token

**Test command:**
```bash
curl -H "Authorization: Bearer $HUBSPOT_ACCESS_TOKEN" https://api.hubapi.com/crm/v3/objects/contacts?limit=1
```

## Slack (`SLACK_BOT_TOKEN`)

**How to obtain:**
1. Go to https://api.slack.com/apps
2. Create or select your app
3. Navigate to "OAuth & Permissions"
4. Copy the "Bot User OAuth Token" (starts with `xoxb-`)

**Test command:**
```bash
curl -H "Authorization: Bearer $SLACK_BOT_TOKEN" https://slack.com/api/auth.test
```

## Linear (`LINEAR_API_KEY`)

**How to obtain:**
1. Go to Linear → Settings → API
2. Create a new personal API key
3. Copy the key

**Test command:**
```bash
curl -H "Authorization: $LINEAR_API_KEY" https://api.linear.app/graphql -d '{"query": "{ viewer { id } }"}'
```

## PostgreSQL (`DATABASE_URL`)

**Format:**
```
postgresql://username:password@host:port/database
```

**Test command:**
```bash
psql "$DATABASE_URL" -c "SELECT 1"
```

## PostHog (`POSTHOG_API_KEY`, `POSTHOG_PROJECT_ID`)

**How to obtain:**
1. Go to PostHog → Settings → Personal API Keys
2. Create a new key
3. Copy the project ID from your project URL

**Test command:**
```bash
curl -H "Authorization: Bearer $POSTHOG_API_KEY" "https://app.posthog.com/api/projects/$POSTHOG_PROJECT_ID/"
```

## Discord (`DISCORD_BOT_TOKEN`)

**How to obtain:**
1. Go to https://discord.com/developers/applications
2. Select your application → Bot
3. Click "Reset Token" or copy existing token

**Test command:**
```bash
curl -H "Authorization: Bot $DISCORD_BOT_TOKEN" https://discord.com/api/v10/users/@me
```

## Context7 (`CONTEXT7_API_KEY`)

**How to obtain:**
1. Go to https://context7.com/dashboard
2. Navigate to API Keys section
3. Generate a new key

**Test command:**
```bash
curl -H "Authorization: Bearer $CONTEXT7_API_KEY" https://api.context7.com/v1/status
```

## Exa (`EXA_API_KEY`)

**How to obtain:**
1. Go to https://exa.ai/dashboard
2. Navigate to API section
3. Copy your API key

**Test command:**
```bash
curl -H "x-api-key: $EXA_API_KEY" "https://api.exa.ai/search" -d '{"query":"test","numResults":1}' -H "Content-Type: application/json"
```

## Meta Ads (`META_ACCESS_TOKEN`, `META_AD_ACCOUNT_ID`)

**How to obtain:**
1. Go to Meta Business Suite → Business Settings
2. Navigate to System Users
3. Generate a token with ads_management permission
4. Copy your Ad Account ID from Ads Manager

**Test command:**
```bash
curl "https://graph.facebook.com/v18.0/me?access_token=$META_ACCESS_TOKEN"
```

## Garmin (`GARMIN_EMAIL`, `GARMIN_PASSWORD`)

**Note:** These are your Garmin Connect account credentials. Use app-specific password if available.

**Test command:**
No direct API test available. Credentials are validated when the MCP server connects to Garmin.
