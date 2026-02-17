# Getting Started

## Easiest: GitHub Copilot on github.com

Guide: https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent

No installation required. The agent runs on GitHub's servers, not on your machine. It produces a pull request that you review before merging.

1. Go to github.com and log in.
2. On the dashboard, select "Task" mode.
3. Pick a repository and a model.
4. Describe what you want the agent to do (e.g. "Add a README.md that explains what this project does").
5. The agent works in its own environment, then opens a pull request with the changes.
6. Review the pull request, and merge if you're happy.

Requires a GitHub Copilot Pro subscription or higher.

## Next: Gemini CLI

Guide: https://geminicli.com/docs/get-started/

Runs in your terminal, which you're already comfortable with. Free with a Google account (increased quota with Gemini Pro).

1. Install:
   ```bash
   npm install -g @google/gemini-cli
   ```
2. Create a test folder and enter it:
   ```bash
   mkdir ~/agent-test && cd ~/agent-test
   git init
   ```
3. Run with sandbox enabled (requires Docker):
   ```bash
   gemini --sandbox
   ```
4. Authenticate with your Google account when prompted.
5. Type a prompt, e.g. "Create a Python script that reads a CSV file and prints a summary of each column."
6. Watch the agent work. It will create files, run commands, and show you what it's doing.

The `--sandbox` flag runs the agent inside a Docker container so it cannot modify files outside the project or access your system. See `docs/sandboxes.md` for details.

## All Scaffolds At Once: DevContainer

This repository includes a `.devcontainer/` configuration that sets up a sandboxed environment with Java, npm, and all four agent scaffolds (Claude Code, Codex, Gemini CLI, GitHub Copilot CLI) pre-installed.

**With VS Code:**
1. Install Docker and VS Code with the "Dev Containers" extension.
2. Open this repository in VS Code.
3. When prompted, select "Reopen in Container".
4. Once the container is built, open a terminal and run `claude`, `codex`, `gemini`, or `copilot`.

**With IntelliJ:**
1. Install Docker and the "Dev Containers" plugin from the JetBrains marketplace.
2. Open this repository in IntelliJ.
3. When prompted, select "Reopen in Container".

**With GitHub Codespaces:**
1. Go to this repository on github.com.
2. Click "Code" > "Codespaces" > "Create codespace on main".
3. The codespace builds the devcontainer automatically. All scaffolds are ready to use.

See `docs/sandboxes.md` for more on sandboxing.

For individual scaffold installation without the devcontainer, see `docs/scaffolds.md`.
