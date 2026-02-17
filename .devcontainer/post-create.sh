#!/bin/bash
set -e

echo "Installing agent scaffolds..."

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Codex
npm install -g @openai/codex

# Gemini CLI
npm install -g @google/gemini-cli

# GitHub Copilot CLI
npm install -g @github/copilot

echo "Done. Run 'claude', 'codex', 'gemini', or 'copilot' to get started."
