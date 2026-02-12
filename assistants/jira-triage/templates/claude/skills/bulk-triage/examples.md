# Bulk Triage Examples

Real-world examples of using the bulk-triage skill for different scenarios.

---

## Example 1: Morning Triage Session

### Scenario
It's Monday morning and you need to triage all tickets created over the weekend.

### User Request
```
Use the bulk-triage skill to analyze all tickets created in the last 3 days that haven't been triaged yet.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND created >= -3d AND labels NOT IN ({{ vars.triageLabel }}) AND status=Open
```

### Results
- **Tickets Analyzed**: 23
- **Critical**: 2 (production issues)
- **High**: 7 (customer-impacting bugs)
- **Medium**: 10 (questions and minor bugs)
- **Low**: 4 (feature requests)

### Key Findings
1. **Pattern**: 3 tickets reporting same login issue after Saturday deployment
2. **SLA At-Risk**: 2 tickets approaching 24-hour SLA
3. **Missing Info**: 5 tickets need follow-up questions from reporter

### Actions Taken
- Created master bug ticket for login issue (SUPPORT-500)
- Linked 3 duplicate tickets to master
- Updated priority for 2 critical tickets
- Generated responses for SLA at-risk tickets
- Assigned 15 tickets to appropriate teams
- Added "triaged" label to all 23 tickets

### Time Saved
- Traditional triage: ~2 hours (5 min per ticket × 23 tickets)
- With bulk-triage skill: ~30 minutes
- **Saved: 1.5 hours**

---

## Example 2: Backlog Cleanup

### Scenario
You have a backlog of 45 old tickets that need triage and haven't been prioritized.

### User Request
```
Use the bulk-triage skill to process all tickets older than 7 days that don't have a priority set.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND created < -7d AND priority = EMPTY AND status=Open
```

### Results
- **Tickets Analyzed**: 45
- **Critical**: 1 (old escalation that was missed)
- **High**: 8
- **Medium**: 24
- **Low**: 12

### Key Findings
1. **Abandoned Escalation**: SUPPORT-234 (14 days old, production impact) - was never prioritized!
2. **Pattern**: 8 feature requests for same capability (dark mode)
3. **Documentation Gaps**: 12 questions about same topic (API rate limits)
4. **Stale Tickets**: 6 tickets where reporter never responded to follow-up

### Actions Taken
- **Immediate escalation** of SUPPORT-234 to engineering
- Generated urgent response and apology for SUPPORT-234
- Created feature request epic for dark mode, linked 8 tickets
- Created task to update API rate limit documentation
- Closed 6 stale tickets after final follow-up attempt
- Set priority for all remaining 39 tickets

### Insights Gained
- Need better SLA monitoring to catch missed escalations
- Dark mode is highly requested - recommend to product team
- API docs need improvement - created documentation task

---

## Example 3: Pattern Detection

### Scenario
Multiple customers reporting similar issues. Use bulk triage to identify the pattern.

### User Request
```
Use the bulk-triage skill to analyze all bug reports from the last week.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND type=Bug AND created >= -7d
```

### Results
- **Tickets Analyzed**: 18 bug reports
- **Patterns Identified**: 2 major patterns

### Pattern 1: Email Delivery Failures (6 tickets)
**Tickets**: SUPPORT-301, 305, 312, 318, 325, 329

**Common Indicators**:
- All report "email not received"
- All created after March 15 (deployment date)
- All Gmail users
- Error in logs: "554 5.7.1 Message rejected"

**Root Cause (suspected)**:
- SPF record change in March 15 deployment
- Gmail specifically rejecting messages

**Recommended Actions**:
1. Create master bug ticket: "Email delivery failure for Gmail recipients after v2.5 deployment"
2. Link all 6 tickets to master
3. Escalate to infrastructure team immediately
4. Post status update to all affected customers
5. Investigate SPF/DKIM configuration changes

### Pattern 2: Mobile App Crashes on iOS 17 (4 tickets)
**Tickets**: SUPPORT-307, 314, 321, 327

**Common Indicators**:
- All iOS users
- All on iOS 17+
- Crash on app launch
- Started after app store update on March 12

**Root Cause (suspected)**:
- Incompatibility with iOS 17 API changes
- Likely related to v3.2 mobile app release

