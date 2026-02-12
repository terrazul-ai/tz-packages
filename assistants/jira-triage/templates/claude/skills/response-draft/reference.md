# Response Draft Reference

Quick reference for batch response generation.

---

## Response Type Quick Guide

| Type | When to Use | Key Elements | Tone |
|------|-------------|--------------|------|
| **Acknowledgment** | Just received, need time | Thank, timeline, request details | Empathetic |
| **Solution** | Have fix/workaround | Clear steps, outcome | Helpful |
| **Explanation** | How-to question | Clear answer, examples, docs | Educational |
| **Escalation** | Routing to engineering | What's being done, timeline | Apologetic/Professional |
| **Status Update** | Investigation in progress | Progress, next steps | Transparent |
| **Closure** | Issue resolved | What fixed, verify, invite followup | Positive |

---

## JQL Queries for Response Batches

### Need First Response
```jql
project={{ vars.jiraProject }} AND comment is EMPTY AND created > -{{ vars.slaHours }}h AND status=Open
```

### Approaching SLA
```jql
project={{ vars.jiraProject }} AND comment is EMPTY AND created > -20h AND created < -{{ vars.slaHours }}h
```

### High Priority Needing Updates
```jql
project={{ vars.jiraProject }} AND priority IN (Highest, High) AND status="In Progress" AND updated < -12h
```

### Resolved, Need Closure Communication
```jql
project={{ vars.jiraProject }} AND status=Resolved AND resolution != EMPTY AND comment !~ "resolved"
```

### Waiting on Customer Response
```jql
project={{ vars.jiraProject }} AND status="Waiting for Customer" AND updated < -48h
```

---

## Response Structure Template

```
[1. GREETING]
Hi [Name],

[2. ACKNOWLEDGMENT]
Thank you for [reporting this / reaching out / your question].
I can see [their specific situation].

[3. EMPATHY/CONTEXT]
[Acknowledge impact, frustration, or importance]

[4. MAIN CONTENT]
[Solution steps / Explanation / Update / Escalation info]

[5. NEXT STEPS/TIMELINE]
[What happens next]
[When they'll hear from you]

[6. INVITATION/RESOURCES]
[Links to docs / Offer to help / Request for info]

[7. CLOSING]
Thanks,
[Your name]
```

---

## Tone Guidelines

### Apologetic (for bugs, outages, failures)
- "I apologize for..."
- "I'm sorry this is causing..."
- "This shouldn't have happened..."
- "We take this seriously..."

### Empathetic (for frustrated/blocked customers)
- "I understand this is frustrating..."
- "I can see this is impacting..."
- "I know this is urgent for you..."
- "This must be concerning..."

### Professional (for technical discussions)
- Clear, precise language
- Technical terms (with explanations)
- Structured information
- Data-driven

### Friendly (for questions, how-tos)
- "Great question!"
- "I'd be happy to help..."
- "Let me walk you through..."
- "Here's how..."

### Urgent (for critical issues)
- "I'm prioritizing this immediately"
- "Working on this now"
- "I'll keep you closely updated"
- "Monitoring continuously"

---

## Common Phrases by Response Type

### Acknowledgment
- "Thank you for reporting this"
- "I'm investigating now"
- "I'll have an update by [time]"
- "If you have additional details..."

### Solution
- "Here's how to resolve this:"
- "Follow these steps:"
- "You should see..."
- "Let me know if you need help with..."

### Explanation
- "Here's how this works:"
- "The expected behavior is..."
- "You can accomplish this by..."
- "For more details, see..."

### Escalation
- "I'm escalating this to our [team]"
- "What happens next:"
- "In the meantime, you can..."
- "I'm monitoring this closely"

### Status Update
- "I wanted to update you on..."
- "Progress so far:"
- "Next steps:"
- "Expected timeline:"

### Closure
- "Good news! This has been fixed"
- "The issue is now resolved"
- "Please verify that..."
- "Don't hesitate to reopen if..."

---

## Batch Processing Commands

### Fetch Tickets Needing Responses
```bash
# Get tickets as JSON
jira issue list \
  --jql="project={{ vars.jiraProject }} AND comment is EMPTY AND status=Open" \
  --format=json > /tmp/response-batch.json

# Get ticket keys only
jira issue list \
  --jql="[query]" \
  --plain --columns=key --no-headers > /tmp/ticket-keys.txt
```

### Loop Through Tickets
```bash
# Process each ticket
while read ticket; do
  echo "Processing $ticket..."

  # Fetch details
  jira issue view $ticket --format=json > /tmp/${ticket}.json

  # Generate response (your logic here)

  # Post response
  jira issue comment add $ticket --comment="[response text]"

done < /tmp/ticket-keys.txt
```

### Post Responses
```bash
# Post single response
jira issue comment add TICKET-KEY --comment="[response text]"

# Post with status update
jira issue comment add TICKET-KEY --comment="[response]"
jira issue move TICKET-KEY --status="In Progress"
```

