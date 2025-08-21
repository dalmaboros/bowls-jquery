<!--
============================================================================
DO NOT MODIFY THIS SECTION - INSTRUCTIONS FOR LLM
============================================================================
### 3. Worktree Comparison Workflow

**The Problem:** You've implemented a new feature but broke existing functionality. Main branch was working, your feature branch has the new feature but breaks something else.

**The Solution:** Use git worktree to compare your branch against the working main branch, then fix the regression while keeping your new feature.

**Instructions for LLM:**
1. Do NOT apply code changes immediately - analyze first
2. Use the git worktree setup to compare main vs current branch
3. Identify what broke and why
4. Create a plan to fix the regression while preserving the new feature
5. Document findings in systematic format

**Worktree Usage:**
- User sets up: `git worktree add main` (creates main/ folder with working version)
- LLM analyzes: Compare current branch vs main/ folder
- User cleans up: `git worktree remove main` when done
============================================================================
END OF INSTRUCTIONS - DO NOT MODIFY ABOVE THIS LINE
============================================================================
-->

# Worktree Comparison Workflow

## The "1 Step Forward, 2 Steps Back" Problem

**You've built a feature, but something else broke.** Main branch was working perfectly, your feature branch has the new functionality but broke existing behavior.

## Setup

Before starting, set up the worktree comparison:

```bash
# Add main branch as a worktree for direct comparison
git worktree add main
```

This creates a `main/` folder with the working version from main branch.

## LLM Analysis Prompt

```
Carefully examine our `main` branch repo (available in the main/ folder from worktree) and compare it to our current branch.

Your tasks:
1. **Identify what broke:** What functionality worked in main but is broken in our current branch?
2. **Root cause analysis:** Why did our new feature break existing functionality?
3. **Impact assessment:** What files/components are affected?
4. **Fix strategy:** How can we preserve our new feature while restoring the broken functionality?

Do NOT apply code changes yet - just analyze and document your findings.
```

## Integration with Feature Development

After worktree analysis, you can use the standard `1_Develop-Feature` workflow:

- **A-task.md**: 
  - Current Behavior: What's broken compared to main
  - Desired Behavior: Keep new feature + restore main functionality
- **B-research.md**: LLM analyzes the differences and proposes solutions
- **C-implementation-steps.md**: Step-by-step fix plan

## Cleanup

When finished with comparison:

```bash
git worktree remove main
```

## Common Use Cases

- **Styling conflicts:** New component breaks existing UI
- **API changes:** New endpoint breaks existing API consumers  
- **State management:** New feature interferes with existing state
- **Performance regressions:** New feature slows down existing functionality

---

**Key Insight:** Instead of reverting your feature, use worktree to understand exactly what changed and fix it surgically.

<!--
============================================================================
DO NOT MODIFY BELOW THIS LINE - MARKDOWN STYLES
============================================================================
-->
<style>
  body {
    background-color: white !important;
    color: #222 !important;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
    border-left: 4px solid black;
    border-right: 4px solid black;
    box-sizing: border-box;
  }

  pre, code {
    background-color: #f5f5f5 !important;
    color: #111 !important;
    padding: 4px;
    border-radius: 4px;
  }

  h1, h2, h3, h4 {
    color: #111 !important;
    border-bottom: 1px solid #ccc;
    padding-bottom: 4px;
  }

  a {
    color: #0645AD !important;
  }
</style>