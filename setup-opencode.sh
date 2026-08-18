#!/usr/bin/env bash
set -euo pipefail

if [ -z "${OPENROUTER_API_KEY:-}" ]; then
  echo "OPENROUTER_API_KEY is not available in this Codespace."
  echo "Add it under GitHub Settings > Codespaces > Secrets and allow this repository."
  exit 1
fi

if ! command -v opencode >/dev/null 2>&1; then
  echo "Installing OpenCode..."
  curl -fsSL https://opencode.ai/install | bash
fi

export PATH="$HOME/.opencode/bin:$PATH"

mkdir -p "$HOME/.local/share/opencode/auth"
printf '{"openrouter":{"type":"api","key":"%s"}}\n' "$OPENROUTER_API_KEY" \
  > "$HOME/.local/share/opencode/auth/auth.json"
chmod 600 "$HOME/.local/share/opencode/auth/auth.json"

echo "OpenCode: $(opencode --version 2>/dev/null || echo installed)"
echo "OpenRouter credentials configured from Codespaces secret."
echo "Run: opencode"
