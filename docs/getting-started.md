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

For other scaffolds (Claude Code, Codex, etc.), see `docs/scaffolds.md` for installation instructions and `docs/sandboxes.md` for how to run them safely.
