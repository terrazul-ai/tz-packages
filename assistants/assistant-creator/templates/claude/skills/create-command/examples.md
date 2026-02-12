# Claude Command Examples

Real-world examples of Claude Code commands with analysis.

## Example 1: Code Review Command

**File**: `.claude/commands/review.md`

```markdown
---
description: Review code for quality, security, and best practices
---

Review the following code: $ARGUMENTS

Analyze for:

## Code Quality
- Readability and naming conventions
- Code organization and structure
- Unnecessary complexity
- Code duplication

## Security
- Input validation
- SQL injection risks
- XSS vulnerabilities
- Authentication/authorization issues
- Sensitive data exposure

## Performance
- N+1 query patterns
- Unnecessary iterations
- Memory leaks
- Caching opportunities

## Best Practices
- Error handling
- Logging and monitoring
- Testing coverage
- Documentation

Provide a summary with:
- Overall assessment (approve/needs changes)
- Critical issues (must fix before merge)
- Suggestions (nice to have improvements)
```

**Usage**: `/review src/auth/login.ts`

**Analysis**:
- Clear description for command list
- Structured review process
- Covers multiple concerns
- Provides actionable output format

---

## Example 2: Test Generation Command

**File**: `.claude/commands/generate-tests.md`

```markdown
---
description: Generate unit tests for a file or function
---

Generate comprehensive unit tests for: $ARGUMENTS

Follow these guidelines:

1. **Identify test framework** used in this project (Jest, Vitest, pytest, etc.)

2. **Analyze the code** to understand:
   - Public API and methods
   - Edge cases and error conditions
   - Dependencies that need mocking

3. **Generate tests** that cover:
   - Happy path scenarios
   - Error handling
   - Edge cases (null, empty, boundary values)
   - Integration points (mocked)

4. **Follow project conventions**:
   - File naming: `*.test.ts` or `*.spec.ts`
   - Test organization: describe/it blocks
   - Assertion style matching existing tests

5. **Output**:
   - Complete test file ready to run
   - Clear test descriptions
   - Proper setup/teardown if needed
```

**Usage**: `/generate-tests src/utils/validation.ts`

**Analysis**:
- Adapts to project's test framework
- Comprehensive coverage strategy
- Follows existing conventions
- Produces ready-to-use output

---

## Example 3: Deploy Command (Mode Restricted)

**File**: `.claude/commands/deploy-staging.md`

```markdown
---
description: Deploy current branch to staging environment
allowed-modes:
  - code
---

Deploy the current branch to staging:

1. **Pre-flight checks**:
   - Verify on correct branch
   - Check for uncommitted changes
   - Run lint and type checks

2. **Build**:
   - Run production build
   - Verify build succeeds

3. **Deploy**:
   - Execute: `npm run deploy:staging`
   - Or use the project's deployment script

4. **Verify**:
   - Check deployment status
   - Report staging URL
   - Note any warnings or issues

If any step fails, stop and report the error clearly.
```

**Usage**: `/deploy-staging`

**Analysis**:
- Restricted to code mode (no planning needed)
- Clear step-by-step process
- Includes verification
- Handles failures gracefully

---

## Example 4: Explain Command

**File**: `.claude/commands/explain.md`

```markdown
---
description: Explain code, concepts, or architecture in detail
---

Explain $ARGUMENTS in detail.

If this is a file or code:
1. Read and analyze the code
2. Explain what it does at a high level
3. Break down key components
4. Describe data flow
5. Note any patterns or techniques used
6. Highlight potential issues or improvements

If this is a concept or architecture question:
1. Define the concept clearly
2. Explain how it applies to this codebase
3. Give concrete examples from the code
4. Discuss trade-offs or alternatives

Format the explanation for clarity:
- Use headers to organize sections
- Include code snippets where helpful
- Keep explanations accessible but thorough
```

**Usage**:
- `/explain src/services/auth.ts`
- `/explain how the routing system works`
- `/explain the event sourcing pattern here`

