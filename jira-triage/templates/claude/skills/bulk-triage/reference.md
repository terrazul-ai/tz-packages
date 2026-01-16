# Bulk Triage Reference

Quick reference for JQL queries, JIRA CLI commands, and bulk operations.

---

## JQL Query Library

### By Triage Status

#### All Untriaged Tickets
```jql
project={{ vars.jiraProject }} AND labels NOT IN ({{ vars.triageLabel }}) AND status=Open
```

#### Recently Triaged (Last 24h)
```jql
project={{ vars.jiraProject }} AND labels IN ({{ vars.triageLabel }}) AND updated >= -1d
```

#### Needs Re-triage (Triaged but Priority Empty)
```jql
project={{ vars.jiraProject }} AND labels IN ({{ vars.triageLabel }}) AND priority = EMPTY
```

---

### By Time

#### Created Today
```jql
project={{ vars.jiraProject }} AND created >= startOfDay()
```

#### Created This Week
```jql
project={{ vars.jiraProject }} AND created >= startOfWeek()
```

#### Created in Last N Days
```jql
project={{ vars.jiraProject }} AND created >= -7d
```

#### Older Than 7 Days
```jql
project={{ vars.jiraProject }} AND created < -7d AND status=Open
```

#### Older Than 30 Days
```jql
project={{ vars.jiraProject }} AND created < -30d AND status=Open
```

#### Updated in Last N Hours
```jql
project={{ vars.jiraProject }} AND updated >= -4h
```

#### Not Updated in 7 Days (Stale)
```jql
project={{ vars.jiraProject }} AND updated < -7d AND status IN (Open, "In Progress")
```

---

### By Priority

#### No Priority Set
```jql
project={{ vars.jiraProject }} AND priority = EMPTY AND status=Open
```

#### High and Highest Only
```jql
project={{ vars.jiraProject }} AND priority IN (Highest, High) AND status IN (Open, "In Progress")
```

#### Low Priority Backlog
```jql
project={{ vars.jiraProject }} AND priority = Low AND status=Open
```

---

### By Assignment

#### Unassigned
```jql
project={{ vars.jiraProject }} AND assignee = EMPTY AND status=Open
```

#### Assigned to Current User
```jql
project={{ vars.jiraProject }} AND assignee = currentUser() AND status IN (Open, "In Progress")
```

#### Assigned to Specific Team
```jql
project={{ vars.jiraProject }} AND assignee IN (alice, bob, carol) AND status IN (Open, "In Progress")
```

---

### By SLA Status

#### Approaching SLA (< N hours remaining)
```jql
project={{ vars.jiraProject }} AND created < -{{ vars.slaHours }}h AND status=Open
```

#### No Response Yet
```jql
project={{ vars.jiraProject }} AND comment is EMPTY AND created > -{{ vars.slaHours }}h
```

#### Urgent + No Response
```jql
project={{ vars.jiraProject }} AND priority IN (Highest, High) AND comment is EMPTY AND status=Open
```

---

### By Issue Type

#### All Bugs
```jql
project={{ vars.jiraProject }} AND type = Bug AND status IN (Open, "In Progress")
```

#### All Feature Requests
```jql
project={{ vars.jiraProject }} AND type IN ("Feature Request", Enhancement) AND status=Open
```

#### All Questions
```jql
project={{ vars.jiraProject }} AND type IN (Question, "How-To") AND status=Open
```

---

### By Urgency Keywords

#### Urgent Keywords in Summary or Description
```jql
project={{ vars.jiraProject }} AND (summary ~ "urgent" OR summary ~ "critical" OR summary ~ "emergency" OR description ~ "urgent" OR description ~ "critical")
```

#### Production Issues
```jql
project={{ vars.jiraProject }} AND (summary ~ "production" OR description ~ "production" OR summary ~ "outage" OR description ~ "outage")
```

#### Data Loss Reports
```jql
project={{ vars.jiraProject }} AND (summary ~ "data loss" OR description ~ "data loss" OR summary ~ "deleted" OR description ~ "deleted")
```

