<!--
============================================================================
DO NOT MODIFY THIS SECTION - INSTRUCTIONS FOR LLM
============================================================================
### Phase 1: Research & Analysis

**Instructions for LLM:**
1. Read the user's request from the attached `A-task.md`.
2. Fill out ONLY the sections marked with "LLM: FILL OUT BELOW" in this file.
3. Do NOT modify any text above the "LLM: FILL OUT BELOW" markers.
4. Do NOT modify the markdown styles at the bottom of this file.
5. **RESEARCH TOOLS**: Use Context7 MCP server for online research and documentation lookup. When you need to:
   - Look up library/framework documentation
   - Research best practices or current standards
   - Understand API specifications
   - Get up-to-date information about technologies
   **Always use Context7 to search the web and access current documentation.**
6. Your tasks:
   - In "Feature Request Summary": Restate the request in your own words to confirm understanding.
   - In "Edge Cases & Clarifications": Ask specific questions about unclear aspects, edge cases, or assumptions.
   - In "Codebase Analysis": Investigate and document relevant code, file paths, snippets, data flow.
   - In "Suggested Implementation Approaches": Outline 1-3 distinct strategies with pros/cons.
   - In "Initial Implementation Steps": Draft a preliminary high-level checklist.
7. **IMPORTANT**: If you discover ambiguities or edge cases, ask the user for clarification before proceeding.
8. Do NOT implement any code changes. This is research only.

**Phase 1 Usage:**
- User attaches: A-task.md + B-research.md
- LLM fills out: The five sections below marked with "LLM: FILL OUT BELOW"
- LLM should ask clarifying questions if needed before completing the analysis
- LLM should use Context7 MCP for any online research or documentation needs
============================================================================
END OF INSTRUCTIONS - DO NOT MODIFY ABOVE THIS LINE
============================================================================
-->

# Research & Analysis

## Feature Request Summary
<!-- LLM: FILL OUT BELOW - Restate the user's request in your own words -->
The goal is to fix a responsive layout bug for vertical videos in the feed. The current styling correctly centers the videos on desktop, but this same styling appears too small on mobile. The desired behavior is to keep the centered desktop layout while making the video fill the full screen width on mobile devices, providing an edge-to-edge experience.

## Edge Cases & Clarifications
<!-- LLM: FILL OUT BELOW - Ask specific questions about unclear aspects, edge cases, or assumptions -->
**Questions for User:**

1. **Breakpoint Definition**: You mentioned "mobile" vs "desktop" - should I use the standard 768px breakpoint, or does your design system use a different breakpoint for mobile/tablet/desktop?

2. **Tablet Behavior**: How should vertical videos behave on tablet-sized screens (e.g., 768px-1024px)? Should they use the mobile full-width approach or the desktop centered approach?

3. **Aspect Ratio Constraints**: Should the videos maintain their 9:16 aspect ratio on mobile, or is there flexibility here?

4. **Edge Case - Very Wide Mobile**: On very wide mobile devices (landscape orientation), should the video still fill the full width or should there be some reasonable maximum width?

5. **Testing Scope**: Are there specific devices or screen sizes you'd like me to prioritize for testing?

**Assumptions I'm Making:**
- The change should only affect vertical videos (not horizontal ones)
- The 9:16 aspect ratio should be maintained on mobile
- The change should be backward compatible with existing video players

## Codebase Analysis
<!-- LLM: FILL OUT BELOW - Document your investigation of the relevant codebase -->
The core of the issue lies in a CSS rule in `VideoJS-theme.css` that is applied to all screen sizes. This rule correctly styles the video for desktop but is not suitable for mobile.

**Relevant Files:**

*   `apps/web/components/special/VideoJS-theme.css`: **This is the primary file to modify.** We need to make its styles responsive.
*   `apps/web/components/feed/cards/VideoFeedCard.tsx`: The parent component. No changes are likely needed here, as the problem is purely CSS.

**Key Code Snippet (`VideoJS-theme.css`):**

This rule is perfect for desktop but incorrect for mobile. It constrains the width of the video player, creating the centered effect.

```css
.video-js.vjs-vertical.vjs-inline {
  /* For inline vertical videos in feed, constrain the width */
  max-width: min(calc(100vh * 9 / 16), 350px);
  margin: 0 auto;
  aspect-ratio: 9 / 16;
}
```

The `max-width` property is what we need to override for mobile screens to allow the video to expand.

## Suggested Implementation Approaches
<!-- LLM: FILL OUT BELOW - Outline 1-3 distinct strategies with pros/cons -->
**Approach 1: Use a CSS `@media` Query (Recommended)**

*   **How:** We would wrap the existing `.video-js.vjs-vertical.vjs-inline` rule in a `@media (min-width: 768px)` query. This tells the browser to only apply the `max-width` constraint on screens that are 768px or wider (i.e., tablets and desktops). On smaller screens, the rule won't apply, and the video will naturally expand to fill the available width.
*   **Pros:**
    *   It's the standard, most direct way to handle responsive CSS.
    *   Keeps all related styling in one place within the CSS file.
    *   Clean, simple, and has zero performance impact.
*   **Cons:**
    *   None for this use case.

**Approach 2: Use Tailwind's Responsive Prefixes**

*   **How:** Instead of writing a raw media query, we could go into `VideoJS.tsx` and conditionally apply Tailwind classes to the video element. We would use a class like `md:max-w-[350px]` which means "apply this max-width only on medium screens and up."
*   **Pros:**
    *   Keeps styling inline with the component, which can be desirable in a component-based architecture.
    *   Follows the Tailwind CSS methodology.
*   **Cons:**
    *   Requires modifying the component's JSX (`VideoJS.tsx`) in addition to potentially cleaning up the CSS file.
    *   The existing desktop styles are already in a separate `.css` file, so adding responsive styles in a different file (`.tsx`) could make the styling harder to reason about and maintain.

## Initial Implementation Steps
<!-- LLM: FILL OUT BELOW - Draft a preliminary high-level checklist -->
Based on the analysis, **Approach 1 is the most direct and clean solution**. It isolates the change to the CSS file where the original style is located.

- [ ] In `apps/web/components/special/VideoJS-theme.css`, find the `.video-js.vjs-vertical.vjs-inline` style block.
- [ ] Wrap this entire block in a `@media (min-width: 768px)` query.

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
