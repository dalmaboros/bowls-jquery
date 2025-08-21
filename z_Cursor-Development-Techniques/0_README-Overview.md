
# Cursor Development Techniques

## Table of Contents
- [Setting Up Your Environment](#setting-up-your-environment)
- [1. Feature Development (Two-Phase Process)](#1-feature-development-two-phase-process)
- [2. Debug Workflow](#2-debug-workflow)
- [3. Worktree Comparison](#3-worktree-comparison)
- [9. Pull Request Archive](#9-pull-request-archive)
- [Additional Tools](#additional-tools)

---

## Setting Up Your Environment

### Markdown Extensions
- **Enhanced Preview:** 
  - Extension: https://marketplace.cursorapi.com/items/?itemName=shd101wyy.markdown-preview-enhanced
  - `cmd + shift + p` → "Markdown Preview Enhanced: Open Preview to the Side"
- **Context7 MCP** (see below)
- **Personal sort order:** VS Code Settings → type in "sort order" → Explorer: Sort Order - set to mixed

---

## Overview

**Here's the problem this solves:** LLMs are powerful, but they often jump straight to implementation without understanding the full context. They miss edge cases, write code that doesn't integrate well, and create solutions that are hard to verify.

**This folder contains structured workflows** that force both you and the LLM to slow down and think through problems systematically. Each numbered folder represents a different phase of development, with templates that guide the LLM through proper analysis and implementation.

**Key Principles:**
- **Structured workflows** prevent common LLM pitfalls
- **Template-based approaches** ensure consistency every time
- **Verification-focused** processes with clear checkpoints
- **Reusable methodologies** for different development scenarios

---

## 1. Feature Development (Two-Phase Process)

**Location:** `1_Develop-Feature/` folder

**The big idea:** Separate research from implementation. Most LLM coding failures happen because we skip the research phase.

### Phase 1: Research & Analysis
- **You fill out:** `A-task.md` (what you want)
- **LLM fills out:** `B-research.md` (analysis and options)
- **Research Tools:** Context7 MCP is integrated for online documentation lookup and research
- **Key benefit:** LLM asks clarifying questions about edge cases before writing any code

**Important:** You should be reading through the research document and perhaps iterating over it a few times before you even get to implementation and execution. You should understand how to implement this - spend the time to slow down and learn from the analysis.

### Phase 2: Implementation & Execution  
- **LLM creates:** `C-implementation-steps.md` (detailed plan)
- **Then implements:** Step-by-step with verification at each stage
- **Key features:** Debug logging, logical grouping, clear verification methods

**Why this works:** Forces thorough analysis before implementation, gives you multiple solution approaches to choose from, and provides a clear execution plan with verification checkpoints.


### Other Markdown Techniques
- Ask Cursor to generate mermaid diagrams within markdown for higher level system diagrams.
- Markdown to analyze markdown - 😅  even to analyze this presentation.


---

## 2. Debug Workflow

**Location:** `2_Debug/` folder

**Usage:** When something breaks, use these files for logs and attach them in Cursor. <br/><br/>
 Increase your terminal scrollback history in VS Code settings<br/><br/>
`A-FrontendConsole.txt` - <br/>
`B-BackendConsole.txt` <br/>
<br/>

For further frontend analysis: <br/>
`C-Current.html` <br/>
`C-Target.html` <br/>

Example: Your current branch has a broken FE element. Paste that into `C-Current.html`<br/> 
`main` or whatever working branch has correct DOM structure, paste that into `C-Target.html`


---

## 3. Worktree Comparison

**Location:** `3_Worktree/` folder

**The classic problem:** You've built a great new feature, but now something else is broken. We've all been there - one step forward, two steps back.

**The worktree approach:** Instead of panicking or reverting everything, use git worktree to pull your working main branch right into your project folder. Now you can compare what's different between your feature branch and the version that was working.

**How it flows:**
1. Set up worktree with `git worktree add main`
2. LLM analyzes both versions side-by-side
3. Often works great with the `1_Develop-Feature` templates - just describe what broke vs what should work
4. Clean up with `git worktree remove main`

**Why this rocks:** You get to keep your new feature while surgically fixing what broke, instead of starting over or spending hours guessing what went wrong.

---

## 9. Pull Request Archive

**Location:** `9_Pull-Request/` folder


**Usage:**  Attach A-PR-Prompt.md and ask Cursor "Follow the prompt steps"

---

## Additional Notes 

### Voice & Screenshots
- **SuperWhisper:** Voice-to-text for Mac - https://superwhisper.com
- **Shottr:** Targeted screenshots that don't clutter Desktop and you can modify - https://shottr.cc/ 

- **Context 7 MCP:** https://context7.com/ (**Highly recommended**) (Already integrated into our `1_Develop-Feature` "research phase")

- **Taskmaster:** Development workflow insights (have not tried watched a video - this is exactly what my folder already doe, I actually prefer my method) - https://www.youtube.com/watch?v=UtkPb9UevBM

- Browser automation - https://browser-use.com/ (have not fully used but its supposed to have access to your Chrome and can read your console.logs)

---

## Getting Started

**For your first feature:**
1. Start with `1_Develop-Feature/` - fill out the task, let the LLM research
2. Use `2_Debug/` when things break (they will)
3. Use `3_Worktree/` when you've broken something that was working
4. Reference `99_Pull-Request/` for examples of completed workflows

**The key insight:** These aren't just templates - they're guardrails that prevent the most common LLM coding mistakes. Use them consistently, and you'll see dramatically better results.

---


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

  hr {
    border: none;
    border-top: 2px solid #ccc;
    margin: 20px 0;
  }

  a {
    color: #0645AD !important;
  }
</style>