#### Security Keywords
```jql
project={{ vars.jiraProject }} AND (summary ~ "security" OR description ~ "security" OR summary ~ "vulnerability" OR description ~ "breach")
```

---

### By Labels

#### Specific Label
```jql
project={{ vars.jiraProject }} AND labels IN (bug, urgent)
```

#### Multiple Labels (AND)
```jql
project={{ vars.jiraProject }} AND labels IN (bug) AND labels IN (backend)
```

#### Multiple Labels (OR)
```jql
project={{ vars.jiraProject }} AND labels IN (bug, feature-request, question)
```

#### Exclude Labels
```jql
project={{ vars.jiraProject }} AND labels NOT IN (duplicate, invalid, wontfix)
```

---

### By Components

#### Specific Component
```jql
project={{ vars.jiraProject }} AND component = "Backend API"
```

#### No Component Set
```jql
project={{ vars.jiraProject }} AND component is EMPTY AND status=Open
```

---

### Combined Queries

#### High-Value Triage Candidates
```jql
project={{ vars.jiraProject }} AND labels NOT IN ({{ vars.triageLabel }}) AND (priority = EMPTY OR priority IN (Highest, High)) AND status=Open
```

#### Backlog Cleanup Candidates
```jql
project={{ vars.jiraProject }} AND created < -30d AND status=Open AND priority IN (Low, Medium, EMPTY)
```

#### Morning Triage Queue
```jql
project={{ vars.jiraProject }} AND created >= -1d AND labels NOT IN ({{ vars.triageLabel }}) ORDER BY created ASC
```

#### Weekly Review Queue
```jql
project={{ vars.jiraProject }} AND created >= -7d AND (labels NOT IN ({{ vars.triageLabel }}) OR priority = EMPTY) ORDER BY priority DESC, created ASC
```

---

## JIRA CLI Commands

### Listing Tickets

#### Basic List
```bash
jira issue list --project={{ vars.jiraProject }} --status=Open
```

#### List with JQL
```bash
jira issue list --jql="project={{ vars.jiraProject }} AND labels NOT IN ({{ vars.triageLabel }})"
```

#### List in JSON Format
```bash
jira issue list --jql="..." --format=json
```

#### List with Specific Columns
```bash
jira issue list --jql="..." --plain --columns="key,summary,priority,status,created" --no-headers
```

#### List with Limit
```bash
jira issue list --jql="..." --limit=50
```

---

### Viewing Tickets

#### View Single Ticket
```bash
jira issue view SUPPORT-123
```

#### View in JSON Format
```bash
jira issue view SUPPORT-123 --format=json
```

#### View with Comments
```bash
jira issue view SUPPORT-123 --comments
```

---

### Updating Tickets

#### Update Priority
```bash
jira issue update SUPPORT-123 --priority=High
```

#### Add Labels (Append)
```bash
# Get current labels first
current_labels=$(jira issue view SUPPORT-123 --format=json | jq -r '.fields.labels | join(",")')

# Add new label
jira issue update SUPPORT-123 --labels="${current_labels},{{ vars.triageLabel }}"
```

#### Set Labels (Replace)
```bash
jira issue update SUPPORT-123 --labels="{{ vars.triageLabel }},bug,backend"
```

#### Assign Ticket
```bash
jira issue update SUPPORT-123 --assignee=john.doe
```

#### Update Multiple Fields
```bash
jira issue update SUPPORT-123 --priority=High --assignee=alice --labels={{ vars.triageLabel }},urgent
```

---

### Adding Comments

#### Simple Comment
```bash
jira issue comment add SUPPORT-123 --comment="Triaged as High priority - investigating now."
```

#### Multi-line Comment
```bash
jira issue comment add SUPPORT-123 --comment="Triage Analysis:
- Priority: High (production impact)
- Assigned to: Backend team
- ETA: 4 hours"
```

---

### Transitioning Status

#### Move to Status
```bash
jira issue move SUPPORT-123 --status="In Progress"
```

