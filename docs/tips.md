# Tips

## Understanding Agent Behavior

- **Agents know common CLI tools but guess at unfamiliar ones.** When a tool's syntax changed between versions, agents try the old syntax first, fail, then retry. For uncommon tools they guess blindly. Most annoying in code, where guessed library functions only fail at compilation or runtime.

- **Agents are poorly calibrated.** They can be overconfident or underconfident. Empirical feedback (tests, compilation, running the code) helps more than asking the agent to reason harder.

- **Agents can follow about 50 instructions reliably.** Fewer if they are complex or uncommon. Beyond that, agents start forgetting or hallucinating instructions. Long conversations and large instruction files both contribute to this.

- **Stay close to common conventions to leverage training.** Standard project structures, popular libraries, widely-used CLI tools — agents handle these well by default. Uncommon or novel behavior requires careful prompting.

- **For known concepts, a brief reminder suffices.** "Use the builder pattern" or "apply L'Hôpital's rule" is enough to activate knowledge from training. For new domain knowledge not in the training data, provide detailed actionable explanations with examples. A reference to a concept the agent doesn't know will result in confident guessing.

- **The newest models know how to use agents.** Previous models wrote bad prompts to other agents. The current generation (`Opus 4.6`, `GPT-5.3-Codex`) has been trained on their own scaffolds and can use agents as tools.

## Working With Agents

Source for prompting advice: https://code.claude.com/docs/en/best-practices

- **Give the agent a way to verify its work.** Include tests, expected outputs, or commands to check success. Without verification, you become the only feedback loop. E.g. "write a validateEmail function. test standard test cases, positive and negative."

- **Be specific.** Reference files, mention constraints, point to existing patterns. E.g. "look at how HotDogWidget.php works, then follow the same pattern for a calendar widget" is better than "add a calendar widget."

- **Describe symptoms and context, not just the fix you want.** E.g. "inexperienced users on windows report login fails after session timeout, expected is that the login succeeds and/or no session timeout happens" is better than "fix the login"

- **Explore first, then plan, then code.** Use plan mode to separate research from execution. Ask the agent to read and understand before changing anything.

- **Use plan mode for complex or vague tasks.** Having the agent write a plan before it starts working has several benefits: the agent has a file to consult, which keeps it more focused; it discovers blockers, ambiguities, or mistakes earlier; and the user can catch problems before work begins. The downside is one extra step, and agents sometimes fail to stop when the plan turns out wrong in practice, continuing onwards wastefully. All scaffolds support some form of this: Claude Code and Codex have `/plan`, Gemini CLI has an experimental plan mode, and on github.com "Ask" mode serves a similar planning role compared to "Task" mode.

- **Use structured specs for large tasks.** "Current state: [what exists now]. Changes needed: [what should change]." This format makes agents reliable even across many files, because they can check off items instead of guessing scope.

- **Scope investigations.** "Investigate" without bounds leads to the agent reading hundreds of files. Scope it: "look at how auth handles token refresh" not "investigate the auth system."

- **Correct early.** Stop the agent as soon as you see it going off track. After two failed corrections, start fresh with a better prompt.

- **Clear context between unrelated tasks.** Long sessions with irrelevant context degrade performance.

- **Vague prompts are fine for exploration.** "What would you improve in this file?" can surface things you wouldn't have asked about.

- **Remind the agent to ask clarifying questions.** Agents default to guessing rather than asking. Explicitly say "ask me if anything is unclear or surprising".

- **Define triggers where the agent should escalate back to you.** E.g. "if you're unsure about the database schema, stop and ask me" or "if any test fails after your fix, don't keep trying — show me the error."

- **Ask the agent to push back.** "Before you start: push back if this doesn't look good to you." Without this, agents will execute bad plans without objecting.

## Working Across Sessions

- **Throw away failed attempts instead of salvaging them.** Add the learnings to the prompt and start fresh. This is often faster and produces better results.

- **Don't teach the current agent — record learnings for the next one.** Use instruction files (see `docs/iteration.md`).

- **Just give the agent what it needs.** Provide files, other agents' logs, and quickly jotted down notes.

- **Aim high and bisect.** Try an ambitious task. If it fails, split it until both halves are doable. Or do the part the agent got stuck on yourself, then retry.

- **Agents can write post-mortems.** Ask them to summarize their session and identify root causes of failure.

- **Have agents review earlier agents' logs.** Agents can read their own scaffold's conversation logs and extract useful information: what worked, what failed, what prompts were effective. The log format and location varies by scaffold, but agents can look that up.

- **Context compaction is lossy.** When the context window fills up, scaffolds summarize the history automatically. Claude Code also summarizes user messages, so instructions can drift. For long sessions, keep important instructions in a file the agent can re-read rather than only in chat messages.

## Scaling With Multiple Agents

- **Match model tier to subtask complexity.** Use cheap/fast models for mechanical work (parsing, filtering, extracting text) and capable models for judgment calls (reviewing quality, planning, deciding). This applies to sub-agents and to choosing which model to run a session with.

- **Use a second agent to review the first agent's work.** Point it at the PR, the git diff, or the final file, and ask it to highlight confident mistakes, possible improvements, and anything deserving your attention.

- **One sub-agent per file or chunk.** When using sub-agents for review or analysis, assign one file per agent with a shared template. Agents that try to batch too many files produce shallow results.

## When Agents Need Human Help

- Estimating long-term consequences.
- Scope decisions ("should we also change X?").
- Prioritization among competing concerns.
- Domain-specific judgment (which approach, which tradeoffs).
- Judging the quality of their own work directly without empirical feedback.
- Relevant context that's not written down yet.
- Delegating work to agents, planning what work the next agent should do.