---

## Quality Checklist

Before posting batch responses:

**Personalization**
- [ ] Uses reporter's name
- [ ] References specific issue from ticket
- [ ] Not generic copy/paste

**Clarity**
- [ ] Clear next steps or timeline
- [ ] No unexplained jargon
- [ ] Easy to understand

**Completeness**
- [ ] Answers all questions in ticket
- [ ] Provides necessary context
- [ ] Links to helpful resources

**Tone**
- [ ] Appropriate for situation
- [ ] Empathetic where needed
- [ ] Professional throughout

**Accuracy**
- [ ] Timeline is realistic
- [ ] Solution steps are correct
- [ ] Links work

---

## Time Estimates

| Activity | Time per Ticket | Notes |
|----------|----------------|-------|
| Read ticket | 1-2 min | Understand issue |
| Determine response type | 30 sec | Quick assessment |
| Draft response (template) | 2-3 min | With customization |
| Draft response (custom) | 5-10 min | Complex issues |
| Review response | 1 min | Proofread |
| Post response | 30 sec | JIRA CLI |
| **Total (batch/template)** | **4-6 min** | Using templates |
| **Total (individual)** | **8-14 min** | Custom writing |

**Batch efficiency**: ~30-40% faster than individual responses

---

## Response Templates Library

### Template: Acknowledgment (Standard)
```
Hi [Name],

Thank you for reporting this. I can see you're experiencing [brief issue] when [scenario].

I'm investigating this now and will have an update for you by [time]. In the meantime, if you have additional details, please share them here.

Thanks,
[Agent]
```

### Template: Acknowledgment (Urgent)
```
Hi [Name],

I understand this is impacting your [operations], and I'm prioritizing this immediately.

I'm investigating now and will update you by [very near time]. I'll keep you closely informed.

Thanks,
[Agent]
```

### Template: Solution (Steps)
```
Hi [Name],

Here's how to resolve this:

1. [Step]
2. [Step]
3. [Step]

You should see [outcome]. Let me know if you need help!

Thanks,
[Agent]
```

### Template: Solution (Workaround)
```
Hi [Name],

While we work on a permanent fix, here's a workaround:

[Workaround description]

I know this isn't ideal, but it should unblock you. The permanent fix is expected [timeline].

Thanks,
[Agent]
```

### Template: Escalation
```
Hi [Name],

I'm escalating this to our [team] for investigation.

What happens next:
1. [Step]
2. [Timeline]
3. [Update schedule]

[If workaround:] In the meantime: [workaround]

I'm monitoring this closely.

Thanks,
[Agent]
```

### Template: Status Update
```
Hi [Name],

Quick update on your ticket:

Progress:
- [What's been done]
- [Current status]

Next steps:
- [What's next]
- [Timeline]

I'll update you again by [date].

Thanks,
[Agent]
```

### Template: Closure
```
Hi [Name],

Good news! The [issue] has been fixed.

What was done: [Explanation]

Please verify: [Test steps]

I'm marking this resolved, but please reopen if you need anything else.

Thanks,
[Agent]
```

### Template: Waiting on Customer
```
Hi [Name],

I wanted to follow up on my request for [information needed].

To continue, I need:
- [Item 1]
- [Item 2]

Please let me know if you have questions!

Thanks,
[Agent]
```

---

## Common Mistakes

❌ **Generic responses** - No personalization
✅ Use name, specific issue details

❌ **Vague timelines** - "Soon", "ASAP", "shortly"
✅ Specific times: "by 2pm today", "within 24 hours"

❌ **No next steps** - Customer left wondering what happens
✅ Clear: "I'll update you by...", "You should..."

❌ **Jargon overload** - Technical terms without explanation
✅ Explain terms or use simpler language

❌ **Copy/paste errors** - Wrong names, wrong issues
✅ Review each response before posting

❌ **No empathy** - Robotic, procedural
✅ Acknowledge impact, show understanding

---

## Batch Processing Best Practices

1. **Group by type** - Process similar responses together
2. **Use TodoWrite** - Track progress through large batches
3. **Save drafts** - Write to file, review all, then post
4. **Prioritize by SLA** - Critical tickets first
5. **Review before posting** - Catch mistakes early
6. **Test templates** - Verify they work before scaling
7. **Monitor results** - Check for customer replies

---

## Troubleshooting

**Issue**: Responses feel robotic
**Fix**: Add specific details from ticket, use customer's language

**Issue**: Taking too long per response
**Fix**: Use templates more, batch similar tickets

**Issue**: Customers confused by responses
**Fix**: Simplify language, add examples, remove jargon

**Issue**: Missing context in responses
**Fix**: Read full ticket history, not just summary

**Issue**: Timeline commitments not met
**Fix**: Be more conservative, add buffer time

---

## Additional Resources

- See `examples.md` for real batch processing scenarios
- See `SKILL.md` for detailed workflow
- See response-generator agent for single-ticket responses