#### List Available Transitions
```bash
jira issue list-transitions SUPPORT-123
```

---

### Linking Tickets

#### Link as Duplicate
```bash
jira issue link SUPPORT-145 SUPPORT-123 --type="duplicates"
```

#### Link as Related
```bash
jira issue link SUPPORT-145 SUPPORT-123 --type="relates to"
```

#### Link as Blocks
```bash
jira issue link SUPPORT-145 SUPPORT-123 --type="blocks"
```

---

## Bulk Operations

### Batch Update Priority

```bash
# Update priority for multiple tickets
for ticket in SUPPORT-123 SUPPORT-145 SUPPORT-167; do
  echo "Updating $ticket..."
  jira issue update $ticket --priority=High --labels={{ vars.triageLabel }},urgent
done
```

---

### Batch Add Comments

```bash
# Add triage comment to multiple tickets
tickets="SUPPORT-123 SUPPORT-145 SUPPORT-167"
comment="Triaged as High priority - backend team investigating."

for ticket in $tickets; do
  echo "Adding comment to $ticket..."
  jira issue comment add $ticket --comment="$comment"
done
```

---

### Batch Assign to Team

```bash
# Assign multiple tickets to backend team
backend_tickets="SUPPORT-123 SUPPORT-145 SUPPORT-167"

for ticket in $backend_tickets; do
  echo "Assigning $ticket to backend team..."
  jira issue update $ticket --assignee=backend-lead --labels={{ vars.triageLabel }},backend
  jira issue comment add $ticket --comment="Routed to backend team for investigation."
done
```

---

### Link Duplicates and Close

```bash
# Link duplicate tickets to master and close them
master_ticket="SUPPORT-123"
duplicate_tickets="SUPPORT-145 SUPPORT-167 SUPPORT-189"

for ticket in $duplicate_tickets; do
  echo "Linking $ticket as duplicate of $master_ticket..."
  jira issue link $ticket $master_ticket --type="duplicates"
  jira issue move $ticket --status="Closed"
  jira issue comment add $ticket --comment="Closed as duplicate of $master_ticket"
done
```

---

### Batch Processing from JQL Query

```bash
# Get all ticket keys matching criteria
tickets=$(jira issue list \
  --jql="project={{ vars.jiraProject }} AND labels NOT IN ({{ vars.triageLabel }}) AND created >= -1d" \
  --plain \
  --columns=key \
  --no-headers)

# Process each ticket
for ticket in $tickets; do
  echo "Processing $ticket..."

  # Fetch ticket details
  jira issue view $ticket --format=json > /tmp/${ticket}.json

  # Add your analysis logic here
  # For example, check for urgency keywords and update priority

  # Mark as triaged
  jira issue update $ticket --labels={{ vars.triageLabel }}
done
```

---

### Export Batch to CSV

```bash
# Export ticket list to CSV for analysis
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -7d" \
  --plain \
  --columns="key,summary,priority,status,created,assignee" \
  > /tmp/triage-batch-$(date +%Y%m%d).csv
```

---

## Common Patterns

### Pattern 1: Morning Triage Workflow

```bash
#!/bin/bash
# Morning triage: Process overnight tickets

echo "Fetching overnight tickets..."
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -12h AND labels NOT IN ({{ vars.triageLabel }})" \
  --plain --columns="key,summary,priority" > /tmp/morning-triage.txt

ticket_count=$(wc -l < /tmp/morning-triage.txt)
echo "Found $ticket_count tickets to triage"

# Export for bulk analysis
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -12h AND labels NOT IN ({{ vars.triageLabel }})" \
  --format=json > /tmp/morning-triage.json

echo "Use bulk-triage skill to analyze /tmp/morning-triage.json"
```

---

### Pattern 2: SLA Compliance Check

