# Response Draft Examples

Practical examples of batch response generation.

---

## Example 1: Morning Batch Acknowledgments

### Scenario
10 new tickets created overnight, all need acknowledgment to stay within SLA.

### Tickets
- SUPPORT-601 to SUPPORT-610
- All created between 11pm - 7am
- Mix of bugs, questions, feature requests
- All have < 18 hours until SLA breach

### Approach
Generate acknowledgment responses for all, customized by issue type.

### Results

**Bug Reports (4 tickets)** - Template: Apologetic + Investigation
```
Hi [Name],

Thank you for reporting this. I can see you're experiencing [specific bug] when [scenario], and I apologize for the inconvenience this is causing.

I'm investigating this now to identify the root cause. I'll have an update for you by [today at 2pm] with either a fix or a clear timeline.

If you notice any additional details about when this occurs, please share them - it will help speed up the investigation.

Thanks,
[Agent]
```

**Questions (3 tickets)** - Template: Helpful + Clear
```
Hi [Name],

Great question about [topic]! I'd be happy to help clarify how [feature] works.

I'm researching the best way to explain this and will respond with detailed guidance by [today at 12pm]. I'll include examples and documentation links.

Thanks,
[Agent]
```

**Feature Requests (3 tickets)** - Template: Appreciative + Process
```
Hi [Name],

Thank you for this suggestion! I can see how [feature] would be valuable for [use case].

I've logged this as a feature request for our product team to review. I'll update you by [end of week] on how this fits into our roadmap planning.

Thanks,
[Agent]
```

### Time Saved
- Traditional: 10 min per ticket = 100 min
- With batch: 30 min total (3 min per ticket)
- **Saved: 70 minutes**

---

## Example 2: Status Updates for In-Progress Tickets

### Scenario
15 high-priority tickets "In Progress" but no update in 24+ hours. Customers may be wondering about status.

### Query
```jql
project={{ vars.jiraProject }} AND priority IN (Highest, High) AND status="In Progress" AND updated < -24h
```

### Approach
Proactive status updates to maintain communication.

### Response Pattern

**Still Investigating**:
```
Hi [Name],

I wanted to update you on your ticket. Our team is actively investigating the [issue/bug/problem].

**Progress so far**:
- [What's been done]
- [Current findings]

**Next steps**:
- [What happens next]
- [Expected timeline]

I'll update you again by [specific date/time] even if we don't have a complete resolution yet.

Thanks,
[Agent]
```

**Escalated to Engineering**:
```
Hi [Name],

Quick update: Our engineering team is working on this. They've identified [finding] and are developing a fix.

**Timeline**:
- Testing: [Date]
- Deployment: [Date]
- Verification: [Date]

I'm monitoring this closely and will notify you as soon as the fix is deployed.

Thanks,
[Agent]
```

**Waiting on Customer**:
```
Hi [Name],

I wanted to follow up on my previous message requesting [information needed].

To continue investigating, I need:
- [Item 1]
- [Item 2]

Once I have this information, I can [next step]. Please let me know if you have any questions about what's needed.

Thanks,
[Agent]
```

---

## Example 3: Batch Closures After Fix Deployment

### Scenario
After deploying bug fix, 8 tickets can be closed. Need to inform customers and verify resolution.

### Tickets
All related to authentication bug, fixed in v2.5.1 deployment.

### Response
```
Hi [Name],

Good news! The authentication issue you reported has been fixed and deployed to production.

**What was fixed**:
We identified and corrected a bug in our session management that was causing intermittent login failures.

**What you should see now**:
- Consistent successful logins
- No more "session expired" errors
- Faster authentication response times

**Please verify**:
Could you test logging in again and confirm it's working as expected? If you're still experiencing any issues, please let me know immediately and I'll investigate further.

I'm marking this ticket as resolved, but don't hesitate to reopen it or create a new ticket if needed.

Thanks for your patience while we worked through this!

[Agent]
```

**Actions**:
1. Post response to all 8 tickets
2. Transition status: In Progress → Resolved
3. Monitor for any reopens in next 24 hours

---

## Example 4: Different Tones for Different Customers

### Scenario
5 tickets about same issue, but different customer types require different tones.

### Issue
Dashboard performance degradation after deployment.

### Enterprise Customer (SUPPORT-701)
**Tone**: Professional, detailed, timeline-focused
```
Hi [Executive Name],

I want to update you on the dashboard performance issue you've reported.

**Current Status**:
We've identified the root cause: a database query optimization introduced in Tuesday's deployment is causing slower load times for large datasets like yours.

**Action Plan**:
- Immediate: We've rolled back the optimization for your account
- This week: Engineering is refactoring the query to handle enterprise-scale data
- Next deployment (Friday): Optimized version that improves performance

**Your Experience Now**:
You should see dashboard loading return to normal speeds within the next hour.

I'm personally monitoring this and will update you daily until the permanent fix is deployed. Please contact me directly if you have any concerns.

[Senior Agent/Account Manager]
```

### Standard Paying Customer (SUPPORT-702, 703, 704)
**Tone**: Empathetic, clear, helpful
```
Hi [Name],

Thank you for reporting the slow dashboard loading. We've identified the cause and are working on a fix.

**What's happening**:
A recent update affected dashboard performance for accounts with large amounts of data.

**What we're doing**:
- Short-term: Optimizing your account specifically (completing within 2 hours)
- This week: Deploying a permanent fix for all accounts

You should see improvement within the next 2 hours. I'll update you once the fix is complete.

Thanks for your patience!

[Agent]
```

### Trial User (SUPPORT-705)
**Tone**: Friendly, informative
```
Hi [Name],

Thanks for the feedback about dashboard performance! We're aware of this and working on it.

We've identified the issue and are deploying a fix this week. You should see improved loading times in the next few days.

Let me know if you have any questions!

[Agent]
```

**Key Difference**: Same issue, tailored communication based on relationship and SLA.

---

## Example 5: Efficient Response Workflow

### Scenario
20 tickets need responses across different types. Use batching for efficiency.

### Organization
1. **Critical (2 tickets)** - Individual, detailed responses
2. **Acknowledgments (8 tickets)** - Batch with template
3. **Solutions (5 tickets)** - Batch with customization
4. **Updates (5 tickets)** - Batch status updates

### Time Allocation
- Critical: 10 min each = 20 min
- Acknowledgments: 3 min each = 24 min
- Solutions: 5 min each = 25 min
- Updates: 3 min each = 15 min
- **Total: 84 minutes**

### Workflow
1. Start with critical tickets (highest priority, individual attention)
2. Batch acknowledgments (similar structure, faster)
3. Batch solutions (group by issue type)
4. Batch updates (proactive communication)

### Result
- All 20 tickets receive appropriate responses
- SLA compliance maintained
- Quality remains high
- Efficient use of time

---

## Key Lessons

### Lesson 1: Templates Save Time, Customization Maintains Quality
Use templates for structure, but personalize for the ticket.

### Lesson 2: Group Similar Tickets
Process similar response types together for efficiency.

### Lesson 3: Prioritize by SLA and Impact
Critical tickets get individual attention, standard tickets can be batched.

### Lesson 4: Proactive Updates Build Trust
Don't wait for customers to ask for updates.

### Lesson 5: Tone Matters
Match response tone to customer relationship and situation.

### Lesson 6: Review Before Posting
Batch generation is fast, but review ensures quality.

### Lesson 7: Track Progress
Use TodoWrite for large batches to stay organized.
