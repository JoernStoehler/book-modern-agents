# Sandboxing Agents

## Why Sandbox?

Agents execute tool calls (bash commands, file edits) that can have unintended consequences. A sandbox limits the damage. See the "Can Agents Be Harmful?" section in `README.md` for details.

## Built-in Sandboxes

These come with the scaffolds and require no extra setup. They reduce risk but don't eliminate it.

**Claude Code**: Guide: https://www.anthropic.com/engineering/claude-code-sandboxing. Filesystem and network isolation via OS primitives (bubblewrap on Linux, seatbelt on macOS). Enable with `/sandbox` inside a Claude Code session.

**Codex**: runs tool calls in a sandboxed environment by default. Configurable via the Codex settings.

**Gemini CLI**: Guide: https://geminicli.com/docs/cli/sandbox/. Optional sandbox mode via `gemini --sandbox` or `export GEMINI_SANDBOX=docker` (requires Docker).

**GitHub Copilot**: no built-in sandbox for the CLI.

Built-in sandboxes protect against most accidental file and network access outside the project. They do **not** protect against all attack vectors.

## Web-Based Sandboxes (Managed)

The easiest option: no local Docker or VM setup required. The scaffold runs on someone else's machine.

**Claude Code on the web**: available at claude.ai. Runs in an isolated cloud sandbox, connects to GitHub repos. Each session is fully isolated.

**Codex Web**: available at chatgpt.com/codex. Cloud-based agent execution.

**GitHub Copilot coding agent**: Guide: https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent. Runs on github.com via GitHub Actions. Assign an issue to Copilot and it works in its own ephemeral environment.

**Jules** (Google): available at jules.google.com. Coding agent that works on GitHub issues in its own environment, similar to the Copilot coding agent.

**GitHub Codespaces**: Guide: https://docs.github.com/en/codespaces. A full development environment (VS Code + devcontainer + VM) managed by GitHub. Works with any scaffold you install inside it. Pricing: included in GitHub Copilot plans with limited hours, or pay-as-you-go.

## DevContainers (Local)

Guide: https://code.visualstudio.com/docs/devcontainers/create-dev-container

A devcontainer is a Docker container configured via a `.devcontainer/devcontainer.json` file in your project. The agent runs inside the container, isolated from your host system.

**VS Code**: native support. Open a project with a `.devcontainer/` folder and VS Code offers to reopen in the container.

**IntelliJ IDEA**: install the "Dev Containers" plugin from the JetBrains marketplace. The IDE detects `.devcontainer/devcontainer.json` and offers to reopen in the container.

**Headless (CLI only)**: install the devcontainer CLI and run scaffolds inside without any IDE:
```bash
npm install -g @devcontainers/cli
devcontainer up --workspace-folder /path/to/project
devcontainer exec --workspace-folder /path/to/project claude
```

CLI guide: https://code.visualstudio.com/docs/devcontainers/devcontainer-cli

## DevContainers + Remote Access (Self-Hosted)

For accessing a sandboxed environment from any machine (e.g. a laptop, a tablet), combine a devcontainer with VS Code tunnels:

1. Start the devcontainer on the host machine (e.g. your desktop or a server).
2. Inside the container, install and start a VS Code tunnel: https://code.visualstudio.com/docs/remote/tunnels
3. Connect to the tunnel from any browser or VS Code instance on another machine.

This gives you a Codespaces-like experience on your own hardware.
