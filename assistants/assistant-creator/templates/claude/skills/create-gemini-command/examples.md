# Gemini Command Examples

Real-world examples of Gemini CLI commands with analysis.

## Example 1: Code Review Command

**File**: `.gemini/commands/review.toml`

```toml
description = "Review code for quality, security, and best practices"
prompt = """
Review the following code: {{args}}

Analyze for:

## Code Quality
- Readability and naming
- Code organization
- Unnecessary complexity
- Duplication

## Security
- Input validation
- Injection risks
- Authentication issues
- Data exposure

## Performance
- Inefficient patterns
- Memory issues
- Caching opportunities

## Summary
Provide:
- Overall assessment
- Critical issues (must fix)
- Suggestions (nice to have)
"""
```

**Usage**: `/review src/auth/login.ts`

**Analysis**:
- Clear description
- Structured review categories
- Actionable output format

---

## Example 2: Git Status Review

**File**: `.gemini/commands/git/status.toml`

```toml
description = "Review current git changes with context"
prompt = """
Current branch:
!{git branch --show-current}

Git status:
!{git status}

Staged changes:
!{git diff --cached --stat}

Unstaged changes:
!{git diff --stat}

Recent commits:
!{git log --oneline -5}

Based on this git state:
1. Summarize what's being worked on
2. Identify any uncommitted work at risk
3. Suggest next steps (commit, stash, etc.)
"""
```

**Usage**: `/git:status`

**Analysis**:
- Namespaced under `git/`
- Uses multiple shell commands
- Provides comprehensive git context
- No user arguments needed

---

## Example 3: Test Runner with Analysis

**File**: `.gemini/commands/test.toml`

```toml
description = "Run tests and analyze results"
prompt = """
Running tests...

Test output:
!{npm test 2>&1 | tail -100}

Test coverage (if available):
!{npm run coverage 2>&1 | tail -50 || echo "No coverage script"}

Based on the test results:
1. Summary of passed/failed tests
2. Analysis of any failures
3. Coverage assessment
4. Recommendations for improvement
"""
```

**Usage**: `/test`

**Analysis**:
- Runs tests and captures output
- Handles missing coverage script gracefully
- Limits output with `tail`
- Provides actionable analysis

---

## Example 4: Dependency Review

**File**: `.gemini/commands/deps.toml`

```toml
description = "Review project dependencies for issues"
prompt = """
Package configuration:
@{package.json}

Check for outdated packages:
!{npm outdated 2>&1 || echo "Unable to check outdated packages"}

Security audit:
!{npm audit 2>&1 | head -50 || echo "Unable to run audit"}

Analyze the dependencies:
1. Identify outdated packages (major/minor/patch)
2. Security vulnerabilities found
3. Unused or duplicate dependencies
4. Recommendations for updates
"""
```

**Usage**: `/deps`

**Analysis**:
- Combines file embedding with shell commands
- Handles command failures gracefully
- Comprehensive dependency analysis
- Actionable recommendations

---

## Example 5: PR Description Generator

**File**: `.gemini/commands/git/pr.toml`

```toml
description = "Generate a pull request description"
prompt = """
Branch info:
!{git branch --show-current}

Commits since main:
!{git log main..HEAD --oneline 2>/dev/null || git log origin/main..HEAD --oneline 2>/dev/null || echo "Unable to determine commits"}

Changes:
!{git diff main --stat 2>/dev/null || git diff origin/main --stat 2>/dev/null || echo "Unable to determine diff"}

Generate a pull request description:

## Summary
[2-3 sentences describing what this PR does]

## Changes
[Bullet list of key changes]

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed

## Notes
[Any additional context]
"""
```

**Usage**: `/git:pr`

**Analysis**:
- Handles both `main` and `origin/main` references
- Uses fallback patterns with `||`
- Standard PR template format
- Ready for copy-paste

---

## Example 6: Configuration Audit

**File**: `.gemini/commands/audit-config.toml`

