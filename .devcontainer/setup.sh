#!/usr/bin/env bash
set -euo pipefail

echo "=== Codespace AI Setup Script ==="

# Update package lists
apt-get update

# Install base tools: curl, wget, jq, ripgrep, unzip, build-essential
echo "Installing base tools..."
apt-get install -y --no-install-recommends \
    curl \
    wget \
    jq \
    ripgrep \
    unzip \
    build-essential \
    git \
    apt-transport-https \
    ca-certificates \
    gnupg

# Install Node.js (v20) and npm using nodesource
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Install Python 3 and pip
echo "Installing Python 3 and pip..."
apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv

# Install OpenCode (GitHub's AI coding tool)
echo "Installing OpenCode..."
if [ -n "${OPENCODE_TOKEN:-}" ]; then
    OPENCODE_ARGS="--token ${OPENCODE_TOKEN}"
fi
curl -fsSL https://raw.githubusercontent.com/openocode/cli/main/scripts/install.sh | bash -s -- ${OPENCODE_ARGS} 2>/dev/null || {
    # Fallback: try npm install if available
    npm install -g codeium 2>/dev/null || true
}

# Install GitHub CLI
echo "Installing GitHub CLI..."
type -p curl >/dev/null || (apt-get install -y curl)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt-get update
apt-get install -y gh

# Ensure git is configured with useful defaults
echo "Configuring git..."
git config --global pull.reference true
git config --global init.defaultBranch main

# Install useful global npm packages
echo "Installing global npm packages..."
npm install -g pnpm

# Set up shell configuration (zsh with oh-my-zsh if available)
SHELL_NAME="${SHELL##*/}"
if [ "$SHELL_NAME" != "zsh" ]; then
    echo "Installing zsh..."
    apt-get install -y zsh
    chsh -s $(which zsh) || true
fi

# OpenRouter support via Codespaces secrets
echo "Setting up OpenRouter support..."
if [ -n "${OPENROUTER_API_KEY:-}" ]; then
    echo "export OPENROUTER_API_KEY=${OPENROUTER_API_KEY}" >> /etc/environment
    echo "OpenRouter API key detected in environment"
fi

# Create project directories
mkdir -p /workspaces/project

echo "=== Setup Complete ==="