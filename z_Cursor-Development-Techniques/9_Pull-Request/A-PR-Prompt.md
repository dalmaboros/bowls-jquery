**PULL REQUEST PREPARATION PROMPT**

## For INDIVIDUAL PR PREPARATION:

### **PR Workflow:**
1. **Generate focused diff**: `git diff main...HEAD > B-PR-Diff.txt` (shows only your branch commits)
2. **OVERWRITE C-PR-Notes.md**: Replace ALL content with fresh analysis of ONLY the current branch changes
3. **NO VERSION BUMP**: Version updates happen at release time (see B2_Release-Management/A-Release-Prompt.md)
4. **Create PR description**: Use relevant sections from C-PR-Notes.md for GitHub PR description (keep concise!)

### **PR Analysis Guidelines (C-PR-Notes.md):**
- **🚨 CRITICAL**: COMPLETELY REPLACE all existing content - do not append or keep history
- **🎯 CONCISE FORMAT**: Keep entire analysis under 1000 characters
- **📊 TABLE FIRST**: Start with comparison table showing main vs current branch behavior
- **🔄 Table Structure**:
  - Columns: "Feature" | "Main Branch Behavior" | "Current Branch Behavior"  
  - Rows: Each major change/feature modified in this PR
- **📝 Supporting Sections**: Brief bullet points for Impact, Testing, Files
- **❌ NO VERBOSE**: Avoid long paragraphs, technical deep-dives, or redundant explanations
- **✅ SCANNABLE**: Reviewers should understand changes in 30 seconds

### **Template Structure:**
```markdown
# [Feature Name] - PR Analysis

## 🔄 **Main Changes**
| Feature | Main Branch Behavior | Current Branch Behavior |
|---------|---------------------|-------------------------|
| **Feature 1** | Old behavior | New behavior |
| **Feature 2** | Old behavior | New behavior |

## 🎯 **Impact**
- Bullet point 1
- Bullet point 2

## 🧪 **Testing**
- ✅ Test scenario 1
- ✅ Test scenario 2

## 📁 **Files**
- `file1.py` - Brief change description
- `file2.py` - Brief change description
```

### **GitHub PR Description:**
- **Extract relevant sections** from C-PR-Notes.md
- **Keep concise**: Focus on the main changes in this PR
- **Include context**: Why was this change needed?
- **List modified files**: Help reviewers understand scope
- **Testing notes**: How to verify the changes work

### **PR Checklist:**
- [ ] Branch changes analyzed in C-PR-Notes.md
- [ ] GitHub PR description prepared from C-PR-Notes.md
- [ ] All code changes tested locally
- [ ] No version bumps (those happen at release time)
- [ ] Documentation updated if needed

**Important Notes**: 
- For release preparation including version bumps and changelog updates, see `B2_Release-Management/A-Release-Prompt.md`
- **Permanent history lives in `C_0C_CHANGELOG.md`** - C-PR-Notes.md is for current PR only
- C-PR-Notes.md gets completely rewritten for each new PR

----- DO NOT OVERWRITE PROMPT ABOVE ------- 