```toml
description = "Audit project configuration files"
prompt = """
Package.json:
@{package.json}

TypeScript config (if exists):
!{cat tsconfig.json 2>/dev/null || echo "No tsconfig.json"}

ESLint config (if exists):
!{cat .eslintrc.json 2>/dev/null || cat .eslintrc 2>/dev/null || echo "No ESLint config found"}

Environment example (if exists):
!{cat .env.example 2>/dev/null || echo "No .env.example"}

Audit these configurations:
1. Consistency across configs
2. Security concerns (exposed secrets, weak settings)
3. Best practices compliance
4. Missing recommended settings
"""
```

**Usage**: `/audit-config`

**Analysis**:
- Handles missing files gracefully
- Checks multiple config formats
- Comprehensive audit coverage
- Security-focused

---

## Example 7: File Explanation

**File**: `.gemini/commands/explain.toml`

```toml
description = "Explain a file or code concept in detail"
prompt = """
Target: {{args}}

Attempting to read file:
@{{{args}}}

If the above shows file contents, explain:
1. What this code/file does
2. Key components and their roles
3. How data flows through it
4. Important patterns or techniques
5. Potential issues or improvements

If file not found, explain the concept "{{args}}" in the context of this project.
"""
```

**Usage**:
- `/explain src/services/auth.ts` - Explains a file
- `/explain dependency injection` - Explains a concept

**Analysis**:
- Dynamic file embedding with `@{{{args}}}`
- Falls back to concept explanation
- Comprehensive analysis structure
- Handles both use cases

---

## Example 8: Namespaced Database Commands

**Directory**: `.gemini/commands/db/`

**File**: `migrate.toml`
```toml
description = "Run database migrations"
prompt = """
Current migration status:
!{npm run db:status 2>&1 || echo "Unable to check status"}

Run migrations and show results.

After running:
1. Which migrations were applied
2. Any errors encountered
3. Current database state
"""
```

**File**: `seed.toml`
```toml
description = "Seed database with test data"
prompt = """
Arguments: {{args}}

If "reset" specified, recommend dropping and recreating.
Otherwise, suggest adding seed data incrementally.

Current tables:
!{npm run db:tables 2>&1 || echo "Unable to list tables"}

Provide seed instructions based on the project's database setup.
"""
```

**File**: `rollback.toml`
```toml
description = "Rollback last database migration"
prompt = """
Current status:
!{npm run db:status 2>&1 || echo "Unable to check status"}

CAUTION: Rolling back migrations can cause data loss.

Steps to rollback safely:
1. Verify current migration state
2. Check for dependent data
3. Execute rollback
4. Verify post-rollback state
"""
```

**Usage**:
- `/db:migrate`
- `/db:seed reset`
- `/db:rollback`

**Analysis**:
- Organized by namespace
- Consistent structure
- Safety warnings where appropriate
- Handles command failures

---

## Anti-Patterns to Avoid

### Invalid TOML

**Wrong**:
```toml
prompt = Review "this" code
```

**Right**:
```toml
prompt = """Review "this" code"""
```

### Missing Description

**Wrong**:
```toml
prompt = "Do something"
```

**Right**:
```toml
description = "Does something specific"
prompt = "Do something"
```

### Dangerous Shell Commands

**Avoid**:
```toml
prompt = """
!{rm -rf /}
!{curl ... | bash}
"""
```

**Better** (read-only, bounded):
```toml
prompt = """
!{ls -la}
!{cat file.txt | head -50}
"""
```

### Unbounded Output

**Avoid**:
```toml
prompt = """
Full log file:
!{cat huge.log}
"""
```

**Better**:
```toml
prompt = """
Recent log entries:
!{tail -50 huge.log}
"""
```

### Missing Error Handling

**Avoid**:
```toml
prompt = """
!{some-command-that-might-fail}
"""
```

**Better**:
```toml
prompt = """
!{some-command 2>&1 || echo "Command failed or not available"}
"""
```