```bash
#!/bin/bash
# Check tickets approaching SLA deadline

sla_hours={{ vars.slaHours }}
cutoff_hours=$((sla_hours - 2))  # Alert 2 hours before SLA breach

echo "Checking for tickets approaching ${sla_hours}h SLA..."
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created < -${cutoff_hours}h AND created > -${sla_hours}h AND comment is EMPTY AND status=Open" \
  --plain --columns="key,summary,created" > /tmp/sla-at-risk.txt

at_risk=$(wc -l < /tmp/sla-at-risk.txt)

if [ $at_risk -gt 0 ]; then
  echo "WARNING: $at_risk tickets at risk of SLA breach!"
  cat /tmp/sla-at-risk.txt
else
  echo "All tickets within SLA compliance"
fi
```

---

### Pattern 3: Weekly Pattern Detection

```bash
#!/bin/bash
# Weekly triage: Look for patterns in last 7 days

echo "Analyzing tickets from last 7 days for patterns..."

# Get all tickets
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -7d" \
  --format=json > /tmp/weekly-tickets.json

# Count by type
echo -e "\n=== Issue Types ==="
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -7d" \
  --plain --columns=type --no-headers | sort | uniq -c | sort -rn

# Count by priority
echo -e "\n=== Priorities ==="
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -7d" \
  --plain --columns=priority --no-headers | sort | uniq -c | sort -rn

# Find common keywords in summaries
echo -e "\n=== Common Keywords in Summaries ==="
jira issue list \
  --jql="project={{ vars.jiraProject }} AND created >= -7d" \
  --plain --columns=summary --no-headers | \
  tr '[:upper:]' '[:lower:]' | \
  grep -oE '\w+' | \
  sort | uniq -c | sort -rn | head -20

echo -e "\nUse bulk-triage skill for deeper pattern analysis"
```

---

### Pattern 4: Team Workload Balance

```bash
#!/bin/bash
# Check ticket distribution across team

echo "Analyzing current team workload..."

# Count open tickets by assignee
echo -e "\n=== Tickets by Assignee ==="
jira issue list \
  --jql="project={{ vars.jiraProject }} AND status IN (Open, 'In Progress')" \
  --plain --columns=assignee --no-headers | \
  sort | uniq -c | sort -rn

# Count unassigned
unassigned=$(jira issue list \
  --jql="project={{ vars.jiraProject }} AND assignee = EMPTY AND status=Open" \
  --plain --columns=key --no-headers | wc -l)

echo -e "\nUnassigned tickets: $unassigned"

if [ $unassigned -gt 10 ]; then
  echo "WARNING: High number of unassigned tickets! Use bulk-triage to distribute."
fi
```

---

## Performance Tips

### Optimize Large Batches

1. **Limit results**: Use `--limit=N` to cap results
2. **Batch processing**: Process 50 tickets at a time
3. **Parallel processing**: Use `xargs -P` for parallel execution (careful with rate limits)
4. **Cache results**: Save JSON output to avoid repeated API calls

### Example: Parallel Processing
```bash
# Process tickets in parallel (max 4 at a time)
jira issue list --jql="..." --plain --columns=key --no-headers | \
  xargs -P 4 -I {} bash -c 'jira issue view {} --format=json > /tmp/{}.json'
```

---

## Troubleshooting

### JQL Errors

**Error**: `Field 'labels' does not exist`
**Fix**: Use `labels IN (...)` not `labels = ...`

**Error**: `Expecting ')', found EOF`
**Fix**: Check for unmatched parentheses or quotes

**Error**: `Function 'currentUser' cannot be used with operator '='`
**Fix**: Use `assignee = currentUser()` not `assignee == currentUser()`

---

### Rate Limits

If hitting rate limits:
- Add delays between bulk operations: `sleep 1`
- Process smaller batches
- Use `--format=json` once and parse locally
- Cache intermediate results

---

## Additional Resources

- **JIRA CLI Docs**: https://github.com/ankitpokhrel/jira-cli
- **JQL Reference**: https://support.atlassian.com/jira-service-management-cloud/docs/use-advanced-search-with-jira-query-language-jql/
- **Bulk Operations Guide**: See examples.md in this directory
