# Iterating On The Agent Environment

The goal is not to teach the current agent, but to make the next agent more effective. After each session, you can improve what future agents start with: the instructions they read, the tools available to them, and the knowledge they find in the project.

## Instruction Files

Each scaffold automatically reads instruction files at startup. These are plain text files where you record conventions, common mistakes, project context, and anything else you want every agent to know.

| Scaffold | Global | Project | Extra |
|----------|--------|---------|-------|
| Claude Code | `~/.claude/CLAUDE.md` | `CLAUDE.md` | `.claude/rules/*.md` for topic-specific rules |
| Codex | `~/.codex/AGENTS.md` | `AGENTS.md` | |
| Gemini CLI | `~/.gemini/GEMINI.md` | `GEMINI.md` | Configurable filename via `.gemini/settings.json` |
| GitHub Copilot | `~/.copilot/copilot-instructions.md` | `.github/copilot-instructions.md` | `.github/instructions/*.instructions.md` for role-specific rules |

Guide (Claude Code): https://code.claude.com/docs/en/memory
Guide (Codex): https://developers.openai.com/codex/guides/agents-md/
Guide (Gemini CLI): https://geminicli.com/docs/get-started/configuration/
Guide (Copilot): https://docs.github.com/en/copilot/how-tos/copilot-cli/add-custom-instructions

All scaffolds load these files automatically before the agent starts working. No manual attachment needed.

## What To Put In Instruction Files

Good entries come from friction you or the agent experienced:

- **Conventions**: "Use snake_case for all Python functions", "Always run `make test` before committing"
- **Common mistakes**: "The agent tends to use the old API for library X. Use v2 instead."
- **Project context**: "The java executable will be run on an IBM mainframe with Java 8."
- **Tool usage**: "Use `jq` for JSON processing."
- **Workflow preferences**: "Always write doccomments first before you write the function body."

Bad entries are vague or aspirational: "Write good code" will not result in a change of behavior. "All code must have tests" will confuse if the codebase has few tests yet.

## Installing Tools

Agents know how to use common CLI tools from training. Installing a tool the agent already knows is often enough to unlock a new capability. Examples:

- `jq` for JSON processing
- `java`, `javac`, `mvn` for Java projects
- `pandoc` for document format conversion (markdown, docx, pdf)
- `libreoffice --headless` for converting office documents
- `imagemagick` for image manipulation

Install them in your system or in your devcontainer (see `docs/sandboxes.md`), and the agent will use them when relevant.

Caveat: agents sometimes guess at syntax for tools they half-remember from training. When the argument syntax has changed between versions, agents try the old syntax first, see the error, then look up or guess the new syntax. For uncommon tools, agents may guess blindly before looking up the correct usage. Recording the correct invocation in the instruction file avoids this.

## Chaining Agents

One agent can prepare knowledge for the next:

- Ask an agent to look up online documentation and summarize it into a local file.
- Ask an agent to close gaps or fix errors in the documentation.
- After the session, ask an agent to list sources of friction and errors, and suggest improvements to the instruction files, documentation or environment.

This is especially useful for libraries or APIs the agent doesn't know well from training.