**Analysis**:
- Flexible - works with files or concepts
- Structured output
- Accessible explanations
- Context-aware to codebase

---

## Example 5: PR Description Command

**File**: `.claude/commands/pr-description.md`

```markdown
---
description: Generate a PR description from current changes
---

Generate a pull request description for the current changes.

1. **Analyze changes**:
   - Run `git diff main...HEAD` (or appropriate base branch)
   - Identify files changed
   - Understand the nature of changes

2. **Generate description**:

```markdown
## Summary
[2-3 sentence summary of what this PR does]

## Changes
- [Bullet list of key changes]
- [Group related changes together]

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing performed
- [ ] [Specific test scenarios]

## Screenshots
[If UI changes, note where screenshots should go]

## Notes
[Any additional context, deployment notes, or follow-up items]
```

3. **Output** the description ready to paste into GitHub/GitLab.
```

**Usage**: `/pr-description`

**Analysis**:
- No arguments needed - uses git state
- Standard PR template
- Includes testing checklist
- Ready for copy-paste

---

## Example 6: Namespaced Commands

**Directory**: `.claude/commands/db/`

**File**: `migrate.md`
```markdown
---
description: Run database migrations
---

Run database migrations:

1. Check migration status with `npm run db:status`
2. Run pending migrations with `npm run db:migrate`
3. Report which migrations were applied
4. If any migration fails, show the error and rollback instructions
```

**File**: `seed.md`
```markdown
---
description: Seed database with test data
---

Seed the database $ARGUMENTS:

If "reset" is specified, drop and recreate first.
Otherwise, add seed data to existing database.

1. Check current database state
2. Run seed command: `npm run db:seed`
3. Report what data was added
```

**File**: `rollback.md`
```markdown
---
description: Rollback last database migration
---

Rollback the most recent migration:

1. Show current migration status
2. Ask for confirmation before rollback
3. Execute: `npm run db:rollback`
4. Verify rollback succeeded
5. Show new migration status
```

**Usage**:
- `/db:migrate`
- `/db:seed reset`
- `/db:rollback`

**Analysis**:
- Related commands grouped by namespace
- Clear purpose for each
- Consistent structure across commands
- Good for complex workflows

---

## Example 7: Documentation Command

**File**: `.claude/commands/document.md`

```markdown
---
description: Generate or update documentation for code
---

Generate documentation for: $ARGUMENTS

Depending on what's provided:

**For a function/method**:
- JSDoc/docstring with description
- Parameter descriptions with types
- Return value description
- Usage example

**For a file/module**:
- Module-level documentation
- Exported functions/classes documented
- Usage examples

**For a directory/feature**:
- README.md with overview
- Architecture description
- Getting started guide
- API reference

Output documentation in the appropriate format for this project's conventions.
```

**Usage**:
- `/document src/utils/validators.ts`
- `/document src/api/`
- `/document the authentication system`

**Analysis**:
- Adapts to scope of request
- Follows project conventions
- Multiple output formats
- Practical examples included

---

## Anti-Patterns to Avoid

### Too Vague

**Bad**:
```markdown
Do stuff with the code: $ARGUMENTS
```

**Better**:
```markdown
Analyze the code for performance issues: $ARGUMENTS

Look for:
- N+1 queries
- Unnecessary loops
- Memory allocations in hot paths
```

### Missing Arguments

**Bad** (if user input needed):
```markdown
Review the specified file for security issues.
```

**Better**:
```markdown
Review the specified file for security issues: $ARGUMENTS
```

### Too Complex

**Bad**:
```markdown
Build the project, run all tests, lint the code, generate documentation,
deploy to staging, notify the team, update the changelog, and create
a release tag all at once.
```

**Better**: Split into focused commands:
- `/build`
- `/test`
- `/deploy-staging`
- `/release`

### Poor Description

**Bad**:
```markdown
---
description: Does things
---
```

**Better**:
```markdown
---
description: Generate TypeScript types from API schema
---
```
