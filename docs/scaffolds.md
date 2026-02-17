# Agent Scaffolds

## Claude Code (Anthropic)

Guide: https://docs.anthropic.com/en/docs/claude-code/setup

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

VS Code extension: search for `anthropic.claude-code` in the extensions panel.

IntelliJ plugin: search for "Claude Code" in the plugin marketplace.

## Codex (OpenAI)

Guide: https://developers.openai.com/codex/cli/

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

VS Code extension: search for "Codex" by OpenAI in the extensions panel.

IntelliJ plugin: no official plugin available.

## Gemini CLI (Google)

Guide: https://geminicli.com/docs/get-started/

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

VS Code extension: search for `Google.gemini-cli-vscode-ide-companion` in the extensions panel.

IntelliJ plugin: search for "Gemini Code Assist" in the plugin marketplace.

## GitHub Copilot (Microsoft/GitHub)

Guide: https://docs.github.com/en/copilot/how-tos/copilot-cli/install-copilot-cli

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

VS Code extension: search for "GitHub Copilot" in the extensions panel.

IntelliJ plugin: search for "GitHub Copilot" in the plugin marketplace.