**Recommended Actions**:
1. Create master bug ticket: "App crash on launch for iOS 17 users (v3.2)"
2. Escalate to mobile team
3. Consider hotfix release
4. Post response to all affected users with timeline
5. Monitor app store reviews for more reports

### Value Delivered
By identifying these patterns:
- Avoided 6 separate email investigations (would have found root cause eventually, but slower)
- Avoided 4 separate crash investigations
- Enabled coordinated response to affected customers
- Provided engineering team with clear pattern data for faster debugging

---

## Example 4: Priority Review for Planning

### Scenario
Before sprint planning, review all high and medium priority tickets to ensure priority is accurate.

### User Request
```
Use the bulk-triage skill to review all High and Medium priority tickets and validate they're correctly prioritized.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND priority IN (High, Medium) AND status IN (Open, "In Progress")
```

### Results
- **Tickets Analyzed**: 32
- **Priority Changes Recommended**: 12

### Findings

**Upgrade to Highest** (2 tickets):
- SUPPORT-245: Was "High" but is production outage affecting enterprise customer
- SUPPORT-267: Was "High" but has SLA violation risk

**Upgrade to High** (3 tickets):
- SUPPORT-251, 258, 262: Were "Medium" but all are same critical bug affecting multiple users

**Downgrade to Medium** (4 tickets):
- SUPPORT-240, 243, 249, 255: Were "High" but workarounds exist and only single users affected

**Downgrade to Low** (3 tickets):
- SUPPORT-235, 237, 241: Were "Medium" but are enhancement requests, not bugs

### Actions Taken
- Updated priority for all 12 tickets
- Added comments explaining priority changes
- Linked the 3 duplicate High priority tickets
- Created prioritized list for sprint planning

### Impact on Sprint Planning
- Engineering team could focus on genuinely critical issues
- 2 tickets requiring immediate attention were surfaced
- 3 duplicate reports combined into single investigation
- 7 tickets deprioritized, freeing up capacity

---

## Example 5: SLA Compliance Check

### Scenario
End of month SLA review - identify tickets at risk of SLA violation.

### User Request
```
Use the bulk-triage skill to find all tickets that might violate our 24-hour response SLA.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND created < -20h AND status=Open AND comment is EMPTY
```

(Tickets older than 20 hours with no comments = no response yet)

### Results
- **Tickets Analyzed**: 14
- **SLA Status**: All at risk of violation within 4 hours

### Urgency Distribution
- **Critical urgency**: 3 tickets (< 1 hour until SLA breach)
- **High urgency**: 5 tickets (< 2 hours)
- **Medium urgency**: 4 tickets (< 4 hours)
- **Low urgency**: 2 tickets

### Actions Taken

**Immediate Responses Generated** (3 critical):
- SUPPORT-401: Production outage - escalated immediately + response sent
- SUPPORT-405: Data loss report - escalated + response sent
- SUPPORT-410: Enterprise customer - assigned to senior engineer + response sent

**Responses Generated** (5 high):
- All 5 received acknowledgment responses with investigation timelines

**Assigned for Quick Resolution** (6 medium/low):
- 4 were simple questions - answered immediately
- 2 required brief investigation - assigned with priority

### SLA Compliance Achieved
- All 14 tickets received response within SLA
- 3 critical issues escalated appropriately
- 4 tickets resolved completely
- 10 tickets in progress with customers informed

### Prevention Insight
- Identified need for better alert system for approaching SLA deadlines
- Recommended automated notification at 18-hour mark

---

## Example 6: Team Workload Distribution

### Scenario
Distribute untriaged tickets across support team fairly.

### User Request
```
Use the bulk-triage skill to analyze untriaged tickets and recommend assignment distribution across the team.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND assignee = EMPTY AND status=Open AND labels NOT IN ({{ vars.triageLabel }})
```

### Results
- **Tickets Analyzed**: 28 unassigned tickets

### Analysis by Type and Complexity

**Backend Issues** (8 tickets):
- 2 Complex → Assign to senior backend engineer
- 4 Medium → Distribute among backend team
- 2 Simple → Junior backend engineer

