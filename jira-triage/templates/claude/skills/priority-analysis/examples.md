# Priority Analysis Examples

Real-world scenarios demonstrating priority decision-making.

---

## Example 1: High Urgency + Low Impact = Medium Priority

### Ticket: SUPPORT-501
**Reporter**: Trial user (free account)
**Summary**: "URGENT: Cannot log in - production down!"
**Description**: User reports inability to log in to their trial account, calls it "production down"

### Initial Assessment
- **Urgency signals**: "URGENT", "production down"
- **Apparent urgency**: Critical
- **Customer's perception**: Critical emergency

### Deep Analysis

**Urgency Score**: 7/10
- Login failure is urgent for user
- Blocking their work
- But: Likely user-specific (no other reports)

**Impact Score**: 2/10
- Single trial user affected
- No revenue impact
- Not affecting other customers
- Likely configuration or password issue

**Combined**: 7 + 2 = 9

### Priority Recommendation
**Recommended**: **Medium** (not Highest or High)

**Rationale**:
- User's urgency is understandable, but impact is limited
- Trial users are important but don't take priority over paying customers
- Likely simple resolution (password reset, account unlock)
- Should respond within 4-8 hours, not immediately

### Response Strategy
- Acknowledge urgency from user's perspective
- Set realistic expectations
- Provide self-service options (password reset link)
- Investigate within normal support queue

---

## Example 2: Low Urgency + Critical Impact = High Priority

### Ticket: SUPPORT-502
**Reporter**: Enterprise customer
**Summary**: "Minor issue with data export formatting"
**Description**: CSV exports have inconsistent date formats, not affecting their workflow currently but causing issues in downstream data pipeline

### Initial Assessment
- **Urgency signals**: "minor issue"
- **Apparent urgency**: Low
- **Customer's perception**: Low priority

### Deep Analysis

**Urgency Score**: 3/10
- Customer says "minor"
- Not blocking current work
- Workaround exists (manual reformatting)

**Impact Score**: 8/10
- **Enterprise customer** with contract SLA
- Affects **data pipeline** (critical business process)
- **All exports affected** (not isolated)
- Will become blocking soon (pipeline depends on automation)
- **Potential revenue impact** if pipeline fails

**Combined**: 3 + 8 = 11 → + 1 for Enterprise SLA = 12

### Priority Recommendation
**Recommended**: **High** (not Medium or Low)

**Rationale**:
- While customer downplays urgency, impact is significant
- Enterprise SLA requires higher prioritization
- Data integrity issues have long-term impact
- Better to fix proactively before it becomes critical
- Demonstrates proactive support to high-value customer

### Response Strategy
- Thank customer for detailed report
- Explain why we're prioritizing this higher than they suggested
- Provide timeline for fix
- Set up monitoring to ensure pipeline doesn't fail in meantime

---

## Example 3: Pattern of Multiple Reports = Elevated Priority

### Tickets: SUPPORT-503, 504, 505, 506
**Individual assessment**: Each would be Medium priority
**Summary**: Different users reporting slow dashboard loading

### Individual Analysis (per ticket)
**Urgency**: Medium (annoying but not blocking)
**Impact**: Low-Medium (single user each)
**Expected Priority**: Medium

### Aggregate Analysis
**Count**: 4 reports in 2 hours
**Pattern**: All report same symptom (dashboard slow)
**Timing**: All started after this morning's deployment
**Affected users**: Different customers, different accounts

**Combined Impact**:
- Multiple users affected (growing)
- Likely systemic issue (deployment-related)
- May affect all users (just not all reporting yet)
- Could indicate performance regression

### Priority Recommendation
**Recommended**: **High** (elevated from Medium)

**Rationale**:
- Pattern suggests wider impact than individual tickets show
- Deployment-related issues can escalate quickly
- Better to investigate now before it affects more users
- May need rollback decision

### Actions Taken
1. Create master investigation ticket
2. Link all 4 reports
3. Elevate to High priority
4. Assign to performance team immediately
5. Monitor for additional reports

---

## Example 4: SLA Considerations

### Ticket: SUPPORT-507
**Reporter**: Standard customer
**Summary**: Question about API rate limits
**Created**: 20 hours ago
**SLA**: 24-hour response time

### Initial Analysis
**Urgency**: Low (just a question)
**Impact**: Low (informational)
**Expected Priority**: Low

