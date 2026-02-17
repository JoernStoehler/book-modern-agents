# Agent Scaffolds

Each scaffold is available in multiple forms. The **CLI** runs in a terminal. **IDE extensions** integrate into VS Code or IntelliJ. **Web** versions run on the provider's servers in a managed sandbox. Some providers also offer **desktop apps**, but these generally have poor sandbox management compared to web or CLI options.

## Claude Code (Anthropic)

Guide: https://docs.anthropic.com/en/docs/claude-code/setup

### CLI

Install (Linux/macOS/WSL):
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Install (Windows PowerShell):
```powershell
irm https://claude.ai/install.ps1 | iex
```

Run:
```bash
cd your-project
claude
```

First run: follow the login prompt. Sign in with a Claude Pro/Max subscription or an API console account.

### IDE Extensions

VS Code: search for `anthropic.claude-code` in the extensions panel.

IntelliJ: search for "Claude Code" in the plugin marketplace.

### Web

Claude Code on the web is available at claude.ai. It runs in an isolated cloud sandbox and connects to GitHub repositories.

## Codex (OpenAI)

Guide: https://developers.openai.com/codex/cli/

### CLI

Install:
```bash
npm i -g @openai/codex
```

Run:
```bash
cd your-project
codex
```

First run: sign in with a ChatGPT Plus/Pro account or an API key.

### IDE Extensions

VS Code: search for `openai.chatgpt` in the extensions panel (the extension is named "Codex").

IntelliJ: no official plugin available.

### Web

Codex Web is available at chatgpt.com/codex.

### Desktop App

The Codex desktop app orchestrates multiple agents. Note: desktop apps generally have poor sandbox management.

## Gemini CLI (Google)

Guide: https://geminicli.com/docs/get-started/

### CLI

Install:
```bash
npm install -g @google/gemini-cli
```

Run:
```bash
cd your-project
gemini
```

First run: select "Login with Google", authenticate in the browser that opens.

### IDE Extensions

VS Code: search for `Google.geminicodeassist` in the extensions panel (the extension is named "Gemini Code Assist").

IntelliJ: search for "Gemini Code Assist" in the plugin marketplace.

### Web

Jules (https://jules.google.com/) is Google's coding agent that works on GitHub issues, similar to the Copilot coding agent.

Google AI Studio (https://aistudio.google.com/) provides a web interface for working with Gemini models.

## GitHub Copilot (Microsoft/GitHub)

Guide: https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli

### CLI

Install:
```bash
npm install -g @github/copilot
```

Or (macOS/Linux):
```bash
curl -fsSL https://gh.io/copilot-install | bash
```

Run:
```bash
cd your-project
copilot
```

First run: type `/login`, follow the browser authentication.

### IDE Extensions

VS Code: search for "GitHub Copilot" in the extensions panel.

IntelliJ: search for "GitHub Copilot" in the plugin marketplace.

### Web

Guide: https://docs.github.com/en/copilot/concepts/agents/coding-agent/about-coding-agent. The Copilot coding agent is available directly on the github.com dashboard. Select "Task" mode, pick a repository and a model (supports models from multiple vendors), and describe what you want. It spins up its own sandbox environment, writes code, runs tests, and opens a pull request. You can also assign a GitHub issue to Copilot to trigger the same workflow.
