# JIRA Triage Package

AI-powered JIRA ticket triage using the Atlassian CLI for intelligent analysis, categorization, priority assessment, and response generation.

**Package**: `@leourbina/jira-triage`
**Version**: 0.1.0
**License**: MIT

---

## Features

### 🎯 Intelligent Triage
- **Urgency Detection**: Automatically identify urgency signals in ticket content
- **Impact Assessment**: Evaluate business and technical impact
- **Priority Recommendations**: Map urgency + impact to JIRA priority levels
- **Pattern Recognition**: Identify duplicate issues and recurring problems

### 🤖 Specialized AI Agents
- **Ticket Analyzer**: Deep analysis of urgency, impact, and priority
- **Ticket Categorizer**: Issue type classification and labeling
- **Response Generator**: Professional customer communication drafts

### ⚡ Quick Commands
- `/triage` - Main triage command for single or bulk tickets
- `/analyze-ticket` - Detailed analysis of one ticket
- `/categorize` - Quick categorization and labeling
- `/generate-response` - Draft customer responses

### 🛠️ Powerful Skills
- **bulk-triage**: Process batches of tickets with pattern detection
- **priority-analysis**: Deep priority assessment for complex decisions
- **response-draft**: Batch response generation for multiple tickets

---

## Prerequisites

### 1. Terrazul CLI
Install the Terrazul CLI if you haven't already:

```bash
# Installation instructions for Terrazul CLI
# (Follow Terrazul CLI installation guide)
```

### 2. Atlassian JIRA CLI

This package requires the Atlassian JIRA CLI to interact with JIRA.

**Install via Homebrew** (macOS/Linux):
```bash
brew install ankitpokhrel/jira-cli/jira-cli
```

**Install via Go**:
```bash
go install github.com/ankitpokhrel/jira-cli/cmd/jira@latest
```

**Configure JIRA CLI**:
```bash
jira init
```

Follow the prompts to configure:
- JIRA instance URL (e.g., `https://yourcompany.atlassian.net`)
- Authentication method (API token recommended)
- Default project (your support project key)

**Test installation**:
```bash
jira version
jira issue list --project=YOUR-PROJECT --limit=1
```

### 3. Claude Code

This package is designed for Claude Code CLI (version >= 0.2.0).

---

## Installation

### 1. Install the Package

```bash
# Navigate to your project directory
cd /path/to/your/project

# Install the package
tz add @leourbina/jira-triage
```

### 2. Run Package Setup

```bash
# Render package templates
tz run @leourbina/jira-triage
```

During setup, you'll be prompted for:
- **JIRA URL**: Your Atlassian instance URL
- **Project Key**: Your primary JIRA project (e.g., "SUPPORT")
- **Triage Board ID**: (Optional) Specific board for triage
- **Priority Mapping**: How urgency maps to priority levels
- **Triage Label**: Label to mark triaged tickets (default: "triaged")
- **SLA Hours**: Response time SLA in hours (default: 24)

### 3. Verify Installation

Check that the package was installed correctly:

```bash
# Check Claude Code configuration
ls -la .claude/

# You should see:
# - agents/ (ticket-analyzer, ticket-categorizer, response-generator)
# - commands/ (triage, analyze-ticket, categorize, generate-response)
# - skills/ (bulk-triage, priority-analysis, response-draft)
```

---

## Quick Start

### Basic Triage Workflow

1. **Triage a single ticket**:
```
/triage SUPPORT-123
```

2. **Triage all untriaged tickets**:
```
/triage project=YOUR-PROJECT AND labels NOT IN (triaged)
```

3. **Analyze a complex ticket**:
```
/analyze-ticket SUPPORT-456
```

4. **Generate a customer response**:
```
/generate-response SUPPORT-123
```

### Bulk Operations

**Morning triage session**:
```
Use the bulk-triage skill to analyze all tickets created in the last 12 hours
```

**Priority review**:
```
Use the priority-analysis skill to assess SUPPORT-789
```

**Batch responses**:
```
Use the response-draft skill to generate acknowledgments for all new tickets
```

---

