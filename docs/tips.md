# Tips

Unstructured collection of practical tidbits. Will be organized once patterns emerge.

- **Agents know common CLI tools but guess at unfamiliar ones.** When a tool's syntax changed between versions, agents try the old syntax first, fail, then retry. For uncommon tools they guess blindly. Most annoying in code, where guessed library functions only fail at compilation or runtime.

- **Throw away failed attempts instead of salvaging them.** Add the learnings to the prompt and start fresh. This is often faster and produces better results.

- **Agents can write post-mortems.** Ask them to summarize their session and identify root causes of failure.

- **Don't teach the current agent — record learnings for the next one.** Use instruction files (see `docs/iteration.md`).

- **Just give the agent what it needs.** Provide files, other agents' logs, and quickly jotted down notes.

- **Aim high and bisect.** Try an ambitious task. If it fails, split it until both halves are doable. Or do the part the agent got stuck on yourself, then retry.

- **The newest models know how to use agents.** Previous models wrote bad prompts to other agents. The current generation (opus 4.6, gpt-5.3-codex) has been trained on their own scaffolds and can use agents as tools.

- **Agents are poorly calibrated.** They can be overconfident or underconfident. Empirical feedback (tests, compilation, running the code) helps more than asking the agent to reason harder.

- **Stay close to common conventions to leverage training.** Standard project structures, popular libraries, widely-used CLI tools — agents handle these well by default. Uncommon or novel behavior requires careful prompting.

- **For known concepts, a brief reminder suffices.** "Use the builder pattern" or "apply L'Hôpital's rule" is enough to activate knowledge from training. For new domain knowledge not in the training data, provide detailed actionable explanations with examples. A reference to a concept the agent doesn't know will result in confident guessing.

- **Agents can follow about 50 instructions reliably.** Fewer if they are complex or uncommon. Beyond that, agents start forgetting or hallucinating instructions. Long conversations and large instruction files both contribute to this.

- **Tell the agent to ask clarifying questions.** For complex or vague tasks, instruct the agent to ask questions and highlight potentially overlooked improvements before it starts working. This catches misunderstandings early.

- **Use a second agent to review the first agent's work.** Point it at the PR, the git diff, or the final file, and ask it to highlight confident mistakes, possible improvements, and anything deserving your attention.

- **Context compaction is lossy.** When the context window fills up, scaffolds summarize the history automatically. Claude Code also summarizes user messages, so instructions can drift. For long sessions, keep important instructions in a file the agent can re-read rather than only in chat messages.
