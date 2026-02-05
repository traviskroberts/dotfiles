---
description: Investigate why a main branch build failure wasn't caught in PR CI
argument-hint: <MAIN_BUILD_URL|RUN_ID> [PR_URL|PR_NUMBER]
allowed-tools: [Bash, Read, Grep, Glob, Task, WebFetch]
---

# Main Branch Failure Investigation

Investigates why a build failure on main wasn't caught during PR CI. Determines if tests were:
- **Skipped by Datadog ITR** (Intelligent Test Runner)
- **Passed but are flaky** (non-deterministic)
- **Not run due to merge timing** (test introduced by different PR)
- **Passed but code changed** (logical merge conflict)

## Input Formats

Supports:
- Main build URL: `https://github.com/betterup/betterup-monolith/actions/runs/12345`
- Run ID: `12345678901`
- Optionally, a specific PR to investigate: `... PR#24289` or `... https://github.com/betterup/betterup-monolith/pull/24289`

Arguments provided: `$ARGUMENTS`

## Investigation Steps

### Step 1: Parse Input and Get Main Build Details

Extract the run ID from the input and fetch the main build failure details.

```bash
INPUT="$ARGUMENTS"

# Extract main run ID from URL or direct input
if [[ "$INPUT" =~ runs/([0-9]+) ]]; then
  MAIN_RUN_ID="${BASH_REMATCH[1]}"
elif [[ "$INPUT" =~ ^[0-9]+$ ]]; then
  MAIN_RUN_ID="$INPUT"
else
  # Try to extract first number-like thing
  MAIN_RUN_ID=$(echo "$INPUT" | grep -oE '[0-9]{10,}' | head -1)
fi

# Extract PR number if provided
if [[ "$INPUT" =~ pull/([0-9]+) ]] || [[ "$INPUT" =~ PR#?([0-9]+) ]]; then
  PR_NUMBER="${BASH_REMATCH[1]}"
fi

echo "Main Run ID: $MAIN_RUN_ID"
echo "PR Number: ${PR_NUMBER:-'(will auto-detect from merge commits)'}"
```

### Step 2: Get Failed Tests from Main Build

```bash
# Get failed jobs from the main build
gh api repos/betterup/betterup-monolith/actions/runs/$MAIN_RUN_ID/jobs --paginate \
  --jq '.jobs[] | select(.conclusion == "failure") | {name: .name, id: .id}' 2>&1
```

### Step 3: Extract Specific Test Failures

For each failed test job, get the failure details:

```bash
# Get the failed Rails Tests job ID (example pattern)
FAILED_JOB_ID=$(gh api repos/betterup/betterup-monolith/actions/runs/$MAIN_RUN_ID/jobs --paginate \
  --jq '.jobs[] | select(.conclusion == "failure" and (.name | contains("Rails Tests"))) | .id' | head -1)

if [ -n "$FAILED_JOB_ID" ]; then
  echo "Fetching logs from failed job $FAILED_JOB_ID..."
  gh api repos/betterup/betterup-monolith/actions/jobs/$FAILED_JOB_ID/logs 2>&1 | \
    grep -E "Test failed|1st Try error|Failure/Error|_spec\.rb:[0-9]+" | head -50
fi
```

### Step 4: Find Related PRs

If no PR was specified, find PRs that were merged around the time of the failure:

```bash
# Get the commit SHA from the main run
COMMIT_SHA=$(gh api repos/betterup/betterup-monolith/actions/runs/$MAIN_RUN_ID --jq '.head_sha')

# Find PRs merged near this commit
gh api repos/betterup/betterup-monolith/commits/$COMMIT_SHA/pulls --jq '.[].number' 2>&1
```

### Step 5: Check PR's CI Run for the Test

For each related PR, check if the failing test was run:

```bash
# Get the PR's workflow run
PR_RUN_ID=$(gh api "repos/betterup/betterup-monolith/actions/runs?branch=<PR_BRANCH>&event=pull_request&per_page=10" \
  --jq '.workflow_runs[] | select(.name | contains("Build and Test")) | .id' | head -1)

# Search for the specific failing test across all runners
for job_id in $(gh api repos/betterup/betterup-monolith/actions/runs/$PR_RUN_ID/jobs --paginate \
  --jq '.jobs[] | select(.name | contains("Rails Tests")) | .id'); do
  result=$(gh api repos/betterup/betterup-monolith/actions/jobs/$job_id/logs 2>&1 | grep "<TEST_FILE_NAME>")
  if [ -n "$result" ]; then
    echo "Found test in job $job_id"
    echo "$result"
  fi
done
```

## Investigation Report Template

After gathering data, provide a report structured as:

### Summary
- **Main Build**: [Run URL]
- **Failing Test(s)**: [List spec files and line numbers]
- **Related PR(s)**: [PR numbers with links]

### Root Cause Classification

Classify as one of:

1. **Datadog ITR Skip**: Test was skipped by Intelligent Test Runner
   - Evidence: Test not present in any PR runner logs
   - Datadog believed the test wasn't affected by changes

2. **Flaky Test**: Test passed on PR but fails intermittently
   - Evidence: Test was run and passed on PR, but fails on main
   - May require retry analysis

3. **Merge Timing Issue**: Test or code introduced by different PR
   - Evidence: Test file or tested code didn't exist in the PR branch
   - Two PRs merged in close succession with conflicting changes

4. **Logical Merge Conflict**: Both PRs passed individually but conflict together
   - Evidence: Both tests and code existed but interaction wasn't tested
   - Base branch changes between PR test run and merge

### Evidence

- Show relevant log snippets
- Show git history for the test file
- Show commits between PR head and merge

### Recommendations

Based on root cause:
- **ITR Skip**: Consider adding test to ITR bypass list or adjusting impact analysis
- **Flaky**: Mark for quarantine investigation
- **Merge Timing**: Consider requiring rebase before merge
- **Logical Conflict**: Consider merge queue or dependent PR testing

## Key API Commands Reference

```bash
# Get main build info
gh api repos/betterup/betterup-monolith/actions/runs/<RUN_ID>

# Get PR info
gh pr view <PR_NUMBER> --json headRefName,mergeCommit,commits,statusCheckRollup

# Get workflow runs for a branch
gh api "repos/betterup/betterup-monolith/actions/runs?branch=<BRANCH>&per_page=30"

# Get job logs
gh api repos/betterup/betterup-monolith/actions/jobs/<JOB_ID>/logs

# Compare commits
gh api "repos/betterup/betterup-monolith/compare/<BASE>...<HEAD>" --jq '.commits[].commit.message'

# Check if file exists at commit
git show <COMMIT>:<FILE_PATH>

# Get file commit history
git log --oneline --all --source -- "<FILE_PATH>"
```

## Your Task

1. **Parse the input** to identify the main build failure and any specified PR
2. **Extract failing test details** from the main build logs
3. **Identify related PRs** that contributed to the failing code
4. **For each PR, determine**:
   - Was the test run? (search all Rails test runner logs)
   - If run, did it pass or fail?
   - If not run, why? (Datadog skip, test didn't exist, etc.)
5. **Check for merge timing issues** by examining:
   - When the test file was introduced
   - Commits between PR head and merge to main
   - Whether the test/code came from a different PR
6. **Produce a clear investigation report** with root cause classification and evidence