### SLA Context
- SLA deadline: 4 hours remaining
- No response posted yet
- Customer may be blocked waiting for answer

### Priority Recommendation
**Recommended**: **Medium** (elevated from Low due to SLA)

**Rationale**:
- While question itself is low priority, SLA obligation is real
- Approaching deadline requires action
- Simple question, can answer quickly
- Better to respond now than risk SLA breach

### Action
- Answer question immediately (takes 5 minutes)
- Update customer with API documentation link
- Prevent SLA breach
- Maintain good customer relationship

---

## Example 5: Known Bug vs. New Report

### Scenario
**Existing bug**: SUPPORT-400 (High priority, being fixed)
**New ticket**: SUPPORT-508 (reports same issue)

### Analysis of New Ticket

**Independent assessment**: Would be High priority
**Context**: Duplicate of known bug already being fixed

### Priority Recommendation
**Recommended**: **Medium** (lower than independent assessment)

**Rationale**:
- Root cause already identified
- Fix already in progress (deploying tomorrow)
- No need for duplicate investigation
- But: Still needs customer communication

### Actions
1. Link SUPPORT-508 to SUPPORT-400
2. Set priority to Medium (not High)
3. Post response with fix timeline
4. Add to notification list for fix deployment
5. Update customer when fix is deployed

**Key point**: Don't duplicate effort, but do maintain communication

---

## Example 6: Conflicting Information

### Ticket: SUPPORT-509
**Summary**: "Payment processing completely broken"
**Description**: Single transaction failed, but says "completely broken"

### Initial Confusion
- Title suggests Critical urgency
- Description suggests Medium urgency

### Investigation
```bash
# Check for other payment failures
jira issue list --jql="summary ~ 'payment' AND created >= -2h"
# Result: No other reports

# Check payment system logs
# Result: 99.9% of transactions succeeding

# Check this specific transaction
# Result: Customer's credit card was declined
```

### Analysis
**Claimed urgency**: Critical ("completely broken")
**Actual urgency**: Low (user error)
**Claimed impact**: Critical (all payments)
**Actual impact**: Low (one transaction)

### Priority Recommendation
**Recommended**: **Low**

**Rationale**:
- System is working fine
- Single transaction failed due to declined card
- User misdiagnosed the problem
- Not a bug, just needs explanation

### Response Strategy
- Politely explain that payment system is working
- Explain that card was declined
- Provide customer support contact for card issuer
- De-escalate without being dismissive

**Lesson**: Verify urgency claims with data, don't just trust ticket title

---

## Example 7: Business Context Elevation

### Ticket: SUPPORT-510
**Reporter**: Sales team (internal)
**Summary**: Demo environment intermittently failing
**Created**: During end-of-quarter sales push

### Standard Analysis
**Urgency**: Medium (intermittent, not always failing)
**Impact**: Medium (internal team, not customers)
**Expected Priority**: Medium

### Business Context
- **Quarter end**: Next 3 days
- **Impact on sales**: Failing demos = lost deals
- **Revenue potential**: Could lose $100K+ in deals
- **Workaround**: None (need working demo)

### Priority Recommendation
**Recommended**: **Highest** (elevated from Medium)

**Rationale**:
- Timing is critical (quarter end)
- Direct revenue impact (lost sales)
- Affects business-critical function (sales demos)
- Small fix window (3 days)
- No workaround available

### Actions
1. Immediate investigation
2. Assign to senior engineer
3. Debug and fix within 4 hours
4. Test thoroughly before next demo
5. Monitor for remaining quarter

**Lesson**: Business context can dramatically change priority

---

## Key Lessons from Examples

### Lesson 1: Urgency ≠ Impact
Customer's urgency doesn't always match actual impact. Assess both independently.

### Lesson 2: Patterns Matter
Multiple low-priority tickets can indicate high-priority systemic issue.

### Lesson 3: Context Changes Priority
SLA, customer tier, business timing all affect priority.

### Lesson 4: Verify Claims
"Completely broken" often means "broken for me". Investigate before escalating.

### Lesson 5: Be Proactive
High impact + preventable problem = worth prioritizing even if not urgent yet.

### Lesson 6: Communicate Reasoning
Explain priority decisions, especially when they differ from customer's perception.

### Lesson 7: Re-evaluate
Priority can change as situations evolve. Stay flexible.
