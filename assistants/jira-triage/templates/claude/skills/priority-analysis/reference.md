# Priority Analysis Reference

Quick reference for priority decision-making.

---

## Priority Matrix Quick Reference

| Urgency | Impact Critical | Impact High | Impact Medium | Impact Low |
|---------|----------------|-------------|---------------|------------|
| **Critical** | Highest | Highest | High | High |
| **High** | Highest | High | High | Medium |
| **Medium** | High | Medium | Medium | Low |
| **Low** | Medium | Low | Low | Low |

---

## Urgency Keywords

### Critical Urgency
- down, outage, offline, unavailable
- data loss, deleted, corrupted, missing data
- security, breach, vulnerability, exploit, hack
- production, prod down, system failure
- emergency, critical, asap, immediately

### High Urgency
- broken, failing, error, crash, exception
- urgent, important, blocking, blocker
- cannot, unable to, won't work, doesn't work
- performance, slow, timeout, hanging
- multiple customers, many users

### Medium Urgency
- issue, problem, concern
- sometimes, intermittent, occasionally
- confusing, unclear, unexpected
- workaround needed
- single user, one customer

### Low Urgency
- enhancement, feature request, improvement
- would like, wish, hope, consider
- nice to have, someday, future
- suggestion, idea, proposal
- cosmetic, minor, trivial

---

## Impact Indicators

### Critical Impact
✅ All or most users affected
✅ Core product features unusable
✅ Revenue loss or payment failures
✅ Data integrity compromised
✅ Legal/compliance violations
✅ SLA breaches for multiple customers

### High Impact
✅ Important features unavailable
✅ Enterprise/paying customers affected
✅ Multiple standard customers impacted
✅ Significant productivity loss
✅ Workaround complex or unreliable

### Medium Impact
✅ Secondary features affected
✅ Single customer impacted
✅ Moderate productivity impact
✅ Simple workaround available
✅ Non-critical functionality

### Low Impact
✅ Edge cases or rare scenarios
✅ Internal users only
✅ Minimal productivity impact
✅ Easy alternatives exist
✅ Cosmetic issues

---

## Response Time Targets

| Priority | First Response | Investigation | Resolution Target |
|----------|---------------|---------------|-------------------|
| **Highest** | < 1 hour | Immediate | < 4 hours |
| **High** | < 4 hours | Within day | < 24 hours |
| **Medium** | < 24 hours | 1-2 days | < 1 week |
| **Low** | < 3 days | As capacity allows | Next sprint |

---

## Priority Adjustment Factors

### Increase Priority (+1 or +2)
- ⬆️ SLA approaching (< 2 hours remaining): +1
- ⬆️ SLA breached: +2
- ⬆️ Enterprise customer with contract SLA: +1
- ⬆️ High-value customer: +1
- ⬆️ Repeat issue for same customer: +1
- ⬆️ Customer had multiple recent issues: +1
- ⬆️ Critical business period (quarter end, tax season): +1
- ⬆️ Affects product launch or sales demo: +1
- ⬆️ Multiple reports of same issue (pattern): +1
- ⬆️ Security implications: +2

### Decrease Priority (-1)
- ⬇️ Trial or free tier user: -1
- ⬇️ Complex workaround available: -1
- ⬇️ Known bug with fix already in progress: -1
- ⬇️ Duplicate of existing ticket: -1
- ⬇️ User error or misunderstanding: -1

---

## Decision Tree

```
START
  |
  ├─ Is system down or data being lost?
  |    YES → HIGHEST
  |    NO → Continue
  |
  ├─ Are multiple customers affected?
  |    YES → Consider HIGH or HIGHEST
  |    NO → Continue
  |
  ├─ Is this an enterprise customer?
  |    YES → Consider HIGH (minimum MEDIUM)
  |    NO → Continue
  |
  ├─ Is core functionality broken?
  |    YES → Consider HIGH
  |    NO → Continue
  |
  ├─ Is workaround available?
  |    NO → Increase priority by 1
  |    YES → Continue
  |
  ├─ Is SLA approaching (<2 hours)?
  |    YES → Increase priority by 1
  |    NO → Continue
  |
  └─ Apply urgency + impact matrix
```

---

## Common Scenarios

### Production Outage
- **Urgency**: Critical
- **Impact**: Critical (if multiple users) or High (if single customer)
- **Priority**: Highest
- **Response**: Immediate

### Major Feature Broken
- **Urgency**: High
- **Impact**: High (if core feature) or Medium (if secondary)
- **Priority**: High
- **Response**: < 4 hours

### Performance Degradation
- **Urgency**: Medium-High (depending on severity)
- **Impact**: Medium-High (depending on user count)
- **Priority**: Medium to High
- **Response**: < 8 hours

### How-To Question
- **Urgency**: Low-Medium
- **Impact**: Low
- **Priority**: Low to Medium
- **Response**: < 24 hours

### Feature Request
- **Urgency**: Low
- **Impact**: Varies
- **Priority**: Low
- **Response**: Acknowledge and add to backlog

### Security Vulnerability
- **Urgency**: Critical
- **Impact**: Critical
- **Priority**: Highest
- **Response**: Immediate

---