## Usage Guide

### Commands

#### `/triage`
Main triage command for comprehensive analysis.

**Single ticket**:
```
/triage SUPPORT-123
```

**Bulk via JQL**:
```
/triage project=SUPPORT AND status=Open AND labels NOT IN (triaged)
```

**Interactive**:
```
/triage
```
(Will prompt for criteria)

---

#### `/analyze-ticket`
Deep analysis of a single ticket for complex priority decisions.

```
/analyze-ticket SUPPORT-456
```

**Output**:
- Comprehensive urgency assessment
- Detailed impact evaluation
- Priority recommendation with full rationale
- Assignee suggestions
- Response timeline
- Next steps

---

#### `/categorize`
Quick categorization and labeling.

```
/categorize SUPPORT-789
```

**Output**:
- Issue type classification
- Complexity assessment
- Label recommendations
- Component suggestions
- Workflow recommendations

---

#### `/generate-response`
Draft professional customer responses.

```
/generate-response SUPPORT-123
```

**Output**:
- Response type (acknowledgment, solution, escalation, etc.)
- Tone assessment
- Full response draft
- Recommended actions
- Alternative approaches

---

### Skills

#### `bulk-triage`
Process batches of tickets efficiently with pattern recognition.

**Usage**:
```
Use the bulk-triage skill to analyze all untriaged tickets in SUPPORT
```

**Capabilities**:
- Batch analysis (20-50 tickets)
- Pattern detection (duplicates, related issues)
- Priority ranking
- Bulk action recommendations
- Comprehensive reports

---

#### `priority-analysis`
Deep priority assessment for complex decisions.

**Usage**:
```
Use the priority-analysis skill for SUPPORT-456
```

**When to use**:
- Competing factors (high urgency + low impact)
- Unclear severity
- Priority disputes
- Escalation decisions

---

#### `response-draft`
Batch response generation for multiple tickets.

**Usage**:
```
Use the response-draft skill to generate acknowledgments for all new tickets from today
```

**Capabilities**:
- Batch response generation
- Consistent tone across responses
- Template-based with customization
- Quality review before posting

---

### Agents

Agents are invoked automatically by commands and skills, but you can also use them directly:

**Ticket Analyzer**:
```
Use the ticket-analyzer agent to analyze SUPPORT-123
```

**Ticket Categorizer**:
```
Use the ticket-categorizer agent to categorize SUPPORT-456
```

**Response Generator**:
```
Use the response-generator agent to draft a response for SUPPORT-789
```

---

## Common Workflows

### Morning Triage
```bash
# 1. Get overnight tickets
jira issue list --jql="project=SUPPORT AND created >= -12h"

# 2. Bulk triage
Use the bulk-triage skill to analyze all tickets created in the last 12 hours

# 3. Generate responses for high-priority
Use the response-draft skill for high-priority tickets needing immediate response
```

---

### Weekly Backlog Review
```bash
# 1. Find old untriaged tickets
jira issue list --jql="project=SUPPORT AND created < -7d AND labels NOT IN (triaged)"

# 2. Bulk triage
Use the bulk-triage skill to process tickets older than 7 days

# 3. Update priorities
# (Apply bulk actions recommended by skill)
```

---

### Emergency Response
```bash
# 1. Analyze critical ticket
/analyze-ticket SUPPORT-EMERGENCY

# 2. Generate urgent response
/generate-response SUPPORT-EMERGENCY

# 3. Escalate if needed
jira issue update SUPPORT-EMERGENCY --priority=Highest
jira issue update SUPPORT-EMERGENCY --assignee=engineering-lead
```

---

## Configuration

### JIRA Project Settings

Edit your project's `CLAUDE.md` (generated during setup) to update:
- JIRA URL
- Project key
- Board ID
- Priority mappings
- Triage label
- SLA hours

### Customization

**Custom Labels**:
Edit templates to add project-specific labels.

**Custom Workflows**:
Modify command templates in `.claude/commands/` to match your team's process.

**Response Templates**:
Update agent definitions in `.claude/agents/` to match your brand voice.

---