**Frontend Issues** (6 tickets):
- 1 Complex → Senior frontend engineer
- 3 Medium → Frontend team rotation
- 2 Simple → Junior frontend engineer

**General Support Questions** (10 tickets):
- 8 Simple → Support team rotation
- 2 Medium → Senior support engineer

**Security Issues** (2 tickets):
- Both escalations → Security team

**Documentation** (2 tickets):
- Both → Technical writer

### Recommended Distribution

**Backend Team**:
- alice@company (senior): 2 complex tickets
- bob@company: 2 medium tickets
- carol@company: 2 medium tickets
- dave@company (junior): 2 simple tickets

**Frontend Team**:
- eve@company (senior): 1 complex ticket
- frank@company: 2 medium tickets
- grace@company: 1 medium ticket
- henry@company (junior): 2 simple tickets

**Support Team**:
- iris@company (senior): 2 medium questions
- jack@company: 3 simple questions
- kelly@company: 3 simple questions
- louis@company: 2 simple questions

**Specialists**:
- security@company: 2 security escalations
- techwriter@company: 2 documentation tasks

### Actions Taken
- Assigned all 28 tickets according to distribution plan
- Balanced complexity across team members
- Ensured junior team members got learning opportunities
- Routed escalations to appropriate specialists

---

## Example 7: Release Impact Assessment

### Scenario
After a major release, check if there's a spike in related bug reports.

### User Request
```
Use the bulk-triage skill to analyze all tickets created since our v3.0 release yesterday and identify any release-related issues.
```

### JQL Query Used
```
project={{ vars.jiraProject }} AND created >= -1d
```

### Results
- **Tickets Analyzed**: 31
- **Release-Related**: 12 tickets (40% of total)

### Release-Related Issues Identified

**Breaking Change Impact** (5 tickets):
- API endpoint deprecation affected 5 different customers
- All report "404 Not Found" on `/api/v2/users` endpoint
- Documentation mentioned deprecation but migration guide was unclear

**Performance Regression** (4 tickets):
- Dashboard loading 3-5x slower after release
- All report similar symptoms
- Likely database query optimization issue

**New Feature Bug** (3 tickets):
- New export feature has formatting issues
- CSV headers incorrect in all reports
- Only affects new export functionality

### Impact Assessment
- **High Impact**: API breaking change (5 customers, production systems down)
- **High Impact**: Performance regression (affects all users)
- **Medium Impact**: Export bug (workaround: use old export)

### Immediate Actions Taken
1. Created hotfix ticket for API breaking change
2. Created emergency documentation update for API migration
3. Posted status update in status page about performance
4. Created P0 ticket for performance regression
5. Created P1 ticket for export bug
6. Sent proactive communication to all customers about API change

### Follow-up
- Hotfix deployed within 4 hours (restored old endpoint)
- Performance fix deployed within 12 hours
- Export fix included in v3.0.1 (released next day)
- Updated release process to include better breaking change communication

---

## Key Takeaways from Examples

### When to Use Bulk Triage

✅ **Use bulk triage when**:
- Processing 10+ similar tickets
- Looking for patterns across tickets
- Doing periodic triage sessions (morning, weekly, monthly)
- Cleaning up backlog
- Reviewing priority distribution
- Checking SLA compliance
- Assessing release impact
- Distributing workload

❌ **Don't use bulk triage when**:
- Analyzing 1-2 tickets (use `/analyze-ticket` instead)
- Need very deep analysis of complex issue (use `priority-analysis` skill)
- Generating detailed responses (use `response-draft` skill)
- Focus is on categorization only (use `/categorize` instead)

### Success Patterns

1. **Start with specific JQL** - Narrow scope to relevant tickets
2. **Process in batches** - 20-50 tickets at a time
3. **Look for patterns** - Duplicates, related issues, trends
4. **Be systematic** - Apply consistent criteria
5. **Document findings** - Save reports for reference
6. **Take immediate action** - Don't just report, fix
7. **Follow up** - Verify changes had desired effect

### Time Savings

Based on these examples:
- **Traditional triage**: ~5 minutes per ticket
- **With bulk triage**: ~1-2 minutes per ticket (including pattern analysis)
- **Average savings**: 60-70% time reduction for batches
- **Quality improvement**: Better pattern detection, fewer duplicate investigations