## Priority by Customer Tier

### Enterprise / Premium
- Minimum priority: Medium
- Most issues: High or Highest
- SLA: Strict (usually 4-hour response)
- Escalation path: Direct to engineering

### Standard / Paying
- Full priority range applies
- Common: Medium to High
- SLA: Standard (24-hour response)
- Escalation: Through support lead

### Trial / Free
- Maximum priority: Usually High (rarely Highest)
- Common: Low to Medium
- SLA: Best effort (48-72 hour response)
- Escalation: Rare

---

## Special Cases

### Case: Duplicate Ticket
- Link to existing ticket
- Match priority of master ticket
- Update customer on existing investigation

### Case: Known Bug
- Link to bug ticket
- Priority based on fix status:
  - Fix in progress: Medium
  - Fix scheduled: Low-Medium
  - Not scheduled: Low
- Inform customer of timeline

### Case: Vague Description
- Start with Medium (safe default)
- Request clarification
- Re-assess after more info

### Case: Competing Factors
- High urgency + Low impact = Medium-High
- Low urgency + High impact = Medium-High
- When in doubt, err on side of higher priority (easier to downgrade)

---

## Investigation Commands

### Check for Similar Issues
```bash
# Search for similar summaries
jira issue list --jql="summary ~ 'keyword' AND created >= -7d"

# Search in descriptions
jira issue list --jql="description ~ 'error message' AND created >= -7d"
```

### Check Reporter History
```bash
# Get all tickets from this reporter
jira issue list --jql="reporter = 'email@example.com'" --limit=20

# Check recent High priority tickets from reporter
jira issue list --jql="reporter = 'email@example.com' AND priority IN (Highest, High) AND created >= -30d"
```

### Check System Status
```bash
# Check for widespread issues (many reports in short time)
jira issue list --jql="project={{ vars.jiraProject }} AND created >= -2h" --plain --columns=summary

# Count tickets by priority
jira issue list --jql="project={{ vars.jiraProject }} AND status=Open" --plain --columns=priority --no-headers | sort | uniq -c
```

---

## Priority Justification Templates

### Highest Priority
```
Priority: Highest

Rationale:
- Urgency: [Critical - system down / data loss / security]
- Impact: [X users affected / revenue impact / core functionality]
- Business context: [SLA breach risk / enterprise customer / critical period]
- No workaround available
- Requires immediate attention

Timeline:
- Response: Immediate
- Investigation: Now
- Resolution target: < 4 hours
```

### High Priority
```
Priority: High

Rationale:
- Urgency: [High - major feature broken / customer blocked]
- Impact: [Multiple customers / important functionality / moderate revenue]
- Context: [SLA approaching / paying customer / affects productivity]
- Workaround: [Complex / temporary only]

Timeline:
- Response: < 4 hours
- Investigation: Today
- Resolution target: < 24 hours
```

### Medium Priority
```
Priority: Medium

Rationale:
- Urgency: [Medium - affects workflow but not critical]
- Impact: [Single user / secondary feature / limited scope]
- Context: [Standard customer / workaround exists]
- Can be handled in normal queue

Timeline:
- Response: < 24 hours
- Investigation: 1-2 days
- Resolution target: This week
```

### Low Priority
```
Priority: Low

Rationale:
- Urgency: [Low - enhancement / future consideration]
- Impact: [Minimal / cosmetic / edge case]
- Type: [Feature request / documentation / nice-to-have]
- Can be scheduled for future sprint

Timeline:
- Response: < 3 days
- Planning: Next sprint/backlog grooming
- Resolution: When capacity allows
```

---

## Escalation Criteria

### Immediate Escalation to Engineering
- Production system down
- Data loss or corruption
- Security breach
- Multiple Highest priority tickets

### Standard Escalation
- High priority bugs requiring code fix
- Performance issues needing profiling
- Architecture or design questions
- Complex technical investigations

### No Escalation Needed
- Questions (documentation/support can answer)
- Configuration issues (support can resolve)
- User errors (support can guide)
- Low priority enhancements (log for product review)

---

## Priority Review Checklist

Before finalizing priority:

- [ ] Verified urgency with data (not just customer's claim)
- [ ] Assessed actual impact (user count, functionality, revenue)
- [ ] Checked for similar issues (pattern?)
- [ ] Considered customer tier and SLA
- [ ] Evaluated workaround availability
- [ ] Reviewed historical context (repeat issue?)
- [ ] Factored in business context (timing, importance)
- [ ] Can justify decision to customer and team
- [ ] Set appropriate response timeline
- [ ] Identified next steps

---

## Common Mistakes to Avoid

❌ Setting everything to High/Highest (priority inflation)
❌ Ignoring customer tier differences
❌ Treating all "urgent" claims as Critical
❌ Never using Low priority
❌ Not re-evaluating as situations change
❌ Prioritizing based on who complains loudest
❌ Forgetting to check for duplicate issues
❌ Not documenting priority reasoning
❌ Ignoring SLA deadlines
❌ Not considering workaround impact on priority

---

## Additional Resources

- See `examples.md` for real-world priority scenarios
- See `SKILL.md` for detailed analysis workflow
- Priority matrix visualization: See main skill documentation