## Tips & Best Practices

### Triage Efficiency
1. **Use JQL filters** - Target specific ticket subsets
2. **Process in batches** - 20-50 tickets at a time
3. **Start with high priority** - Triage urgent tickets first
4. **Look for patterns** - Group similar issues
5. **Always confirm before applying bulk actions**

### Priority Decisions
1. **Be objective** - Use urgency + impact matrix
2. **Consider SLA** - Factor in approaching deadlines
3. **Check customer tier** - Enterprise vs standard
4. **Verify claims** - "Production down" might mean "down for me"
5. **Re-evaluate** - Priority can change with new information

### Response Quality
1. **Personalize** - Use customer name and specific details
2. **Set realistic timelines** - Don't overpromise
3. **Show empathy** - Acknowledge impact
4. **Provide next steps** - Clear timeline
5. **Link resources** - Helpful documentation

### Pattern Recognition
1. **Track similar tickets** - Link duplicates
2. **Identify trends** - Multiple reports = systemic issue
3. **Create master tickets** - For widespread problems
4. **Update documentation** - For repeated questions

---

## Troubleshooting

### JIRA CLI Issues

**"jira: command not found"**:
```bash
# Install JIRA CLI
brew install ankitpokhrel/jira-cli/jira-cli
```

**Authentication errors**:
```bash
# Reconfigure JIRA CLI
jira init
```

**Permission errors**:
- Verify your JIRA user has permission to:
  - View tickets
  - Update priority, labels, assignee
  - Add comments
  - Transition tickets

### Package Issues

**Templates not rendering**:
```bash
# Force re-render
tz run @leourbina/jira-triage --force
```

**Skills not found**:
- Verify package installation: `tz list`
- Check `.claude/skills/` directory exists
- Re-install package: `tz add @leourbina/jira-triage`

### Performance Issues

**Bulk triage too slow**:
- Reduce batch size (20-30 tickets instead of 50)
- Use more specific JQL filters
- Process critical tickets separately

**JQL queries timing out**:
- Add more filters to narrow results
- Use indexed fields (status, priority, created)
- Avoid text searches on very large projects

---

## Examples & References

Each skill includes detailed documentation:

**Bulk Triage**:
- `skills/bulk-triage/SKILL.md` - Main workflow
- `skills/bulk-triage/examples.md` - Real-world scenarios
- `skills/bulk-triage/reference.md` - JQL queries and commands

**Priority Analysis**:
- `skills/priority-analysis/SKILL.md` - Priority matrix and process
- `skills/priority-analysis/examples.md` - Decision scenarios
- `skills/priority-analysis/reference.md` - Quick reference guide

**Response Draft**:
- `skills/response-draft/SKILL.md` - Batch response workflow
- `skills/response-draft/examples.md` - Batch processing examples
- `skills/response-draft/reference.md` - Templates and commands

---

## Support

### Package Issues
- GitHub Issues: https://github.com/leourbina/jira-triage/issues
- Package Repository: https://github.com/leourbina/jira-triage

### JIRA CLI Issues
- JIRA CLI Docs: https://github.com/ankitpokhrel/jira-cli
- JIRA CLI Issues: https://github.com/ankitpokhrel/jira-cli/issues

### Terrazul CLI
- Terrazul Docs: (Terrazul documentation link)

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Development

```bash
# Clone repository
git clone https://github.com/leourbina/jira-triage.git
cd jira-triage

# Test package locally
tz run . --force
```

---

## Changelog

### v0.1.0 (Initial Release)
- Core triage functionality
- 3 specialized agents (analyzer, categorizer, response-generator)
- 4 slash commands (/triage, /analyze-ticket, /categorize, /generate-response)
- 3 powerful skills (bulk-triage, priority-analysis, response-draft)
- Comprehensive documentation and examples

---

## License

MIT License - see LICENSE file for details

---

## Acknowledgments

- Built for Terrazul CLI
- Uses Atlassian JIRA CLI (https://github.com/ankitpokhrel/jira-cli)
- Powered by Claude AI

---

**Happy Triaging! 🎯**
